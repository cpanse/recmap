jss2711_figure4 <- function(nrep = 5, size = c(2, 3, 5, 10, 20)){
  recmap_debug_code <- '
  // [[Rcpp::plugins(cpp11)]]
  
  #include <Rcpp.h>
  #include <string>
  #include <recmap.h>
  
  using namespace Rcpp;

  // [[Rcpp::depends(recmap)]]
  // [[Rcpp::export]]
  int recmap_debug(DataFrame df, bool map_region_intersect_multiset = true) {
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
    NumericVector relpos_nh_error(x.size());
   
    crecmap::RecMap X;
    X.set_map_region_intersect_multiset(map_region_intersect_multiset);
    
    for (int i = 0; i < x.size(); i++) {
      std::string sname = Rcpp::as<std::string>(name[i]);
      X.push_region(x[i], y[i], dx[i], dy[i], z[i],  sname);
    }
    
    X.run(true);
    
    return(X.get_intersect_count());
  }
  '
  
  sourceCpp(code = recmap_debug_code, rebuild = TRUE, verbose = TRUE)
  
  do.call('rbind', lapply(size, function(size){
    set.seed(1);
    CB <- checkerboard(size); 

    do.call('rbind',lapply(rep(size, nrep), function(n){

      CB.smp <- CB[sample(nrow(CB), nrow(CB)), ]
      start_time <- Sys.time()
      ncall.multiset <- recmap_debug(CB.smp, map_region_intersect_multiset = TRUE)
      end_time <- Sys.time()
      diff_time.multiset <- as.numeric(difftime(end_time, start_time, units = "secs"))


      start_time <- Sys.time()
      ncall.list <- recmap_debug(CB.smp, map_region_intersect_multiset = FALSE)
      end_time <- Sys.time()
      diff_time.list <- as.numeric(difftime(end_time, start_time, units = "secs"))

      #do.call('rbind', list(data.frame(algorithm = "multiset", number = ncall.multiset, size = nrow(CB)),
      #  data.frame(algorithm = "list", number = ncall.list, size = nrow(CB))))
      #data.frame(algorithm = "multiset", number = ncall.multiset, size = nrow(CB))
      rv <- rbind(data.frame(number = ncall.multiset, algorithm="multiset", size = nrow(CB), time_in_secs = diff_time.multiset),
        data.frame(number = ncall.list, algorithm="list", size = nrow(CB), time_in_secs =  diff_time.list))

      rv$machine <- Sys.info()['machine']
      rv$sysname <- Sys.info()['sysname']
      rv
      }))
    }))
}
