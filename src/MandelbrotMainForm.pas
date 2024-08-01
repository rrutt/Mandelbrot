unit MandelbrotMainForm;

//TODO: Add display Labels for current parameters (coordinates, zoom level, etc.).

//TODO: Define better color gradients.

//TODO: Add SpinEdit control for Max Iterations.  (Redraw button required after changes.)

//TODO: (?) Add SpinEdit controls for Max Colors.  (Redraw button required after changes.)

//TODO: (?) Support Save/Load of current parameters (coordinates, zoom level, palette, etc.).

//TODO: (?) Support save of current Bitmap to PNG file.  https://lazarus-ccr.sourceforge.io/docs/lcl/graphics/tpicture.html

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,
  Constants,
  Context,
  MandelbrotSpace;

type

  { TMandelbrotMainForm }

  TMandelbrotMainForm = class(TForm)
    ButtonColors: TButton;
    ButtonRedraw: TButton;
    ButtonReset: TButton;
    Label1: TLabel;
    ScaleFactorLabel: TLabel;
    procedure ButtonRedrawClick(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
    procedure ButtonColorsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResizeSpace;
    procedure Update; override;
  end;

  var
    MainForm: TMandelbrotMainForm;

implementation

{$R *.lfm}

  var
   Space: TMandelbrotSpace;
   //ResourceDirectory: UTF8String {$IFNDEF MACOSX} = '../res/' {$ENDIF};

procedure TMandelbrotMainForm.FormCreate(Sender: TObject);
begin
  Caption := Caption + '  (Version ' + PRODUCT_VERSION + ')';

  MaxIterations := INITIAL_MAX_ITERATIONS;
  MaxColors := MaxIterations;

  ScaleFactorLabel.Caption := FloatToStr(INITIAL_SCALE_FACTOR);

  Space := TMandelbrotSpace.Create(Self);
  Space.InitializeColorGradient;
  ButtonResetClick(Sender);
end;

procedure TMandelbrotMainForm.ResizeSpace;
const
  BORDER_SIZE = 10;
begin
  Space.Top := ButtonReset.Top + ButtonReset.Height + BORDER_SIZE;
  Space.Left := BORDER_SIZE;
  Space.Width := Self.Width - (2 * BORDER_SIZE);
  Space.Height := Self.Height - (ButtonReset.Top + ButtonReset.Height + (2 * BORDER_SIZE));
  Space.Parent := Self;
  Space.DoubleBuffered := True;
end;

procedure TMandelbrotMainForm.ButtonResetClick(Sender: TObject);
begin
  ButtonReset.Enabled := false;

  ResizeSpace;
  Space.ResetCoordinatesAndScale;
  Space.Paint;

  ScaleFactorLabel.Caption := FloatToStr(ScaleFactor);

  ButtonReset.Enabled := true;
end;

procedure TMandelbrotMainForm.ButtonColorsClick(Sender: TObject);
begin
  ButtonColors.Enabled := false;

  Space.PaintColorGradients;

  ButtonColors.Enabled := true;
end;

procedure TMandelbrotMainForm.ButtonRedrawClick(Sender: TObject);
begin
  ButtonRedraw.Enabled := false;

  ResizeSpace;
  Space.Paint;

  ButtonRedraw.Enabled := true;
end;

procedure TMandelbrotMainForm.Update;
begin
  inherited;

  ScaleFactorLabel.Caption := FloatToStr(ScaleFactor);
end;

end.

