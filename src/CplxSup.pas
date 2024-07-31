unit CplxSup;

// Sourced from https://github.com/anton-a-tkachev/Complex-Numbers-for-Free-Pascal

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Cplx, Math;

function j: complex;

operator + (x, y: complex) z: complex;
operator + (x: double; y: complex) z: complex;
operator + (x: complex; y: double) z: complex;
operator - (x, y: complex) z: complex;
operator - (x: double; y: complex) z: complex;
operator - (x: complex; y: double) z: complex;
operator * (x, y: complex) z: complex;
operator * (x: double; y: complex) z: complex;
operator * (x: complex; y: double) z: complex;
operator / (x, y: complex) z: complex;
operator / (x: double; y: complex) z: complex;
operator / (x: complex; y: double) z: complex;

function eulr(z: complex): complex;
function powr(z, p: double): double;
function powr(z: complex; p: double): complex;
function powr(z: double; p: complex): complex;
function powr(z: complex; p: complex): complex;
function root(z: complex; n, k: integer): complex;
function root(z: double; n, k: integer): complex;

implementation
// Define imaginary unit j
function j: complex;
begin
  j.re:= 0;
  j.im:= 1;
end;

// Overload + operator
operator + (x, y: complex) z: complex;
begin
  z.re:= x.re + y.re;
  z.im:= x.im + y.im;
end;
operator + (x: double; y: complex) z: complex;
begin
  z.re:= x + y.re;
  z.im:= y.im;
end;
operator + (x: complex; y: double) z: complex;
begin
  z.re:= x.re + y;
  z.im:= x.im;
end;

// Overload - operator
operator - (x, y: complex) z: complex;
begin
  z.re:= x.re - y.re;
  z.im:= x.im - y.im;
end;
operator - (x: double; y: complex) z: complex;
begin
  z.re:= x - y.re;
  z.im:= -y.im;
end;
operator - (x: complex; y: double) z: complex;
begin
  z.re:= x.re - y;
  z.im:= x.im;
end;

// Overload * operator
operator * (x, y: complex) z: complex;
begin
  z.re:= x.re*y.re - x.im*y.im;
  z.im:= x.re*y.im + x.im*y.re;
end;
operator * (x: double; y: complex) z: complex;
begin
  z.re:= x*y.re;
  z.im:= x*y.im;
end;
operator * (x: complex; y: double) z: complex;
begin
  z.re:= x.re*y;
  z.im:= x.im*y;
end;

// Overload / operator
operator / (x, y: complex) z: complex;
begin
  z.re:= ( x.re*y.re + x.im*y.im)/y.mag2;
  z.im:= (-x.re*y.im + x.im*y.re)/y.mag2;
end;
operator / (x: double; y: complex) z: complex;
begin
  z.re:=  x*y.re/y.mag2;
  z.im:= -x*y.im/y.mag2;
end;
operator / (x: complex; y: double) z: complex;
begin
  z.re:= x.re/y;
  z.im:= x.im/y;
end;

// Define Euler's formula as a function
function eulr(z: complex): complex;
begin
  eulr.re:= exp(z.re)*cos(z.im);
  eulr.im:= exp(z.re)*sin(z.im);
end;

// Define power function
function powr(z, p: double): double;
begin
  powr:= power(z,p);
end;
function powr(z: complex; p: double): complex;
begin
  powr:= power(z.mag, p)*eulr(j*z.phs*p);
end;
function powr(z: double; p: complex): complex;
begin
  powr:= power(z,p.re)*eulr(j*p.im*ln(z));
end;
function powr(z: complex; p: complex): complex;
begin
  powr:= eulr(p.re*ln(z.mag) - p.im*z.phs + j*(p.im*ln(z.mag) + p.re*z.phs));
end;

// Define root function
// n - order of the root
// k - solution phase index, typically from 0 to n-1
// k can go beyond the limits
// in this case the phase of the answer will keep revolving
function root(z: complex; n, k: integer): complex;
begin
  root:= power(z.mag, 1.0/n)*eulr(j*(z.phs + 2*pi*k)/n);
end;
function root(z: double; n, k: integer): complex;
begin
  root:= power(z, 1.0/n)*eulr(j*2*pi*k/n);
end;

end.
