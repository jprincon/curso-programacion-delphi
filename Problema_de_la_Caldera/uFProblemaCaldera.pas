unit uFProblemaCaldera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SynEdit, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Datos: TTreeView;
    GroupBox1: TGroupBox;
    edDato: TEdit;
    Panel2: TPanel;
    Consola: TSynEdit;
    Panel3: TPanel;
    sbCalcular: TSpeedButton;
    sbBorrar: TSpeedButton;
    procedure edDatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbCalcularClick(Sender: TObject);
    procedure sbBorrarClick(Sender: TObject);
    procedure DatosDblClick(Sender: TObject);
  private
    editando: boolean;
  public
    { Public declarations }
  end;

  { Diseñe un algoritmo que permita calcular las mediciones de temperaturas
    de una caldera, las mismas deben ser entre 25 y 100 grados inclusive.
    Se desea calcular el promedio y la cantidad de temperaturas que estuvieron
    fuera del rango permitido. }

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DatosDblClick(Sender: TObject);
begin
  if Datos.Selected <> nil then
  begin
    edDato.Text := Datos.Selected.Text;
    editando := true;
  end;
end;

procedure TForm1.edDatoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = $0D then
  begin
    if editando then
    begin
      Datos.Selected.Text := edDato.Text;
      editando := false;
    end
    else
    begin
      Datos.Items.Add(nil, edDato.Text);
      edDato.Text := '';
      edDato.SetFocus;
    end;
  end;
end;

procedure TForm1.sbBorrarClick(Sender: TObject);
begin
  Datos.Items.Clear;
end;

procedure TForm1.sbCalcularClick(Sender: TObject);
var
  suma, promedio, valor: real;
  cantidad: integer;
  i: integer;
begin
  suma := 0;
  cantidad := 0;

  { para determinar los valorse que estan por fuera del rango }
  for i := 1 to Datos.Items.Count do
  begin
    valor := StrToFloat(Datos.Items[i - 1].Text);

    if (valor < 25) or (valor > 100) then
    begin
      suma := suma + valor;
      Inc(cantidad);
    end;
  end;

  if cantidad > 0 then
    promedio := suma / cantidad
  else
    promedio := 0;

  { mostrar en la consola }
  Consola.Lines.Add('cantidad = ' + FloatToStr(cantidad));
  Consola.Lines.Add('promedio = ' + FloatToStr(promedio));
end;

end.
