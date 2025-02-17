unit uFrmPrincipal;

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
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    btnImportarResultadosAPI: TBitBtn;
    Memo1: TMemo;
    procedure btnImportarResultadosAPIClick(Sender: TObject);

  private

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uUtilBanco;

{ TfrmPrincipal }
procedure TfrmPrincipal.btnImportarResultadosAPIClick(Sender: TObject);
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONEnvio: TJSONObject;
  RetornoJSON: TJSONObject;
  DrawObj, PreviousDrawObj: TJSONObject;
  RetornoTexto: string;

  DrawsArray, PreviousDrawsArray, RaffledPopArray: TJSONArray;
  I, J, K, vPremio1, vPremio2, vPremio3, vPremio4, vPremio5,
  vGrupo1, vGrupo2, vGrupo3, vGrupo4, vGrupo5: Integer;

  FormatSettings: TFormatSettings;

begin
  try
    // Criando os objetos REST
    RESTClient := TRESTClient.Create('https://www.akyloterias.com/web/lotericos/svc/resultados/loterias');
    RESTRequest := TRESTRequest.Create(nil);
    RESTResponse := TRESTResponse.Create(nil);

    // Configurando o Request
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmPOST;

    // Criando JSON de envio
    JSONEnvio := TJSONObject.Create;
    JSONEnvio.AddPair('strData', '2025-02-13');

    // Adicionando JSON ao Body
    RESTRequest.AddBody(JSONEnvio.ToJSON, TRESTContentType.ctAPPLICATION_JSON);

    // Executando a requisição
    RESTRequest.Execute;

    // Pegando o retorno da API
    RetornoTexto := RESTResponse.Content;  // Retorno como string

    // Convertendo para um objeto JSON
    RetornoJSON := TJSONObject.ParseJSONValue(RetornoTexto) as TJSONObject;
    if Assigned(RetornoJSON) then
    begin

      // Pegar a lista de "draws"
      DrawsArray := RetornoJSON.GetValue<TJSONArray>('draws');
      if not Assigned(DrawsArray) then
        Exit;

    for I := 0 to DrawsArray.Count - 1 do
      begin
        DrawObj := DrawsArray.Items[I] as TJSONObject;

        // Pegar a lista de "previousDraws"
        PreviousDrawsArray := DrawObj.GetValue<TJSONArray>('previousDraws');
        if not Assigned(PreviousDrawsArray) then
          Continue;

        // Percorrer "previousDraws"
        for J := 0 to PreviousDrawsArray.Count - 1 do
        begin
          PreviousDrawObj := PreviousDrawsArray.Items[J] as TJSONObject;
          // Obter array "raffledPop"
          RaffledPopArray := PreviousDrawObj.GetValue<TJSONArray>('raffledPop');

          if Assigned(RaffledPopArray) then
          begin

            for K := 0 to RaffledPopArray.Count - 1 do
            begin
              case K of
                0: begin
                    vPremio1 := StrToInt(copy(RaffledPopArray.Items[K].Value,1,4));
                    vGrupo1 := StrToInt(copy(RaffledPopArray.Items[K].Value,6,2));
                  end;
                1: begin
                    vPremio2 := StrToInt(copy(RaffledPopArray.Items[K].Value,1,4));
                    vGrupo2 := StrToInt(copy(RaffledPopArray.Items[K].Value,6,2));
                  end;
                2: begin
                    vPremio3 := StrToInt(copy(RaffledPopArray.Items[K].Value,1,4));
                    vGrupo3 := StrToInt(copy(RaffledPopArray.Items[K].Value,6,2));
                  end;
                3: begin
                    vPremio4 := StrToInt(copy(RaffledPopArray.Items[K].Value,1,4));
                    vGrupo4 := StrToInt(copy(RaffledPopArray.Items[K].Value,6,2));
                  end;
                4: begin
                    vPremio5 := StrToInt(copy(RaffledPopArray.Items[K].Value,1,4));
                    vGrupo5 := StrToInt(copy(RaffledPopArray.Items[K].Value,6,2));
                  end;
              end;
            end;
          end;

          FormatSettings := TFormatSettings.Create;
          FormatSettings.DateSeparator := '-';
          FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

          uUtilBanco.incluirJogo(
            StrToDateTime(PreviousDrawObj.GetValue<string>('timestamp'), FormatSettings),
            PreviousDrawObj.GetValue<string>('raffledDescription'),
            vPremio1,vPremio2,vPremio3,vPremio4,vPremio5,
            vGrupo1,vGrupo2,vGrupo3,vGrupo4,vGrupo5);

        end;
      end;
      RetornoJSON.Free;
    end;
  except
    on E: Exception do
    raise Exception.Create('Erro ao tentar importar. '+e.Message);
  end;

  // Liberando memória
  JSONEnvio.Free;
  RESTRequest.Free;
  RESTResponse.Free;
  RESTClient.Free;
end;

end.
