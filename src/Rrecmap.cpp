#include <Rcpp.h>
#include "recmap.h"

using namespace Rcpp;


// [[Rcpp::export]]
DataFrame recmap(DataFrame df) {
  
  // access the columns
  NumericVector x = df["x"];
  NumericVector y = df["y"];
  NumericVector dx = df["dx"];
  NumericVector dy = df["dy"];
  NumericVector z = df["z"];
  CharacterVector name = df["name"];
  

  //crecmap::crecmap X(Rcpp::as<double>(x));
  crecmap::crecmap X;
  
  // TODO: setting and gettings are pain of the art; fix that asap;
  for (int i=0; i<x.size(); i++){
    X.push(x[i], y[i], dx[i], dy[i], z[i]);
  }
  
  //X.fun();
  X.run();
  
  for (int i=0; i<x.size(); i++){
    crecmap::map_region r = X.get_map_region(i);
    
    x[i] = r.x;
    y[i] = r.y;
    dx[i] = r.dx;
    dy[i] = r.dy;
    z[i] = r.z;
    //name[i] = r.name;
  }

  
  // return a new data frame
  return DataFrame::create(_["x"]= x, _["y"]= y, _["dx"]= dx, _["dy"]= dy,_["z"]= z, _["name"]= name);
}


/*** R
r <- recmap:::.checker_board(2)
class(r) <- "data.frame"
r2 <- recmap(r)
#class(r2) <- "recmapFrame"
#plot(r2)
*/

// sourceCpp("./src/Rrecmap.cpp"); plot(r2)
