unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON;

type
  TfrmPrincipal = class(TForm)
    DatePicker1: TDatePicker;
    fdmPrincipalGrupo: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    procedure FormCreate(Sender: TObject);
  private
    procedure AtualizarMemo;
    procedure CarregarMemTable;
//    procedure btnAtualizarClick(Sender: TObject);
//    procedure btnCriarClick(Sender: TObject);
//    procedure btnExcluirClick(Sender: TObject);
//    procedure btnLerClick(Sender: TObject);
    procedure CriarArquivoJSON;
    function LerJSON: TJSONArray;
    procedure SalvarJSON(JSONArr: TJSONArray);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

const
  JSON_FILE = 'dados.json'; // Nome do arquivo JSON

procedure TfrmPrincipal.CarregarMemTable;
begin
  var JSONStream: TFileStream;
  begin
    if not FileExists(JSON_FILE) then
    begin
      ShowMessage('Arquivo JSON não encontrado!');
      Exit;
    end;

    JSONStream := TFileStream.Create(JSON_FILE, fmOpenRead);
    try
      fdmPrincipalGrupo.LoadFromStream(JSONStream, sfJSON);
      fdmPrincipalGrupo.Open;
    finally
      JSONStream.Free;
    end;
  end;
end;

procedure TfrmPrincipal.CriarArquivoJSON;
var
  JSONDia, JSONHorario: TJSONObject;
  JSONPremio: TJSONArray;
  JSONStr: TStringList;
begin

  if not FileExists(JSON_FILE) then
  begin
    JSONDia := TJSONObject.Create;
    JSONStr := TStringList.Create;

    try
      JSONDia.AddPair('data', '12/02/2025');

      JSONHorario := TJSONObject.Create;
      JSONHorario.AddPair('horario', '9:30');

      JSONPremio := TJSONArray.Create;
      JSONPremio.AddElement(TJSONObject.Create.AddPair('1', '22'));
      JSONPremio.AddElement(TJSONObject.Create.AddPair('2', '3'));
      JSONPremio.AddElement(TJSONObject.Create.AddPair('3', '17'));
      JSONPremio.AddElement(TJSONObject.Create.AddPair('4', '10'));
      JSONPremio.AddElement(TJSONObject.Create.AddPair('5', '9'));

      JSONHorario.AddPair('premios', JSONPremio);

      JSONDia.AddPair('horarios', JSONHorario);

      JSONStr.Text := JSONDia.ToJSON;
      JSONStr.SaveToFile(JSON_FILE);
    finally
      JSONDia.Free;
      JSONStr.Free;
    end;
  end;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  CriarArquivoJSON;
  CarregarMemTable;
end;

function TfrmPrincipal.LerJSON: TJSONArray;
var
  JSONStr: TStringList;
  JSONValue: TJSONValue;
begin
  Result := TJSONArray.Create;
  JSONStr := TStringList.Create;
  try
    if FileExists(JSON_FILE) then
    begin
      JSONStr.LoadFromFile(JSON_FILE);
      JSONValue := TJSONObject.ParseJSONValue(JSONStr.Text);
      if Assigned(JSONValue) and (JSONValue is TJSONArray) then
        Result := TJSONArray(JSONValue)
      else
        JSONValue.Free;
    end;
  finally
    JSONStr.Free;
  end;
end;

procedure TfrmPrincipal.SalvarJSON(JSONArr: TJSONArray);
var
  JSONStr: TStringList;
begin
  JSONStr := TStringList.Create;
  try
    JSONStr.Text := JSONArr.ToJSON;
    JSONStr.SaveToFile(JSON_FILE);
  finally
    JSONStr.Free;
  end;
end;

procedure TfrmPrincipal.AtualizarMemo;
var
  JSONArr: TJSONArray;
  JSONObj: TJSONObject;
  i: Integer;
begin
{  Memo1.Clear;
  JSONArr := LerJSON;
  try
    for i := 0 to JSONArr.Count - 1 do
    begin
      JSONObj := JSONArr.Items[i] as TJSONObject;
      Memo1.Lines.Add(Format('ID: %d | Nome: %s | Idade: %d',
        [JSONObj.GetValue<Integer>('id'),
         JSONObj.GetValue<string>('nome'),
         JSONObj.GetValue<Integer>('idade')]));
    end;
  finally
    JSONArr.Free;
  end;              }
end;

{procedure TfrmPrincipal.btnCriarClick(Sender: TObject);
var
  JSONArr: TJSONArray;
  JSONObj: TJSONObject;
  ID, Idade: Integer;
begin
  if (edtID.Text = '') or (edtNome.Text = '') or (edtIdade.Text = '') then
  begin
    ShowMessage('Preencha todos os campos!');
    Exit;
  end;

  ID := StrToInt(edtID.Text);
  Idade := StrToInt(edtIdade.Text);

  JSONArr := LerJSON;
  try
    JSONObj := TJSONObject.Create;
    JSONObj.AddPair('id', TJSONNumber.Create(ID));
    JSONObj.AddPair('nome', edtNome.Text);
    JSONObj.AddPair('idade', TJSONNumber.Create(Idade));
    JSONArr.AddElement(JSONObj);
    SalvarJSON(JSONArr);
    ShowMessage('Registro adicionado com sucesso!');
  finally
    JSONArr.Free;
  end;
  AtualizarMemo;
end;

procedure TfrmPrincipal.btnLerClick(Sender: TObject);
begin
  AtualizarMemo;
end;

procedure TfrmPrincipal.btnAtualizarClick(Sender: TObject);
var
  JSONArr: TJSONArray;
  JSONObj: TJSONObject;
  i, ID: Integer;
begin
  if (edtID.Text = '') or (edtNome.Text = '') or (edtIdade.Text = '') then
  begin
    ShowMessage('Preencha todos os campos!');
    Exit;
  end;

  ID := StrToInt(edtID.Text);
  JSONArr := LerJSON;
  try
    for i := 0 to JSONArr.Count - 1 do
    begin
      JSONObj := JSONArr.Items[i] as TJSONObject;
      if JSONObj.GetValue<Integer>('id') = ID then
      begin
        JSONObj.AddPair('nome', edtNome.Text);
        JSONObj.AddPair('idade', TJSONNumber.Create(StrToInt(edtIdade.Text)));
        Break;
      end;
    end;
    SalvarJSON(JSONArr);
    ShowMessage('Registro atualizado com sucesso!');
  finally
    JSONArr.Free;
  end;
  AtualizarMemo;
end;

procedure TfrmPrincipal.btnExcluirClick(Sender: TObject);
var
  JSONArr: TJSONArray;
  i, ID: Integer;
begin
  if edtID.Text = '' then
  begin
    ShowMessage('Informe o ID para excluir!');
    Exit;
  end;

  ID := StrToInt(edtID.Text);
  JSONArr := LerJSON;
  try
    for i := JSONArr.Count - 1 downto 0 do
    begin
      if (JSONArr.Items[i] as TJSONObject).GetValue<Integer>('id') = ID then
      begin
        JSONArr.Remove(i);
        Break;
      end;
    end;
    SalvarJSON(JSONArr);
    ShowMessage('Registro excluído com sucesso!');
  finally
    JSONArr.Free;
  end;
  AtualizarMemo;
end;
}



end.
