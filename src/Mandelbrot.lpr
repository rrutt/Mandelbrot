program Mandelbrot;

{$mode objfpc}{$H+}

{$IFDEF WINDOWS}
  {$R *.res}
{$ENDIF}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  ColorGradientUtil,
  MandelbrotMainForm,
  MandelbrotPoint;

begin
  Randomize;

  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMandelbrotMainForm, MainForm);
  Application.Run;
end.

