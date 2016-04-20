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

  class crecmap{
  
    typedef std::vector<int> vi;
    typedef std::vector<vi> graph;
    
 
    
    typedef std::vector< map_region > recmapvector; 
    
    graph G;
    recmapvector RecMap;
    int n;
    
  public:
  
    //template < class Tdouble > 
    
    crecmap() { n = 0;}
    
    void push(double x, double y,double dx, double dy, double z){
      
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
    void compute_pseudo_dual();
    void construct_cartogram();
    
  };

}
  
#endif  