unit Cplx;

// Sourced from https://github.com/anton-a-tkachev/Complex-Numbers-for-Free-Pascal

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;

type Complex = object
  public
    // variables
    re, im: double;

    // constructor & destructor
    constructor init(x, y: double);
    destructor free;

    // methods
    function mag: double;
    function mag2: double;
    function phs: double;
    function phsd: double;
    function conj: complex;

    procedure print(m, n: integer);
    procedure println(m, n: integer);
end;

implementation

constructor complex.init(x, y: double);
begin
  re:= x;
  im:= y;
end;
destructor complex.free; begin end;

// Returns magnitude of the complex number
// Domain: any   Range: [0; +infty)
function complex.mag: double;
begin
  mag:= sqrt(re*re + im*im);
end;

// Returns magnitude squared
// Domain: any   Range: [0; +infty)
function complex.mag2: double;
begin
  mag2:= re*re + im*im;
end;

// Returns phase of the complex number in radians
// Domain: any   Range: (-pi; pi]
function complex.phs: double;
begin
  phs:= arctan2(im, re);
end;

// Returns phase of the complex number in degrees
// Domain: any   Range: (-180; 180]
function complex.phsd: double;
begin
  phsd:= arctan2(im, re)*180/pi;
end;

// Returns complex conjugate of the complex number
// Domain: any   Range: any
function complex.conj: complex;
begin
  conj.re:= re; conj.im:= -im;
end;

// Printing complex numbers
procedure complex.print(m, n: integer);
begin
  if im >= 0 then write(re:m:n,' + ',abs(im):m:n,'i')
             else write(re:m:n,' - ',abs(im):m:n,'i');
end;
procedure complex.println(m, n: integer);
begin
  if im >= 0 then writeln(re:m:n,' + ',abs(im):m:n,'i')
             else writeln(re:m:n,' - ',abs(im):m:n,'i');
end;

end.
