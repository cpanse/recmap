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

#define STRICT_R_HEADERS
#include <Rcpp.h>
#include <string>

#include "../inst/include/recmap.cpp"

using namespace Rcpp;
//' @import Rcpp
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


//' Compute a Rectangular Statistical Cartogram
//'
//' @description
//' The input consists of a map represented by overlapping rectangles.
//' The algorithm requires as input for each map region:
//' \itemize{
//'   \item{a tuple of (x, y) values corresponding to the 
//'  (longitude, latitude) position,}
//'   \item{a tuple of (dx, dy) of expansion along (longitude, latitude),}
//'  \item{and a statistical value z.}
//' }
//' The (x, y) coordinates represent the center of the minimal bounding boxes 
//' (MBB), The coordinates of the MBB are derived by adding or subtracting the 
//' (dx, dy) / 2 tuple accordingly. The tuple (dx, dy) also defines the ratio of the 
//' map region. The statistical values define the desired area of each map region.
//'
//' The output is a rectangular cartogram where the map regions are:
//'
//' \itemize{
//'   \item{Non-overlapping,}
//'   \item{connected,}
//'   \item{ratio and area of each rectangle correspond to the desired areas,}
//'   \item{rectangles are placed parallel to the axes.}
//' }
//'
//' The construction heuristic places each rectangle in a way that important spatial 
//' constraints, in particular
//' \itemize{
//'   \item{the topology of the pseudo dual graph,}
//'   \item{the relative position of MBB centers.}
//' }
//' are tried to be preserved.
//'
//' The ratios are preserved and the area of each region corresponds to the as 
//' input given statistical value z.
//'
//' @param V defines the input map regions formatted as \code{\link{data.frame}}
//'  having the column names \code{c('x', 'y', 'dx', 'dy', 'z', 'name')} 
//'  as described above. V could also be considered as the nodes of the pseudo dual.
//'
//' @param E  defines the edges of the map region's pseudo dual graph. 
//'  If \code{E} is not provided, this is the default; the pseudo dual graph is
//'  composed of overlapping rectangles. If used, E must be a
//'  \code{\link{data.frame}} containing two columns named \code{c('u', 'v')}
//'  of type integer referencing the row number of \code{V}.
//'
//' @details The basic idea of the current recmap \emph{implementation}:
//' \enumerate{
//'  \item{Compute the pseudo dual out of the overlapping map regions.}
//'  \item{Determine the \emph{core region} by \code{index <- int(n / 2)}.}
//'  \item{Place region by region along DFS skeleton of pseudo dual starting 
//'  with the \emph{core region}.}}
//'
//' Note: if a rectangle can not be placed, accept a non-\emph{feasible solution}
//' (avoid solutions having a topology error higher than 100)
//' Solving this constellation can be intensive in the computation, and due to the
//' assumably low fitness value the candidate cartogram
//' will be likely rejected by the metaheuristic.
//'
//' \emph{Time Complexity:}
//' The time complexity is \eqn{O(n^2)}, where n is the number of regions.
//' DFS is visiting each map region only once and therefore has 
//' time complexity \eqn{O(n)}. For each placement, a constant number of
//' MBB intersection are called (max 360). MBB check is implemented using
//' \code{std::set}, \code{insert}, \code{upper_bound}, \code{upper_bound} 
//' costs are \eqn{O(\log(n))}{O(log(n))}.
//' However, the worst case for a range query is \eqn{O(n)}, if and only if dx or dy
//' cover the whole x or y range. Q.E.D.
//' 
//' \emph{Performance:}
//' In praxis, computing on a 2.4 GHz Intel Core i7 machine (using only one core), using the 
//' 50 state U.S. map example, recmap can compute approximately 100 cartograms in one second.
//' The number of MBB calls were
//' (Min., Median, Mean, Max)  = (1448, 2534, 3174, 17740), using in each run
//' a different index order using the (\code{\link{sample}}) method.
//' 
//' \emph{Geodetic datum:} the \code{recmap} algorithm is not transforming the 
//' geodetic datum, e.g., WGS84 or Swissgrid.
//' 
//' @return
//' Returns a \code{recmap} S3 object of the transformed map with new coordinates 
//' (x, y, dx, dy) plus additional columns containing information for topology 
//' error, relative position error, and the DFS number.
//' The error values are thought to be used for fitness function of the
//' metaheuristic.
//'
//' @aliases RecMap cartogram all.equal.recmap
//'
//' @author Christian Panse, 2016
//' 
//' @examples
//' map <- checkerboard(2)
//' cartogram <- recmap(map)
//' 
//' map
//' cartogram
//' 
//' op <- par(mfrow = c(1, 2))
//' plot(map)
//' plot(cartogram)
//' 
//' ## US example
//' usa <- data.frame(x = state.center$x,
//'   y = state.center$y,
//'   # make the rectangles overlapping by correcting
//'   # lines of longitude distance.
//'   dx = sqrt(state.area) / 2
//'     / (0.8 * 60 * cos(state.center$y * pi / 180)),
//'   dy = sqrt(state.area) / 2 / (0.8 * 60),
//'   z = sqrt(state.area),
//'   name = state.name)
//' 
//' usa$z <- state.x77[, 'Population']
//' US.Map <- usa[match(usa$name,
//'   c('Hawaii', 'Alaska'), nomatch = 0)  == 0, ]
//' 
//' plot.recmap(US.Map)
//' US.Map |> recmap() |> plot()
//' par(op)
//' 
//' # define a fitness function
//' recmap.fitness <- function(idxOrder, Map, ...){
//'   Cartogram <- recmap(Map[idxOrder, ])
//'   # a map region could not be placed;
//'   # accept only feasible solutions!
//'   if (sum(Cartogram$topology.error == 100) > 0){return (0)}
//'   1 / sum(Cartogram$z / (sqrt(sum(Cartogram$z^2)))
//'     * Cartogram$relpos.error)
//' }
//'
//' @export
// [[Rcpp::export]]
DataFrame recmap(DataFrame V, Rcpp::Nullable<DataFrame> E = R_NilValue) {
  // access the columns
  NumericVector x = V["x"];
  NumericVector y = V["y"];
  NumericVector dx = V["dx"];
  NumericVector dy = V["dy"];


  NumericVector z = V["z"];
  CharacterVector name = V["name"];

  IntegerVector u = IntegerVector();
  IntegerVector v = IntegerVector();

  if (E.isNotNull()) {
	DataFrame pd = DataFrame(E);

  	u = pd("u");
  	v = pd("v");
  }
  

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
  DataFrame dfout = DataFrame::create(_["x"]= cartogram_x,
                           _["y"]= cartogram_y,
                           _["dx"]= cartogram_dx,
                           _["dy"]= cartogram_dy,
                           _["z"]= z,
                           _["name"]= name,
                           _["dfs.num"] = dfs_num,
                           _["topology.error"] = topology_error,
                           _["relpos.error"] = relpos_error,
                           _["relposnh.error"] = relpos_nh_error);
  CharacterVector v2 = {"recmap", "data.frame"};
  dfout.attr("class") = v2;
  return (dfout);
}
