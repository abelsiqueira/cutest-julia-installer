# This example shows how to use the CUTEst shared library along with sifdecoder
# to run CUTEst commands
const funit = [int32(42)]
const fname = "OUTSDIF.d"
const ierr  = [int32(0)]
const iout  = [int32(6)]
const iobuf = [int32(11)]
const e_ord = [int32(0)]
const l_ord = [int32(0)]
const v_ord = [int32(0)]

status = [int32(0)]
nvar   = [int32(-1)]
ncon   = [int32(-1)]
pname  = ^(" ", 10)

const libname = "libjuliacutest.so"

ccall(("fortran_open_", libname), Void,
    (Ptr{Int32}, Ptr{Uint8}, Ptr{Int32}), funit, fname, ierr)

ccall(("cutest_cdimen_", libname), Void,
    (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
    status, funit, nvar, ncon)

x  = Array(Float64, nvar[1])
bl = Array(Float64, nvar[1])
bu = Array(Float64, nvar[1])

vnames = ^(" ", 10*nvar[1])

if (ncon[1] > 0)
  y  = Array(Float64, ncon[1])
  cl = Array(Float64, ncon[1])
  cu = Array(Float64, ncon[1])

  equatn = Array(Int32, ncon[1])
  linear = Array(Int32, ncon[1])

  cnames = ^(" ", 10*ncon[1])

  ccall(("cutest_csetup_", libname), Void,
      (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32},
      Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64},
      Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
      status, funit, iout, iobuf, nvar, ncon, x, bl, bu, y, cl, bu, equatn,
      linear, e_ord, l_ord, v_ord)
  ccall(("cutest_cnames_", libname), Void,
      (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}, Ptr{Uint8}, Ptr{Uint8}),
      status, nvar, ncon, pname, vnames, cnames)
else
  ccall(("cutest_usetup_", libname), Void,
      (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32},
      Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
      status, funit, iout, iobuf, nvar, x, bl, bu)
  ccall(("cutest_unames_", libname), Void,
      (Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}, Ptr{Uint8}),
      status, nvar, pname, vnames)
end

println("Problem ", pname)
for i = 1:nvar[1]
  println(bl[i]," <= x",i," <= ",bu[i])
end
println("x0 = ",x)

f = Array(Float64, 1)

if (ncon[1] > 0)
  c = Array(Float64, ncon[1])
  ccall(("cutest_cfn_", libname), Void,
      (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64},
      Ptr{Float64}), status, nvar, ncon, x, f, c)
  println("c = ", c)
else
  ccall(("cutest_ufn_", libname), Void,
      (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}), status, nvar, x, f)
end
println("f = ", f)

ccall(("fortran_close_", libname), Void,
    (Ptr{Int32}, Ptr{Int32}), funit, ierr)
