unit ColorGradientUtil;

{$mode objfpc}{$H+}

interface

uses
  Classes, Graphics, SysUtils;

procedure MakeColorGradient(
  var Colors: array of TColor;
  const GradientColors: array of TColor);


implementation

procedure FillGradientPalette(
  var Colors: array of TColor;
  const ColorIndex: integer; const ColorCount: integer;
  const StartColor: TColor; const EndColor: TColor);
var
  startR, startG, startB: byte;
  endR, endG, endB: byte;
  r, g, b: byte;
  factor: double;
  i: integer;
begin
  startR := Red(StartColor);
  startG := Green(StartColor);
  startB := Blue(StartColor);

  endR := Red(EndColor);
  endG := Green(EndColor);
  endB := Blue(EndColor);

  for i := 0 to (ColorCount - 1) do begin
    factor := i / ColorCount;
    if (endR > startR) then begin
      r := Trunc(startR + ((endR - startR) * factor));
    end else begin
      r := Trunc(startR - ((startR - endR) * factor));
    end;

    if (endG > startG) then begin
      g := Trunc(startG + ((endG - startG) * factor));
    end else begin
      g := Trunc(startG - ((startG - endG) * factor));
    end;

    if (endB > startB) then begin
      b := Trunc(startB + ((endB - startB) * factor));
    end else begin
      b := Trunc(startB - ((startB - endB) * factor));
    end;

    Colors[ColorIndex + i] := RGBtoColor(r, g, b);
  end;
end;

procedure MakeColorGradient(
  var Colors: array of TColor;
  const GradientColors: array of TColor);
var
  i: integer;
  gradientColorCount: integer;
  startIndex: integer;
  colorCount: integer;
  finalColorCount: integer;
  startColor: TColor;
  endColor: TColor;
begin
  gradientColorCount := Length(GradientColors);
  colorCount := Length(Colors) div gradientColorCount;
  startIndex := Low(Colors);

  for i := Low(GradientColors) to High(GradientColors) do begin
    startColor := GradientColors[i];
    endColor := GradientColors[i + 1];
    FillGradientPalette(Colors, startIndex, colorCount, startColor, endColor);
    startIndex := startIndex + colorCount;
  end;

  finalColorCount := Length(Colors) - (colorCount * GradientColorCount);
  i := High(Colors);
  while finalColorCount > 0 do begin
    Colors[i] := endColor;
    dec(i);
    dec(finalColorCount);
  end;
end;

end.

