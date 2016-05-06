//
// This file is part of recmap.
// 
// recmap is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// recmap is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//  
// You should have received a copy of the GNU General Public License
// along with recmap.  If not, see <http://www.gnu.org/licenses/>.

//  Authors   :  Christian Panse <Christian.Panse@gmail.com> 
//  2016-04-19/20/21/22 Bristol, UK

#ifndef RECMAP_H
#define RECMAP_H
  
#include <stdexcept>
#include <iterator>
#include <algorithm>
#include <vector>
#include <stack>
#include <list>
#include <iostream>
#include <string>
#include <iterator>
#include <sstream>
#include <cmath>
#include <set>
  

  
namespace crecmap{

  // keeps map and pseudo dual
  typedef struct {
    double x, y, dx, dy, z;
    int id;
    double area_desired;
    int placed;
    std::string name;
    std::vector<int> connected;
    double topology_error;
    double relative_position_error;
    double relative_position_neighborhood_error;
    int dfs_num;
  } map_region;


struct mbb_node {
  double key;
  int id;
  
  mbb_node(const double& strKey = 0, const int& intId = 0)
    : key(strKey),
      id(intId) {}
  
  bool operator<(const mbb_node& rhs) const {
    return key < rhs.key;
  }
};

  // use it as sorted list 
  // insert/upper_bound: O(ln(n))
  typedef struct {
    double max_dx;
    double max_dy;
    std::set<mbb_node> x;
    std::set<mbb_node> y;
  } mbb_set;

 typedef std::vector<map_region> recmapvector; 

 
  // http://en.cppreference.com/w/cpp/numeric/math/atan2
  double get_angle(const map_region &a, const map_region &b){
    double dx = b.x - a.x;
    double dy = b.y - a.y;
    
    double alpha = std::atan2(dx, dy);
    return (alpha);
  }

  // http://gamemath.com/2011/09/detecting-whether-two-boxes-overlap/
  // TODO(cp): think of an eps value
  bool mbb_check(const map_region &a, const map_region &b){
    
    if (a.x + a.dx < b.x - b.dx) return false; // a is left of b
    else if (a.x - a.dx > b.x + b.dx) return false; // a is right of b
    else if (a.y + a.dy < b.y - b.dy) return false; // a is above b
    else if (a.y - a.dy > b.y + b.dy) return false; // a is below b
    
    // rectangles can touch each other but do not overlap
    return true;
  }
  
 
 
  // computes the new x-y value on the cartogram map region c
  // map_region a has a fix position
  // uses c.dx and c.dy for computation
  // TODO(cp): consider giving eps als argument
  void place_rectanle(const map_region &a, double alpha, map_region &c){
    double tanx, tany;
    double eps = 0.01;
    
    double dy = a.dy + c.dy + eps;
    double dx = a.dx + c.dx + eps;
    
    if (std::sin(alpha) >= 0 & std::cos(alpha) >= 0){
      // Quad I
      tanx = a.x + (dx * std::tan(alpha));
      tany = a.y + (dy * std::tan(PI/2 - alpha));  
      
      c.x = a.x + dx;
      c.y = a.y + dy;
      
      // there are always two intersection; choose the right one
      if (tany >= c.y) c.x = tanx;
      else c.y = tany;

    } else if (std::sin(alpha) >= 0 && std::cos(alpha) < 0) {
      // Quad II
      tanx = a.x + (dx * std::tan(PI - alpha));
      tany = a.y - (dy * std::tan(alpha - PI/2));
      
      c.x = a.x + dx;
      c.y = a.y - dy;
      
      if (tanx <= c.x) c.x = tanx;
      else c.y = tany;
      
    } else if (std::sin(alpha) < 0 && std::cos(alpha) < 0) {
      // Quad III
      tanx = a.x - (dx * std::tan(alpha - PI));
      tany = a.y - (dy * std::tan(3 * PI / 2 - alpha));  
      
      c.x = a.x - dx;
      c.y = a.y - dy;

      if (tany > c.y) c.y = tany;
      else c.x = tanx;
      
    } else if (std::sin(alpha) < 0 && std::cos(alpha) >  0) {
      // Quad IV
      tanx = a.x - (dy * std::tan(2 * PI - alpha));
      tany = a.y + (dx * std::tan(alpha - 3 * PI /2));  
      
      c.x = a.x - dx;
      c.y = a.y + dy;
      
      if (tanx < c.x) c.y = tany;
      else c.x = tanx;
      
    } else {
      // error
      }
      
  }
  
  // http://stackoverflow.com/questions/17787410/nested-range-based-for-loops
  template<typename C, typename Op1>
  void each_unique_pair(C& container, Op1 fun1){
    for(auto it = container.begin(); it != container.end() - 1; ++it)
      for(auto it2 = std::next(it); it2 != container.end(); ++it2)
        fun1(*it, *it2, container);
  }
  
  
  class RecMap{
    recmapvector Map;
    recmapvector Cartogram;
    mbb_set MBB;
    int intersect_count;
    
    int num_regions;
    
    std::list<std::string> msg;
    std::list<std::string> warnings;
    
  public:
  
    //template < class Tdouble > 
    
    RecMap() { 
        num_regions = 0;     
        MBB.max_dx = 0;
        MBB.max_dy = 0;
        intersect_count = 0;
        }
    
    void push(double x, double y, double dx, double dy, double z, std::string name){
      
      map_region R, R1; 
      
      R.x=x; R.y=y; R.dx=dx; R.dy = dy; R.z =z;
      R.id = num_regions;
      R.area_desired = -1;
      R.connected = {};
      R.placed = 1;
      R.name = name;
      R.dfs_num = -1;
      
      R1.x=-1; R1.y=-1; R1.dx = dx; R1.dy = dy; R1.z =z;
      R1.id = num_regions;
      R1.area_desired = -1;
      R1.connected = {};
      R1.placed = 0;
      R1.name = name;
      R1.dfs_num = -1;
      R1.topology_error = 100;
      // R.name = name;
      // not needed for the algorithm
     
      Map.push_back(R);
      Cartogram.push_back(R1);
      num_regions++;
      
      if (num_regions != Map.size()){
        // TODO(cp): call an exception
      }
    }
    
    std::string warnings_pop(){
      std::string s =warnings.front(); warnings.pop_front();
      return s;
    }
    
    bool warnings_empty(){return warnings.empty();}
    
    int get_size(){
      return num_regions;
    }
    
    int get_intersect_count(){
      return intersect_count;
    }
    
    /*  TODO: Can that really work?
     *  map_region& operator[](const int i){
     * return (i * sizeof(map_region))}
     */
    map_region& get_map_region(int i){
        return(Cartogram[i]);
    }
    
    
    void ComputePseudoDual(recmapvector &M){
      each_unique_pair(M, [this](map_region &a, map_region &b, recmapvector &M){
                         // add edges tp pseudo dual graph iff boxes are connected 
                         if (mbb_check(a,b)){
                           M[a.id].connected.push_back(b.id);
                           M[b.id].connected.push_back(a.id);
                         }
                       });
    }
    

    // taken from the CartoDraw scanline approach date back to yr2000
    void ComputeDesiredArea(recmapvector &M, recmapvector &C){
      double sum_z = 0.0;
      double sum_area = 0.0;
      
      std::for_each(M.begin(), M.end(), [&] (map_region &r) {sum_z += r.z;});
      std::for_each(M.begin(), M.end(), [&] (map_region &r) {sum_area += (4 * r.dx * r.dy);});
      
      std::for_each(C.begin(), C.end(), [&] (map_region &r) {
        double area_desired = r.z * sum_area / sum_z;
        double ratio = r.dy / r.dx;
        r.dx = sqrt(area_desired / (4 * ratio));
        r.dy = r.dx * ratio;
        });
    }
    
    
    // TODO(cp): has to be implemented
    int ComputeCoreRegion(recmapvector &M, recmapvector &C){
      
      int core_region_id = num_regions / 2;
      
      C[core_region_id].x = M[core_region_id].x;
      C[core_region_id].y = M[core_region_id].y;
      C[core_region_id].placed++;
        
      mbb_node mn;
      mn.key = C[core_region_id].x; mn.id = C[core_region_id].id;
      MBB.x.insert(mn);
      
      mn.key = C[core_region_id].y; mn.id = C[core_region_id].id;
      MBB.y.insert(mn);
      
      MBB.max_dx = C[core_region_id].dx;
      MBB.max_dy = C[core_region_id].dy;
      
      return core_region_id;
    }
    
    bool map_region_intersect(const recmapvector &C, const map_region &a){
      // TODO(cp): use std::lower_bound(...); 
      // but howto we get a sorted array suing STL? 
      for (map_region b : C){
        if (a.id != b.id && b.placed > 0){
        
        intersect_count++;
        if(mbb_check(a, b)){

          return true;
        }}
      }
     
    return false;
    }
    
    bool map_region_intersect_set(recmapvector &C, const mbb_set &S, const map_region &a){
      
      
      auto lower_x = std::lower_bound(S.x.begin(), S.x.end(), 
                                      a.x - a.dx - S.max_dx, 
                                      [](const mbb_node& f1, const mbb_node& f2) { return f1.key < f2.key; });
      
      auto upper_x = std::upper_bound(S.x.begin(), S.x.end(), 
                                      a.x + a.dx + S.max_dx, 
                                      [](const mbb_node& f1, const mbb_node& f2) { return f1.key < f2.key; });
      
      auto lower_y = std::lower_bound(S.y.begin(), S.y.end(), 
                                      a.y - a.dy - S.max_dy, 
                                      [](const mbb_node& f1, const mbb_node& f2) { return f1.key < f2.key; });
      
      auto upper_y = std::upper_bound(S.y.begin(), S.y.end(), 
                                      a.y + a.dy + S.max_dy, 
                                      [](const mbb_node& f1, const mbb_node& f2) { return f1.key < f2.key; });
      
      //std::cout  << "* (" << S.x.size() << "; "<< std::distance(lower_x, upper_x) << "; "<< std::distance(lower_y, upper_y) <<""")\t";
      for(auto it_x = lower_x; it_x != upper_x; ++it_x){
        intersect_count++;
       // std::cout  << (*it_x).id << "\t";
        if ((*it_x).id != a.id &&  mbb_check(a, C[(*it_x).id])){
          //std::cout << std::endl;
          return true;
        }
      }
      //std::cout << std::endl;
      for(auto it_y = lower_y; it_y != upper_y; ++it_y){
        intersect_count++;
        if ((*it_y).id != a.id && mbb_check(a, C[(*it_y).id])){
          return true;
        }
      }
      
      return false;
    }

    
    // place rectangle around predecessor_region_id if this violates the 
    // constrain do a bfs until the box can be placed. 
    bool PlaceRectangle(recmapvector &M, recmapvector &C, int region_id){

      double alpha0, alpha;
      mbb_node mn;
  
      //map_region candidate;
      double beta_sign = 1.0;
      
      // strategy one: try to place it in the neighborhood
      for (double beta = 0.0; beta <=  PI && C[region_id].placed == 0; beta += PI/180){
        
        // iterate over all already placed connected rectangles
        for (int adj_region_id : M[region_id].connected){

          if (C[adj_region_id].placed > 0 ){
            
            alpha0 = get_angle(M[adj_region_id], M[region_id]);
            
            alpha = alpha0 + (beta_sign * beta);
            beta_sign *= -1;

            place_rectanle(C[adj_region_id], alpha, C[region_id]);
              
            
            // this is to enable the linear scan
            // if (!map_region_intersect(C, C[region_id])) {
            if (!map_region_intersect_set(C, MBB, C[region_id])){
              C[region_id].placed++;
              C[region_id].topology_error = 0;
              
              mn.key = C[region_id].x; mn.id = C[region_id].id;
              MBB.x.insert(mn);
              
              mn.key = C[region_id].y; mn.id = C[region_id].id;
              MBB.y.insert(mn);
              
              if (C[region_id].dx > MBB.max_dx) {MBB.max_dx = C[region_id].dx;}
              if (C[region_id].dy > MBB.max_dy) {MBB.max_dy = C[region_id].dy;}
              
              
              // update dual graph
              C[adj_region_id].connected.push_back(region_id);
              C[region_id].connected.push_back(adj_region_id);
              return true;
            }
          }
        } // END for (int adj_region_id : M[region_id].connected)
      }    
      
      // make it as not placed
      C[region_id].x = -1;
      C[region_id].y = -1;
      warnings.push_back(M[region_id].name + " could not be placed on the first attempt;");
      return false;
    }
    
    
    bool PlaceRectangle_bfs(recmapvector &M, recmapvector &C, int region_id){
        std::list<int> bfs_list;
        std::vector<int> visited(M.size(), 0);
        std::vector<int> bfs_num(M.size(), 0);
        
        double alpha0, alpha;
        double beta_sign = 1.0;
        
    

        visited[region_id]++;
        
        
        for (int adj_region_id : M[region_id].connected){
          
          if (C[adj_region_id].placed > 0 && visited[adj_region_id] == 0){
            warnings.push_back( M[region_id].name + "\t--\t" + M[adj_region_id].name );
            bfs_list.push_back(adj_region_id);
            
            }
        }

        int w;
      while(!bfs_list.empty()){
        
        w = bfs_list.front(); bfs_list.pop_front();
        visited[w]++;
        
        for (int adj_region_id : M[w].connected){
          if (C[adj_region_id].placed > 0){
            bfs_list.push_back(adj_region_id);
          }
        }
        
        alpha0 = get_angle(M[w], M[region_id]);
        
        for (double beta = 0.0; beta <=  PI; beta += PI/180){
          alpha = alpha0 + (beta_sign * beta);
          beta_sign *= -1;
        
        
          place_rectanle(C[w], alpha, C[region_id]);
          
          
          
          if (!map_region_intersect(C, C[region_id])) {
            C[region_id].placed++;
            C[region_id].topology_error = 0;
            C[w].connected.push_back(region_id);
            C[region_id].connected.push_back(w);
            
            warnings.push_back(C[region_id].name + " is now a neighbour of");
            for(int j : C[region_id].connected){
              warnings.push_back("\t" + C[j].name);
            }
            return true;
          }
          

      }
      }
      warnings.push_back(M[region_id].name + " could not be placed. RecMap MP2 failed! please report.");
      
      C[region_id].x = -1;
      C[region_id].y = -1;
      
      return false;
    }
    
    
    // dfs exporer of existing map M / placement of rectangles in cartogram C
    void DrawCartogram(recmapvector &M, recmapvector &C, int core_region_id){
      std::list<int> stack;
      std::vector<int> visited(num_regions, 0);
      std::vector<int> dfs_num(num_regions, 0);

      int dfs_num_counter = 0;
      int current_region_id = core_region_id;
      stack.push_back(current_region_id);
      visited[current_region_id]++;
      //
      //int predecessor_region_id;
        
      while (stack.size()  > 0){
        //predecessor_region_id = current_region_id;
        current_region_id = stack.back() ; stack.pop_back();
        dfs_num[current_region_id] = dfs_num_counter++;
        C[current_region_id].dfs_num = dfs_num[current_region_id];

        //if (predecessor_region_id != current_region_id)
        
        if (current_region_id != core_region_id){
        if (!PlaceRectangle(M, C, current_region_id)){
          // stack.push_front(current_region_id);
          //PlaceRectangle_bfs(M, C, current_region_id);
        }}

        for(int adj_region_id: M[current_region_id].connected){
          if (visited[adj_region_id] == 0) {
            visited[adj_region_id]++;
            stack.push_back(adj_region_id);
            //dfs_num[adj_region_id] = dfs_num_counter++;
            // C[adj_region_id].dfs_num = dfs_num[adj_region_id];
          }
        }
      } // while
      
      
      std::for_each(C.begin(), C.end(), [&] (map_region &r) {
        if (r.placed == 0){
          PlaceRectangle(M, C, r.id);
          if (r.placed == 0){
            warnings.push_back(r.name + " was not placed!!");
          }
          //
        }});
    }
  
    
    bool CheckConnectedComponents(const recmapvector &M){
      // t.b.implemented
      return true;
    }
    
    
    
    void ComputeError(const recmapvector &M, recmapvector &C){
      double gammaM, gammaC, delta;
      
      for (map_region a : M){
        for (map_region b : M){
          gammaM = get_angle(M[a.id], M[b.id]);
          gammaC = get_angle(C[a.id], C[b.id]);
          delta = fabs (gammaC - gammaM) / C.size();
          C[a.id].relative_position_error += delta;
          
        }
        
        for (auto idx : a.connected){
          gammaM = get_angle(M[a.id], M[idx]);
          gammaC = get_angle(C[a.id], C[idx]);
          delta = fabs (gammaC - gammaM) / a.connected.size();
          C[a.id].relative_position_neighborhood_error += delta;
        }
      }
    }
    
    void run(){
      
      ComputePseudoDual(Map);
      
      // CheckConnectedComponents(Map))
      
      ComputeDesiredArea(Map, Cartogram);
      
      int core_region_id = ComputeCoreRegion(Map, Cartogram);
      msg.push_back("CORE REGION: " + Map[core_region_id].name);
     
      DrawCartogram(Map, Cartogram, core_region_id);
      
      ComputeError(Map, Cartogram);
  
      // determine core region to start
      // dfs 
      
    }//run  
  };
}// namespace
  
#endif  
