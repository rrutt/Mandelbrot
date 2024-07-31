unit MandelbrotPoint;

{$mode objfpc}{$H+}

interface

uses
  Classes, Graphics, SysUtils,
  Constants,
  Cplx,
  CplxSup;

function MandelbrotPointColor(
  const XCoord: double;
  const YCoord: double;
  const Colors: array of TColor): TColor;


implementation

function MandelbrotPointColor(
  const XCoord: double;
  const YCoord: double;
  const Colors: array of TColor): TColor;
var
  pointColor: TColor;
  c: Complex;
  z: Complex;
  zNext: Complex;
  zMag2: double;
  maxMag2: double;
  iteration: integer;
  colorIndex: integer;
begin
  maxMag2 := MAX_VALUE_EXTANT * MAX_VALUE_EXTANT;

  c.init(XCoord, YCoord);
  z.init(0.0, 0.0);
  zMag2 := 0;
  iteration := 0;

  while (zMag2 < maxMag2) and (iteration < MAX_ITERATIONS) do begin
    zNext := (z * z) + c;
    z := zNext;
    zMag2 := z.mag2;
    inc(iteration);
  end;

  if (iteration < MAX_ITERATIONS) then begin
    colorIndex := iteration mod Length(Colors);
    pointColor := Colors[colorIndex];
  end else begin
    pointColor := clBlack;
  end;

  Result := PointColor;
end;

end.
