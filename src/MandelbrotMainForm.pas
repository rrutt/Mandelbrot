unit MandelbrotMainForm;

//TODO: Add SpinEdit controls for Max Iterations and Max Colors.  (Redraw button required after changes.)

//TODO: Add display Labels for current parameters (coordinates, zoom level, etc.).

//TODO: (?) Support Save/Load of current parameters (coordinates, zoom level, palette, etc.).

//TODO: (?) Support save of current Bitmap to PNG file.  https://lazarus-ccr.sourceforge.io/docs/lcl/graphics/tpicture.html

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,
  Constants,
  MandelbrotSpace;

type

  { TMandelbrotMainForm }

  TMandelbrotMainForm = class(TForm)
    ButtonColors: TButton;
    ButtonRedraw: TButton;
    ButtonReset: TButton;
    procedure ButtonRedrawClick(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
    procedure ButtonColorsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResizeSpace;
    procedure EnableButtons(const AreEnabled: boolean);
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

procedure TMandelbrotMainForm.EnableButtons(const AreEnabled: boolean);
begin
  ButtonReset.Enabled := AreEnabled;
  ButtonColors.Enabled := AreEnabled;
  ButtonRedraw.Enabled := AreEnabled;
end;

procedure TMandelbrotMainForm.ButtonResetClick(Sender: TObject);
begin
  EnableButtons(false);

  ResizeSpace;
  Space.ResetCoordinatesAndScale;
  Space.Paint;

  EnableButtons(true);
end;

procedure TMandelbrotMainForm.ButtonColorsClick(Sender: TObject);
begin
  EnableButtons(false);

  Space.PaintColorGradients;

  EnableButtons(true);
end;

procedure TMandelbrotMainForm.ButtonRedrawClick(Sender: TObject);
begin
  EnableButtons(false);

  ResizeSpace;
  Space.Paint;

  EnableButtons(true);
end;

end.

