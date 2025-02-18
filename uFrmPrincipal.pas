unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.WinXPickers, Vcl.StdCtrls, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageJSON, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, REST.Client, REST.Types, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.Samples.Gauges,
  Vcl.Samples.Spin;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer: TTimer;
    Panel2: TPanel;
    memLogImportacao: TMemo;
    gauLogImporatacao: TGauge;
    GroupBox1: TGroupBox;
    btnImportarResultadosAPI: TBitBtn;
    DataInicio: TDateTimePicker;
    Label1: TLabel;
    chkImportacao: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    pnlMaisQuente: TPanel;
    Label2: TLabel;
    Memo1: TMemo;
    pnlMaisFrios: TPanel;
    Label3: TLabel;
    Memo2: TMemo;
    SpinEdit1: TSpinEdit;
    Label5: TLabel;
    pnlEsquentando: TPanel;
    Label6: TLabel;
    Memo3: TMemo;
    pnlEsfriando: TPanel;
    Label7: TLabel;
    Memo4: TMemo;
    procedure btnImportarResultadosAPIClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    procedure VerificarHora(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  uUtilBanco, uUtil, uConstantes;

{ TfrmPrincipal }
procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
var
  vArray: TArray<TArray<Integer>>;
  i,j: integer;
begin
  SetLength(vArray, strtoint(SpinEdit1.Text),2);


  //MAIS QUENTES
  uUtil.copiarMatriz(uUtil.retornaNumerosMais(DateTimePicker1.Date,strtoint(SpinEdit1.Text),true),vArray);

  Memo1.Lines.Clear;
  for I := 0 to strtoint(SpinEdit1.Text)-1 do
  begin
    for j := low(Grupos) to High(Grupos) do
    begin
      if Grupos[j].Grupo = vArray[i][0] then
        Memo1.Lines.add(Grupos[j].Bicho + '(' + IntToStr(vArray[i][0]) +'), saiu x'+ IntToStr(vArray[i][1]));
    end;
  end;

  //MAIS FRIOS
  uUtil.copiarMatriz(uUtil.retornaNumerosMais(DateTimePicker1.Date,strtoint(SpinEdit1.Text),false),vArray);

  Memo2.Lines.Clear;
  for I := 0 to strtoint(SpinEdit1.Text)-1 do
  begin
    for j := low(Grupos) to High(Grupos) do
    begin
      if Grupos[j].Grupo = vArray[i][0] then
        Memo2.Lines.add(Grupos[j].Bicho + '(' + IntToStr(vArray[i][0]) +'), saiu x'+ IntToStr(vArray[i][1]));
    end;
  end;

  //ESQUENTANDO
  uUtil.copiarMatriz(uUtil.retornaNumerosMais(DateTimePicker1.Date,strtoint(SpinEdit1.Text),true,true),vArray);

  Memo3.Lines.Clear;
  for I := 0 to strtoint(SpinEdit1.Text)-1 do
  begin
    for j := low(Grupos) to High(Grupos) do
    begin
      if Grupos[j].Grupo = vArray[i][0] then
        Memo3.Lines.add(Grupos[j].Bicho + '(' + IntToStr(vArray[i][0]) +'), saiu x'+ IntToStr(vArray[i][1]));
    end;
  end;

  //ESFRIANDO
  uUtil.copiarMatriz(uUtil.retornaNumerosMais(DateTimePicker1.Date,strtoint(SpinEdit1.Text),false,true),vArray);

  Memo4.Lines.Clear;
  for I := 0 to strtoint(SpinEdit1.Text)-1 do
  begin
    for j := low(Grupos) to High(Grupos) do
    begin
      if Grupos[j].Grupo = vArray[i][0] then
        Memo4.Lines.add(Grupos[j].Bicho + '(' + IntToStr(vArray[i][0]) +'), saiu x'+ IntToStr(vArray[i][1]));
    end;
  end;
end;

procedure TfrmPrincipal.btnImportarResultadosAPIClick(Sender: TObject);
begin
  uUtil.importarResultados(DataInicio.DateTime, chkImportacao.Checked, gauLogImporatacao, memLogImportacao);
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheet2 then
    VerificarHora(Sender);
end;

procedure TfrmPrincipal.VerificarHora(Sender: TObject);
var
  HoraAtual: TTime;
begin
  HoraAtual := Time;

  if (HoraAtual >= EncodeTime(19, 0, 0, 0)) and (HoraAtual < EncodeTime(19, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(18, 0, 0, 0)) and (HoraAtual < EncodeTime(18, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(17, 0, 0, 0)) and (HoraAtual < EncodeTime(17, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(16, 0, 0, 0)) and (HoraAtual < EncodeTime(16, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(14, 0, 0, 0)) and (HoraAtual < EncodeTime(14, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(13, 0, 0, 0)) and (HoraAtual < EncodeTime(13, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(11, 0, 0, 0)) and (HoraAtual < EncodeTime(11, 5, 0, 0)) then
    uUtil.importarResultados(Now, false, gauLogImporatacao, memLogImportacao);

  if (HoraAtual >= EncodeTime(9, 30, 0, 0)) and (HoraAtual < EncodeTime(9, 35, 0, 0)) then
    uUtil.importarResultados(Now,false);
end;

end.

