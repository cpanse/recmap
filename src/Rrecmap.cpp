#include <Rcpp.h>
#include "recmap.h"

using namespace Rcpp;

// [[Rcpp::export]]
double get_angle(double x0, double y0, double x1, double y1){
  crecmap::map_region a, b;
  a.x = x0; a.y = y0;
  b.x = x1; b.y = y1;
  
  
  return (crecmap::get_angle(a,b));
}

// [[Rcpp::export]]
DataFrame place_rectanle(double x0, double y0, double dx0, double dy0, double dx1, double dy1, double alpha){
  crecmap::map_region a, b, c;
  
  a.x = x0; a.y = y0; a.dx = dx0; a.dy = dy0;
  c.dx = dx1; c.dy = dy1;
  
  crecmap::place_rectanle(a, alpha, c);
  return DataFrame::create(_["x"]= c.x, _["y"]= c.y, _["dx"]= dx1, _["dy"]= dy1);
}

// [[Rcpp::export]]
DataFrame recmap(DataFrame df) {
  
  // access the columns
  NumericVector x = df["x"];
  NumericVector y = df["y"];
  NumericVector dx = df["dx"];
  NumericVector dy = df["dy"];
  NumericVector z = df["z"];
  CharacterVector name = df["name"];
  
  NumericVector cartogram_x(x.size()); 
  NumericVector cartogram_y(x.size()); 
  NumericVector cartogram_dx(x.size()); 
  NumericVector cartogram_dy(x.size()); 
  
  NumericVector dfs_num(x.size()); 
  NumericVector topology_error(x.size()); 
  NumericVector relpos_error(x.size()); 
  //crecmap::crecmap X(Rcpp::as<double>(x));
  crecmap::RecMap X;
  
  // TODO(cp): setting and gettings are pain of the art; fix that asap;
  for (int i=0; i<x.size(); i++){
    std::string sname = Rcpp::as<std::string>(name[i]);
    X.push(x[i], y[i], dx[i], dy[i], z[i], sname);
  }
  
  X.run();
  
  for (int i=0; i<x.size(); i++){
    crecmap::map_region r = X.get_map_region(i);
    
    cartogram_x[i] = r.x;
    cartogram_y[i] = r.y;
    cartogram_dx[i] = r.dx;
    cartogram_dy[i] = r.dy;
    //z[i] = r.z;
    dfs_num[i] = r.dfs_num;
    topology_error[i] = r.topology_error;
    relpos_error[i] = r.relative_position_error;
  }

  
  while(!X.warnings_empty()){warning(X.warnings_pop());}
  
  //Rcpp::exception
    
  // return a new data frame
  return DataFrame::create(_["x"]= cartogram_x, 
                           _["y"]= cartogram_y,
                           _["dx"]= cartogram_dx, 
                           _["dy"]= cartogram_dy,
                           _["z"]= z, 
                           _["name"]= name, 
                           _["dfs.num"] = dfs_num,
                           _["topology.error"] = topology_error,
                           _["relpos.error"] = relpos_error);
}


/*** R
r <- recmap:::.checker_board(2)
class(r) <- "data.frame"
r2 <- recmap(r)
#class(r2) <- "recmapFrame"
#plot(r2)
*/

// sourceCpp("./src/Rrecmap.cpp"); plot(r2)
