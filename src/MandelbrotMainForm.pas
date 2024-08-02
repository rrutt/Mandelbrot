unit MandelbrotMainForm;

//TODO: Define better color gradients.

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin,
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
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MaxIterationsSpinEdit: TSpinEdit;
    YCoordLabel: TLabel;
    ZoomLevelLabel: TLabel;
    XCoordLabel: TLabel;
    procedure ButtonRedrawClick(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
    procedure ButtonColorsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MaxIterationsSpinEditChange(Sender: TObject);
    procedure ResizeSpace;
    procedure UpdateLabels;
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

  Space := TMandelbrotSpace.Create(Self);
  Space.InitializeColorGradient;
  ButtonResetClick(Sender);
end;

procedure TMandelbrotMainForm.MaxIterationsSpinEditChange(Sender: TObject);
begin
  MaxIterations := MaxIterationsSpinEdit.Value;
  MaxColors := MaxIterations;
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

  UpdateLabels;

  ButtonReset.Enabled := true;
end;

procedure TMandelbrotMainForm.ButtonColorsClick(Sender: TObject);
begin
  Space.PaintColorGradients;
end;

procedure TMandelbrotMainForm.ButtonRedrawClick(Sender: TObject);
begin
  ButtonRedraw.Enabled := false;

  ResizeSpace;
  Space.Paint;

  ButtonRedraw.Enabled := true;
end;

procedure TMandelbrotMainForm.UpdateLabels;
var
  zoomLevel: double;
begin
  zoomLevel := INITIAL_SCALE_FACTOR / ScaleFactor;
  ZoomLevelLabel.Caption := FloatToStr(zoomLevel);

  MaxIterationsSpinEdit.Value := MaxIterations;

  XCoordLabel.Caption := FloatToStr(XCoordOffset);
  YCoordLabel.Caption := FloatToStr(- YCoordOffset);
end;

procedure TMandelbrotMainForm.Update;
begin
  inherited;

  UpdateLabels;
end;

end.

