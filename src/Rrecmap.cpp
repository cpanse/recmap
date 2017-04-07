//  Copyright 2016 <Christian.Panse@gmail.com>
//
// This file is part of the recmap package on CRAN.
// https://CRAN.R-project.org/package=recmap
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


//  Author:  Christian Panse <Christian.Panse@gmail.com>
//  2016-04-19/20/21/22 ACCU2016 Bristol, UK
//  see also: https://arxiv.org/abs/1606.00464

#include <Rcpp.h>
#include <string>
#include "recmap.h"

using namespace Rcpp;

// [[Rcpp::export]]
double get_angle(double x0, double y0, double x1, double y1) {
  crecmap::map_region a, b;
  a.x = x0; a.y = y0;
  b.x = x1; b.y = y1;


  return (crecmap::get_angle(a, b));
}

// [[Rcpp::export]]
DataFrame place_rectangle(double x0, double y0, double dx0, double dy0,
                         double dx1, double dy1, double alpha) {
  crecmap::map_region a, b, c;

  a.x = x0; a.y = y0; a.dx = dx0; a.dy = dy0;
  c.dx = dx1; c.dy = dy1;

  crecmap::place_rectangle(a, alpha, c);
  return DataFrame::create(_["x"]= c.x, _["y"]= c.y, _["dx"]= dx1,
                           _["dy"]= dy1);
}

// [[Rcpp::export]]
DataFrame recmap_(DataFrame df, DataFrame pd) {
  // access the columns
  NumericVector x = df["x"];
  NumericVector y = df["y"];
  NumericVector dx = df["dx"];
  NumericVector dy = df["dy"];


  NumericVector z = df["z"];
  CharacterVector name = df["name"];
  
  IntegerVector u = pd("u");
  IntegerVector v = pd("v");

  NumericVector cartogram_x(x.size());
  NumericVector cartogram_y(x.size());
  NumericVector cartogram_dx(x.size());
  NumericVector cartogram_dy(x.size());

  NumericVector dfs_num(x.size());
  NumericVector topology_error(x.size());
  NumericVector relpos_error(x.size());
  NumericVector relpos_nh_error(x.size());
  // crecmap::crecmap X(Rcpp::as<double>(x));
  crecmap::RecMap X;

  //  TODO(cp): setting and gettings are not optimal
  //    think about operating on the R allocated memory and avoid copying.
  for (int i = 0; i < x.size(); i++) {
    std::string sname = Rcpp::as<std::string>(name[i]);
    X.push_region(x[i], y[i], dx[i], dy[i], z[i],  sname);
  }

  if (u.size() > 0 && v.size() >0){
    for (int i = 0; i < u.size(); i++) {
      X.push_pd_edge(u[i] - 1, v[i] - 1);
      X.push_pd_edge(v[i] - 1, u[i] - 1);
    }
    X.run(false);
  }else{
    X.run(true);
  }
  
  
  // Rcpp::Rcout << "Number of mbb intersection test calls =  "
  // << X.get_intersect_count() << "\n";
  for (int i = 0; i < x.size(); i++) {
    crecmap::map_region r = X.get_map_region(i);

    cartogram_x[i] = r.x;
    cartogram_y[i] = r.y;
    cartogram_dx[i] = r.dx;
    cartogram_dy[i] = r.dy;

    dfs_num[i] = r.dfs_num;
    topology_error[i] = r.topology_error;
    relpos_error[i] = r.relative_position_error;
    relpos_nh_error[i] = r.relative_position_neighborhood_error;
  }


  while (!X.warnings_empty()) { warning(X.warnings_pop()); }

  // Rcpp::exception

  // return a new data frame
  return DataFrame::create(_["x"]= cartogram_x,
                           _["y"]= cartogram_y,
                           _["dx"]= cartogram_dx,
                           _["dy"]= cartogram_dy,
                           _["z"]= z,
                           _["name"]= name,
                           _["dfs.num"] = dfs_num,
                           _["topology.error"] = topology_error,
                           _["relpos.error"] = relpos_error,
                           _["relposnh.error"] = relpos_nh_error);
}


/*** R
Map <- recmap:::.checker_board(2)
Cartogram <- recmap(r)
*/

// sourceCpp("./src/Rrecmap.cpp"); plot(r2)
