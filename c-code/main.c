#include <stdio.h>
#include "cutest.h"

int MAINENTRY() {
  double *x, *bl, *bu;
  double *y = 0, *cl = 0, *cu = 0;
  logical *equatn, *linear;
  integer efirst = 0, lfirst = 0, nvfirst = 0;
  char pname[10], *vnames, *cnames;
  char fname[10] = "OUTSDIF.d";
  integer nvar = 0, ncon = 0;
  integer funit = 42, ierr = 0, fout = 6, io_buffer = 11, status;

  FORTRAN_open(&funit, fname, &ierr);
  CUTEST_cdimen(&status, &funit, &nvar, &ncon);

  x  = (doublereal *) malloc(sizeof(doublereal) * nvar);
  bl = (doublereal *) malloc(sizeof(doublereal) * nvar);
  bu = (doublereal *) malloc(sizeof(doublereal) * nvar);

  vnames = (char *) malloc(10 * nvar);

  if (ncon > 0) {
    y  = (doublereal *) malloc(sizeof(doublereal) * ncon);
    cl = (doublereal *) malloc(sizeof(doublereal) * ncon);
    cu = (doublereal *) malloc(sizeof(doublereal) * ncon);

    equatn = (logical *) malloc(sizeof(logical) * ncon);
    linear = (logical *) malloc(sizeof(logical) * ncon);

    cnames = (char *) malloc(10 * ncon);

    CUTEST_csetup(&status, &funit, &fout, &io_buffer, &nvar, &ncon, x, bl, bu,
        y, cl, cu, equatn, linear, &efirst, &lfirst, &nvfirst);
    CUTEST_cnames(&status, &nvar, &ncon, pname, vnames, cnames);
  } else {
    CUTEST_usetup(&status, &funit, &fout, &io_buffer, &nvar, x, bl, bu);
    CUTEST_unames(&status, &nvar, pname, vnames);
  }

  pname[9] = 0;
  printf("%9s\n", pname);
  printf("Number of variables: %d\n", nvar);
  printf("Number of constraints: %d\n", ncon);

  if (ncon > 0) {
    free(y);
    free(cl);
    free(cu);
    free(equatn);
    free(linear);
  }
  free(x);
  free(bl);
  free(bu);

  FORTRAN_close(&funit, &ierr);

  return 0;
}
