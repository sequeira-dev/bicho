unit uUtil;

interface

procedure importarResultados(pDataInicio: TDateTime; pImportarTudoEmDiante: Boolean = False); // pImportarTudoEmDiante = Se sim, vai trazer tudo apartir da pDataInicio. Se não, apenas a pDataInicio

implementation

uses
  REST.Client, System.JSON, System.SysUtils, REST.Types, uUtilBanco,
  System.Generics.Collections;

procedure importarResultados(pDataInicio: TDateTime; pImportarTudoEmDiante: Boolean); // pImportarTudoEmDiante = Se sim, vai trazer tudo apartir da pDataInicio. Se não, apenas a pDataInicio
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONEnvio: TJSONObject;
  RetornoJSON: TJSONObject;
  DrawObj, PreviousDrawObj: TJSONObject;
  RetornoTexto: string;
  DrawsArray, PreviousDrawsArray, RaffledPopArray: TJSONArray;
  I, J, K, vPremio1, vPremio2, vPremio3, vPremio4, vPremio5, vGrupo1, vGrupo2, vGrupo3, vGrupo4, vGrupo5: Integer;
  FormatSettings: TFormatSettings;
  vDataInicio: TDateTime;
begin

  vPremio1 := 0;
  vGrupo1 := 0;

  vPremio2 := 0;
  vGrupo2 := 0;

  vPremio3 := 0;
  vGrupo3 := 0;

  vPremio4 := 0;
  vGrupo4 := 0;

  vPremio5 := 0;
  vGrupo5 := 0;

  // Criando os objetos REST
  RESTClient := TRESTClient.Create('https://www.akyloterias.com/web/lotericos/svc/resultados/loterias');
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    try

      // Configurando o Request
      RESTRequest.Client := RESTClient;
      RESTRequest.Response := RESTResponse;
      RESTRequest.Method := rmPOST;

      FormatSettings := TFormatSettings.Create;
      FormatSettings.DateSeparator := '-';
      FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

      vDataInicio := pDataInicio;

      while vDataInicio <= Now do
      begin

          // Criando JSON de envio
        JSONEnvio := TJSONObject.Create;

        try
          JSONEnvio.AddPair('strData', DateToStr(vDataInicio, FormatSettings));

          RESTRequest.Params.Clear;  // Limpa parâmetros
          RESTRequest.ClearBody;

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
                      0:
                        begin
                          vPremio1 := StrToInt(copy(RaffledPopArray.Items[K].Value, 1, 4));
                          vGrupo1 := StrToInt(copy(RaffledPopArray.Items[K].Value, 6, 2));
                        end;
                      1:
                        begin
                          vPremio2 := StrToInt(copy(RaffledPopArray.Items[K].Value, 1, 4));
                          vGrupo2 := StrToInt(copy(RaffledPopArray.Items[K].Value, 6, 2));
                        end;
                      2:
                        begin
                          vPremio3 := StrToInt(copy(RaffledPopArray.Items[K].Value, 1, 4));
                          vGrupo3 := StrToInt(copy(RaffledPopArray.Items[K].Value, 6, 2));
                        end;
                      3:
                        begin
                          vPremio4 := StrToInt(copy(RaffledPopArray.Items[K].Value, 1, 4));
                          vGrupo4 := StrToInt(copy(RaffledPopArray.Items[K].Value, 6, 2));
                        end;
                      4:
                        begin
                          vPremio5 := StrToInt(copy(RaffledPopArray.Items[K].Value, 1, 4));
                          vGrupo5 := StrToInt(copy(RaffledPopArray.Items[K].Value, 6, 2));
                        end;
                    end;
                  end;
                end;

                uUtilBanco.incluirResultado(StrToDateTime(PreviousDrawObj.GetValue<string>('timestamp'), FormatSettings), PreviousDrawObj.GetValue<string>('raffledDescription'), vPremio1, vPremio2, vPremio3, vPremio4, vPremio5, vGrupo1, vGrupo2, vGrupo3, vGrupo4, vGrupo5);

              end;
            end;
          end;
        finally
          JSONEnvio.Free;
        end;

        vDataInicio := vDataInicio + 1;

        if pImportarTudoEmDiante = False then
          Exit;
      end;
    except
      on E: Exception do
        raise Exception.Create('Erro ao tentar importar. ' + e.Message);
    end;
  finally
    // Liberando memória
    RESTRequest.Free;
    RESTResponse.Free;
    RESTClient.Free;
    RetornoJSON.Free;
  end;

end;

end.

