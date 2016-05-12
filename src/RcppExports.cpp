// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// get_angle
double get_angle(double x0, double y0, double x1, double y1);
RcppExport SEXP recmap_get_angle(SEXP x0SEXP, SEXP y0SEXP, SEXP x1SEXP, SEXP y1SEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< double >::type x0(x0SEXP);
    Rcpp::traits::input_parameter< double >::type y0(y0SEXP);
    Rcpp::traits::input_parameter< double >::type x1(x1SEXP);
    Rcpp::traits::input_parameter< double >::type y1(y1SEXP);
    __result = Rcpp::wrap(get_angle(x0, y0, x1, y1));
    return __result;
END_RCPP
}
// place_rectanle
DataFrame place_rectanle(double x0, double y0, double dx0, double dy0, double dx1, double dy1, double alpha);
RcppExport SEXP recmap_place_rectanle(SEXP x0SEXP, SEXP y0SEXP, SEXP dx0SEXP, SEXP dy0SEXP, SEXP dx1SEXP, SEXP dy1SEXP, SEXP alphaSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< double >::type x0(x0SEXP);
    Rcpp::traits::input_parameter< double >::type y0(y0SEXP);
    Rcpp::traits::input_parameter< double >::type dx0(dx0SEXP);
    Rcpp::traits::input_parameter< double >::type dy0(dy0SEXP);
    Rcpp::traits::input_parameter< double >::type dx1(dx1SEXP);
    Rcpp::traits::input_parameter< double >::type dy1(dy1SEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    __result = Rcpp::wrap(place_rectanle(x0, y0, dx0, dy0, dx1, dy1, alpha));
    return __result;
END_RCPP
}
// recmap
DataFrame recmap(DataFrame df);
RcppExport SEXP recmap_recmap(SEXP dfSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< DataFrame >::type df(dfSEXP);
    __result = Rcpp::wrap(recmap(df));
    return __result;
END_RCPP
}
// recmap_linear
DataFrame recmap_linear(DataFrame df);
RcppExport SEXP recmap_recmap_linear(SEXP dfSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< DataFrame >::type df(dfSEXP);
    __result = Rcpp::wrap(recmap_linear(df));
    return __result;
END_RCPP
}
