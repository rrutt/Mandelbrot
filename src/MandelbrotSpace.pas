unit MandelbrotSpace;

interface

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, Controls, Dialogs, Graphics, LCLType, Math,
  ColorGradientUtil,
  Constants,
  Context,
  MandelbrotPoint;

type
  TMandelbrotSpace = class(TCustomControl)
    private
      CenterX: Integer;
      CenterY: Integer;
      SelectingColors: Boolean;
      CurrentGradientIndex: Integer;

    public
      procedure InitializeColorGradient;
      procedure ResetCoordinatesAndScale;
      procedure EraseBackground({%H-}DC: HDC); override;
      procedure Paint; override;
      procedure PaintColorGradients;
      procedure MouseDown(Sender: TObject; Button: TMouseButton;
        {%H-}Shift: TShiftState; X, Y: Integer); overload;
  end;

implementation

  procedure TMandelbrotSpace.InitializeColorGradient;
  begin
    CurrentGradientIndex := Low(GRADIENT_COLOR_SETS);

    SelectingColors := false;
  end;

  procedure TMandelbrotSpace.ResetCoordinatesAndScale;
  begin
    CenterX := Width div 2;
    CenterY := Height div 2;

    XCoordOffset := 0.0;
    YCoordOffset := 0.0;

    ScaleFactor := INITIAL_SCALE_FACTOR;

    SelectingColors := false;

    OnMouseDown := @MouseDown;
  end;

  procedure TMandelbrotSpace.EraseBackground(DC: HDC);
  begin
    // Uncomment this to enable default background erasing
    //inherited EraseBackground(DC);
  end;

  procedure PaintColorGradient(
    const Bitmap: TBitmap;
    const TopY: integer;
    const GradientHeight: integer;
    const GradientColors: array of TColor);
  var
    i, j: Integer;
    c: TColor;
    colorPalette: array of TColor;
  begin
    SetLength(colorPalette{%H-}, Bitmap.Width);
    MakeColorGradient(ColorPalette, GradientColors);

    for i := 0 to (Bitmap.Width - 1) do begin
      c := colorPalette[i];
      for j := TopY to (TopY + GradientHeight) do begin
        Bitmap.Canvas.Pixels[i, j] := c;
      end;
    end;
  end;

  procedure TMandelbrotSpace.PaintColorGradients;
  var
    Bitmap: TBitmap;
    gradientColors: array of TColor;
    gradientY: integer;
    gradientCount: integer;
    gradientHeight: integer;
    i: integer;
  begin
    TheScreen.BeginWaitCursor;
    TheApplication.ProcessMessages;

    SelectingColors := true;

    Bitmap := TBitmap.Create;
    try
      Bitmap.Height := Height;
      Bitmap.Width := Width;

      gradientCount := Length(GRADIENT_COLOR_SETS);
      gradientHeight := (Height div gradientCount) - GRADIENT_SELECTION_SEPARATION;

      gradientY := 0;
      for i := Low(GRADIENT_COLOR_SETS) to High(GRADIENT_COLOR_SETS) do begin
        gradientColors := GRADIENT_COLOR_SETS[i];
        PaintColorGradient(Bitmap, gradientY, gradientHeight, gradientColors);
        gradientY := gradientY + gradientHeight + GRADIENT_SELECTION_SEPARATION;
      end;

      Canvas.Draw(0, 0, Bitmap);
    finally
      Bitmap.Free;

      TheScreen.EndWaitCursor;
      TheApplication.ProcessMessages;
    end;

    inherited Paint;
  end;

  procedure TMandelbrotSpace.Paint;
  var
    Bitmap: TBitmap;
    ix, iy: integer;
    offsetX, offsetY: integer;
    scale: double;
    xCoord, yCoord: double;
    pointColor: TColor;
    gradientColors: array of TColor;
    gradientIndex: integer;
    colorPalette: array of TColor;
  begin
    TheScreen.BeginWaitCursor;
    TheApplication.ProcessMessages;

    SelectingColors := false;

    SetLength(colorPalette{%H-}, MaxColors);

    gradientIndex := CurrentGradientIndex;
    gradientColors := GRADIENT_COLOR_SETS[gradientIndex];
    MakeColorGradient(colorPalette{%H-}, gradientColors);

    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;

      scale := (ScaleFactor * MAX_MAGNITUDE) / Math.Min(Width, Height);

      for ix := 0 to (Width - 1) do begin
        offsetX := ix - CenterX;
        xCoord := XCoordOffset + (offsetX * scale);

        for iy := 0 to (Height - 1) do begin
          offsetY := iy - CenterY;
          yCoord := YCoordOffset + (offsetY * scale);
          pointColor := MandelbrotPointColor(xCoord, yCoord, colorPalette);
          Bitmap.Canvas.Pixels[ix, iy] := pointColor;
        end;

        TheApplication.ProcessMessages;
      end;

      PaintColorGradient(Bitmap, 0, CURRENT_GRADIENT_HEIGHT, gradientColors);

      Canvas.Draw(0, 0, Bitmap);
    finally
      Bitmap.Free;

      TheScreen.EndWaitCursor;
      TheApplication.ProcessMessages;
    end;

    inherited Paint;
  end;

  procedure TMandelbrotSpace.MouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    offsetX: Integer;
    offsetY: Integer;
    gradientCount: integer;
    gradientHeight: integer;
    gradientIndex: integer;
    scale: double;
  begin

    if (SelectingColors) then begin
      gradientCount := Length(GRADIENT_COLOR_SETS);
      gradientHeight := (Height div gradientCount) - GRADIENT_SELECTION_SEPARATION;
      gradientIndex := Y div (gradientHeight + GRADIENT_SELECTION_SEPARATION);
      if (gradientIndex > High(GRADIENT_COLOR_SETS)) then begin
        gradientIndex := High(GRADIENT_COLOR_SETS);
      end;
      CurrentGradientIndex := gradientIndex;
    end else begin
      { Re-center the space on the clicked point. }
      offsetX := X - CenterX;
      offsetY := Y - CenterY;
      scale := (ScaleFactor * MAX_MAGNITUDE) / Math.Min(Width, Height);
      XCoordOffset := XCoordOffset + (offsetX * scale);
      YCoordOffset := YCoordOffset + (offsetY * scale);

      if (Button = mbLeft) then begin
        ScaleFactor := ScaleFactor / SCALE_ZOOM_DIVISOR;
      end else if (Button = mbRight) then begin
        ScaleFactor := ScaleFactor * SCALE_ZOOM_DIVISOR;
      end;
    end;

    // Allow main form to update the ScaleFactor label.
    Parent.Update;

    Paint;
  end;

end.
