#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP recmap_get_angle(SEXP, SEXP, SEXP, SEXP);
extern SEXP recmap_place_rectangle(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP recmap_recmap_(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"recmap_get_angle",       (DL_FUNC) &recmap_get_angle,       4},
    {"recmap_place_rectangle", (DL_FUNC) &recmap_place_rectangle, 7},
    {"recmap_recmap_",         (DL_FUNC) &recmap_recmap_,         2},
    {NULL, NULL, 0}
};

void R_init_recmap(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}

