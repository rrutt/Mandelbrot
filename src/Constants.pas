unit Constants;

{$mode objfpc}{$H+}

interface

uses
  Classes, Graphics, SysUtils;

const
  PRODUCT_VERSION = '1.0.0+20240731';

  INITIAL_SCALE_FACTOR = 2.0;
  SCALE_ZOOM_DIVISOR = 2.0;

  MAX_VALUE_EXTANT = 2.0;
  MAX_ITERATIONS = 200;
  MAX_COLORS = 200;

  CURRENT_GRADIENT_HEIGHT = 15;
  GRADIENT_SELECTION_SEPARATION = 5;

  GRADIENT_COLOR_SETS: array of array of TColor = (
    (clAqua, clSkyBlue, clNavy, clYellow, clOlive, clFuchsia, clRed, clMoneyGreen, clGreen, clLime),
    (clMaroon, clFuchsia, clYellow, clBlue, clLime, clRed, clGreen),
    (clRed, clGreen),
    (clBlue, clGreen),
    (clRed, clBlue),
    (clAqua, clYellow),
    (clGreen, clPurple),
    (clGreen, clFuchsia),
    (clBlue, clYellow),
    (clRed, clYellow),
    (clMaroon, clYellow),
    (clRed, clAqua),
    (clFuchsia, clAqua),
    (clAqua, clYellow),
    (clLime, clYellow),
    (clMaroon, clYellow),
    (clMaroon, clLime),
    (clNavy, clYellow),
    (clNavy, clAqua),
    (clYellow, clFuchsia, clRed),
    (clAqua, clFuchsia, clYellow),
    (clWhite, clBlack)
  );


implementation

end.

