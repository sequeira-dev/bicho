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
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.Samples.Gauges;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    TimerImportacao: TTimer;
    Panel2: TPanel;
    memLogImportacao: TMemo;
    gauLogImporatacao: TGauge;
    GroupBox1: TGroupBox;
    btnImportarResultadosAPI: TBitBtn;
    DataInicio: TDateTimePicker;
    Label1: TLabel;
    chkImportacao: TCheckBox;
    procedure btnImportarResultadosAPIClick(Sender: TObject);
    procedure TimerImportacaoTimer(Sender: TObject);

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
  uUtilBanco, uUtil;

{ TfrmPrincipal }
procedure TfrmPrincipal.btnImportarResultadosAPIClick(Sender: TObject);
begin
  uUtil.importarResultados(DataInicio.DateTime, chkImportacao.Checked, gauLogImporatacao, memLogImportacao);
end;

procedure TfrmPrincipal.TimerImportacaoTimer(Sender: TObject);
begin
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

