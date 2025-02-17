unit uUtil;

interface

procedure importarResultados(pDataInicio: TDateTime; pImportarTudoEmDiante: Boolean = False); // pImportarTudoEmDiante = Se sim, vai trazer tudo apartir da pDataInicio. Se não, apenas a pDataInicio

implementation

uses
  REST.Client, System.JSON, System.SysUtils, REST.Types, uUtilBanco,
  System.Generics.Collections;

procedure importarResultados(pDataInicio: TDateTime; pImportarTudoEmDiante: Boolean); // pImportarTudoEmDiante = Se sim, vai trazer tudo apartir da pDataInicio. Se não, apenas a pDataInicio
var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONEnvio: TJSONObject;
  vRetornoJSON: TJSONObject;
  vDrawObj, vPreviousDrawObj: TJSONObject;
  vRetornoTexto: string;
  vDrawsArray, vPreviousDrawsArray, vRaffledPopArray: TJSONArray;
  I, J, K, vPremio1, vPremio2, vPremio3, vPremio4, vPremio5, vGrupo1, vGrupo2, vGrupo3, vGrupo4, vGrupo5: Integer;
  vFormatSettings: TFormatSettings;
  vDataInicio: TDateTime;
  vUltimaDataApagada: Boolean;
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

  vUltimaDataApagada := False;

  // Criando os objetos REST
  vRESTClient := TRESTClient.Create('https://www.akyloterias.com/web/lotericos/svc/resultados/loterias');
  vRESTRequest := TRESTRequest.Create(nil);
  vRESTResponse := TRESTResponse.Create(nil);

  try
    try
      // Configurando o Request
      vRESTRequest.Client := vRESTClient;
      vRESTRequest.Response := vRESTResponse;
      vRESTRequest.Method := rmPOST;

      vFormatSettings := TFormatSettings.Create;
      vFormatSettings.DateSeparator := '-';
      vFormatSettings.ShortDateFormat := 'yyyy-mm-dd';

      vDataInicio := pDataInicio;

      while vDataInicio <= Now do
      begin

        // verifica se existe todos os premios, caso seja verdadeiro vai pra data seguinte
        if not(uUtilBanco.dataIncluida(vDataInicio)) then
        begin

          // Necessario, porque ainda não tem como passar o parametro na requisao com o horario, sendo assim, apaga-se todos os resultados do dia
          if (vDataInicio = uUtilBanco.pegaUltimaDataResultado) and (vUltimaDataApagada = False) then
          begin
            uUtilBanco.apagarUltimaDataResultado(vDataInicio);
            vUltimaDataApagada := True;
          end;

          // Criando JSON de envio
          vJSONEnvio := TJSONObject.Create;

          try
            vJSONEnvio.AddPair('strData', DateToStr(vDataInicio, vFormatSettings));

          // Limpa parâmetros
            vRESTRequest.Params.Clear;

          // Limpa o body;
            vRESTRequest.ClearBody;

            // Adicionando JSON ao Body
            vRESTRequest.AddBody(vJSONEnvio.ToJSON, TRESTContentType.ctAPPLICATION_JSON);


            // Executando a requisição
            vRESTRequest.Execute;

            // Pegando o retorno da API
            vRetornoTexto := vRESTResponse.Content;  // Retorno como string

            // Convertendo para um objeto JSON
            vRetornoJSON := TJSONObject.ParseJSONValue(vRetornoTexto) as TJSONObject;
            if Assigned(vRetornoJSON) then
            begin

              // Pegar a lista de "draws"
              vDrawsArray := vRetornoJSON.GetValue<TJSONArray>('draws');
              if not Assigned(vDrawsArray) then
                Exit;

              for I := 0 to vDrawsArray.Count - 1 do
              begin
                vDrawObj := vDrawsArray.Items[I] as TJSONObject;

                // Pegar a lista de "previousDraws"
                vPreviousDrawsArray := vDrawObj.GetValue<TJSONArray>('previousDraws');
                if not Assigned(vPreviousDrawsArray) then
                  Continue;

                // Percorrer "previousDraws"
                for J := 0 to vPreviousDrawsArray.Count - 1 do
                begin
                  vPreviousDrawObj := vPreviousDrawsArray.Items[J] as TJSONObject;
                  // Obter array "raffledPop"
                  vRaffledPopArray := vPreviousDrawObj.GetValue<TJSONArray>('raffledPop');

                  if Assigned(vRaffledPopArray) then
                  begin

                    for K := 0 to vRaffledPopArray.Count - 1 do
                    begin
                      case K of
                        0:
                          begin
                            vPremio1 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 1, 4));
                            vGrupo1 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 6, 2));
                          end;
                        1:
                          begin
                            vPremio2 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 1, 4));
                            vGrupo2 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 6, 2));
                          end;
                        2:
                          begin
                            vPremio3 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 1, 4));
                            vGrupo3 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 6, 2));
                          end;
                        3:
                          begin
                            vPremio4 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 1, 4));
                            vGrupo4 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 6, 2));
                          end;
                        4:
                          begin
                            vPremio5 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 1, 4));
                            vGrupo5 := StrToInt(copy(vRaffledPopArray.Items[K].Value, 6, 2));
                          end;
                      end;
                    end;
                  end;

                  uUtilBanco.incluirResultado(StrToDateTime(vPreviousDrawObj.GetValue<string>('timestamp'), vFormatSettings), vPreviousDrawObj.GetValue<string>('raffledDescription'), vPremio1, vPremio2, vPremio3, vPremio4, vPremio5, vGrupo1, vGrupo2, vGrupo3, vGrupo4, vGrupo5);

                end;
              end;
            end;
          finally
            vJSONEnvio.Free;
          end;
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
    vRESTRequest.Free;
    vRESTResponse.Free;
    vRESTClient.Free;
    vRetornoJSON.Free;
  end;

end;

end.

