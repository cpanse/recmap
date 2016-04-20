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
    std::string name;
  } map_region;

typedef std::vector<int> vi;
typedef std::vector<vi> graph;


  class crecmap{
  
    
    
    typedef std::vector< map_region > recmapvector; 
    
    graph G;
    recmapvector RecMap;
    int n;
    
  public:
  
    //template < class Tdouble > 
    
    crecmap() { n = 0;}
    
    void push(double x, double y, double dx, double dy, double z){
      
      map_region R; 
      
      R.x=x; R.y=y; R.dx=dx; R.dy = dy; R.z =z;
      // R.name = name;
      // not needed for the algorithm
      
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
    
    map_region & get_map_region(int i){
      
        return(RecMap[i]);

    }
    
    // http://stackoverflow.com/questions/17787410/nested-range-based-for-loops
    template<typename C, typename Op1, typename C1>
    void each_unique_pair(C& container, C1& container1, Op1 fun1)
    {
      for(auto it = container.begin(); it != container.end() - 1; ++it)
      {
        for(auto it2 = std::next(it); it2 != container.end(); ++it2)
        {
          fun1(*it, *it2, container1);
          //fun(*it2, *it);
        }
      }
    }
    
    // http://gamemath.com/2011/09/detecting-whether-two-boxes-overlap/
    bool mbb_intersect(const map_region &a, const map_region &b)
    {
      if (a.x + a.dx < b.x - b.dx) return false; // a is left of b
      if (a.x - a.dx > b.x + b.x + b.dx) return false; // a is right of b
      if (a.y + a.dy < b.y - b.dy) return false; // a is above b
      if (a.y - a.dy > b.y + b.dy) return false; // a is below b
      return true; // boxes overlap
    }
    
    // void compute_pseudo_dual(graph &G, recmapvector &RM)
    
    void compute_pseudo_dual(){
      std::vector<double> v;
      
      // this could be the lambda function which determines the PD
      
      each_unique_pair(RecMap, v,
                       
                       [](map_region &a, map_region &b, std::vector<double> &v){
                         
                         //if (f(r0, r1)){
                         
                         if (a.x + a.dx < b.x - b.dx) return false; // a is left of b
                         else if (a.x - a.dx > b.x + b.dx) return false; // a is right of b
                         else if (a.y + a.dy < b.y - b.dy) return false; // a is above b
                         else if (a.y - a.dy > b.y + b.dy) return false; // a is below b
                         
                           v.push_back(1);
                           std::cout << a.x << ", " << a.y << "\t" << a.dx << ", " << a.dy;
                           std::cout << "\t|\t" << b.x << ", " << b.y << "\t" << b.dx << ", " << b.dy << std::endl;
                         return true;
                       });
      
      
      std::cout << "size: "  << v.size() << std::endl;
    }
    
    void construct_cartogram();
    
  };

}
  
#endif  