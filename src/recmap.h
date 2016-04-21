#ifndef RECMAP_H
#define RECMAP_H
  
#include <stdexcept>
#include <iterator>
#include <algorithm>
#include <vector>

#include <iostream>
#include <string>
#include <iterator>
#include <sstream>
  
  /*
  
  Authors   :  <Christian.Panse@gmail.com>
  
  $HeadURL: $
  $Id: $
  
  */
  
  
namespace crecmap{


  typedef struct {
    double x, y, dx, dy, z;
    int id;
    std::string name;
  } map_region;


typedef std::vector<std::vector<int>> graph;

  class crecmap{
  
    typedef std::vector<map_region> recmapvector; 
    
    graph PD0;
    recmapvector RecMap;
    int n;
    
  public:
  
    //template < class Tdouble > 
    
    crecmap() { n = 0;}
    
    void push(double x, double y, double dx, double dy, double z){
      
      map_region R; 
      
      R.x=x; R.y=y; R.dx=dx; R.dy = dy; R.z =z;
      R.id = n;
     
      // R.name = name;
      // not needed for the algorithm
      PD0.push_back({});
      RecMap.push_back(R);
      n++;
      
      if (n != RecMap.size()){
        
      }
    }
    
    int get_size(){
      return n;
    }
    
    void fun(){
      std::for_each(RecMap.begin(), RecMap.end(), 
                    [](map_region &r){std::swap(r.x, r.y);});
    }
    
    
    /*  TODO: this can not work 
     *  map_region& operator[](const int i){
     * return (i * sizeof(map_region))}
     */
    
    map_region& get_map_region(int i){
        return(RecMap[i]);
    }
    
    // http://stackoverflow.com/questions/17787410/nested-range-based-for-loops
    template<typename C, typename Op1, typename C1>
    void each_unique_pair(C& container, C1& container1, Op1 fun1){
      for(auto it = container.begin(); it != container.end() - 1; ++it)
        for(auto it2 = std::next(it); it2 != container.end(); ++it2)
          fun1(*it, *it2, container1);
    }
    
    void compute_pseudo_dual(graph &G, recmapvector &M){
      each_unique_pair(M, G,
                       [](map_region &a, map_region &b, graph &G){
         /*
          *  http://gamemath.com/2011/09/detecting-whether-two-boxes-overlap/
          */
                         if (a.x + a.dx < b.x - b.dx) return false; // a is left of b
                         else if (a.x - a.dx > b.x + b.dx) return false; // a is right of b
                         else if (a.y + a.dy < b.y - b.dy) return false; // a is above b
                         else if (a.y - a.dy > b.y + b.dy) return false; // a is below b
                         // add edges tp pseudo dual graph iff boxes are connected 
                          G[a.id].push_back(b.id);
                          G[b.id].push_back(a.id);
                          // std::cout << "pseudo-dual graph\t" << a.x << ", " << a.y << "\t" << a.dx << ", " << a.dy;
                          // std::cout << "\t-\t" << b.x << ", " << b.y << "\t" << b.dx << ", " << b.dy << std::endl;
                         return true;
                       });
    }
    
    void construct_cartogram(){
      
    }
  
    void run(){
      compute_pseudo_dual(PD0, RecMap);
   
      for (map_region r: RecMap){
        std::cout << std::endl << r.id << "\t(" << r.x << ", " << r.y << ")" << std::endl;
        for (int i: PD0[r.id]){
          std::cout << " " <<  i ;
        }
      }
      
      
      for (int i = 0; i <= RecMap.size(); i++){
        map_region r = RecMap[i];
        std::cout << r.id << " ";
      }
      std::cout << std::endl;
    }//run  
  };
}// namespace
  
#endif  