program Problema_de_la_Caldera;

uses
  Vcl.Forms,
  uFProblemaCaldera in 'uFProblemaCaldera.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
