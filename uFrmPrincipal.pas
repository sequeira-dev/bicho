﻿unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, REST.Client, REST.Types,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait;

type
  TfrmPrincipal = class(TForm)
    FDMemTable1: TFDMemTable;
    dsPrincipalGrupo: TDataSource;
    Panel1: TPanel;
    BtnAdicionar: TButton;
    btnSalvar: TButton;
    btnCarregar: TButton;
    EditNome: TEdit;
    DatePickerNascimento: TDateTimePicker;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    FDConnection: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure FormCreate(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    procedure ConfigurarMemTable;
    procedure SalvarJSON(const FileName: string);
    procedure CarregarJSON(const FileName: string);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

const
  JSON_FILE = 'dados.json';

{ TfrmPrincipal }

procedure TfrmPrincipal.BtnAdicionarClick(Sender: TObject);
begin
  FDMemTable1.Append;
  FDMemTable1.FieldByName('ID').AsInteger := FDMemTable1.RecordCount + 1;
  FDMemTable1.FieldByName('Nome').AsString := EditNome.Text;
  FDMemTable1.FieldByName('DataNascimento').AsDateTime := DatePickerNascimento.Date;
  FDMemTable1.Post;
end;

procedure TfrmPrincipal.btnCarregarClick(Sender: TObject);
begin
//MOVIDO PARA O CREATE
// CarregarJSON(JSON_FILE);
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
//MOVIDO PARA O DESTROY
//  SalvarJSON(JSON_FILE);
end;

procedure TfrmPrincipal.CarregarJSON(const FileName: string);
var
  JSONStream: TFileStream;
begin
  if not FileExists(FileName) then
  begin
    ShowMessage('Arquivo JSON não encontrado!');
    Exit;
  end;

  JSONStream := TFileStream.Create(FileName, fmOpenRead);
  try
    FDMemTable1.LoadFromStream(JSONStream, sfJSON);
    FDMemTable1.Open;
  finally
    JSONStream.Free;
  end;
 // ShowMessage('Dados carregados do JSON com sucesso!');
end;

procedure TfrmPrincipal.ConfigurarMemTable;
begin
  FDMemTable1.Close;
  FDMemTable1.FieldDefs.Clear;

  FDMemTable1.FieldDefs.Add('ID', ftInteger);
  FDMemTable1.FieldDefs.Add('Nome', ftString, 100);
  FDMemTable1.FieldDefs.Add('DataNascimento', ftDateTime);

  FDMemTable1.CreateDataSet;
  FDMemTable1.Open;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ConfigurarMemTable;
  CarregarJSON(JSON_FILE);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  SalvarJSON(JSON_FILE);
end;

procedure TfrmPrincipal.SalvarJSON(const FileName: string);
var
  JSONStream: TFileStream;
begin
  JSONStream := TFileStream.Create(FileName, fmCreate);
  try
    FDMemTable1.SaveToStream(JSONStream, sfJSON);
  finally
    JSONStream.Free;
  end;
//  ShowMessage('Dados salvos em JSON com sucesso!');
end;

end.
