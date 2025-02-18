unit uUtilBanco;

interface


  //Procedures
  procedure apagarUltimaDataResultado(pData: TDateTime);
  procedure incluirResultado(pData: TDateTime; pDescricao: String; pPremio1: Integer; pPremio2: Integer; pPremio3: Integer; pPremio4: Integer; pPremio5: Integer; pGrupo1: Integer; pGrupo2: Integer; pGrupo3: Integer; pGrupo4: Integer; pGrupo5: Integer);
  function retornaNumerosMais(pDataInicio: TDateTime; pQtdNumero: Integer; pQuentes: Boolean; pIntermediarios: Boolean = false):TArray<TArray<Integer>>;
implementation

uses
  FireDAC.Comp.Client, uDmPrincipal, System.SysUtils, FireDAC.Stan.Param, Data.DB;

function retornaNumerosMais(pDataInicio: TDateTime; pQtdNumero: Integer; pQuentes: Boolean; pIntermediarios: Boolean):TArray<TArray<Integer>>;
var
  FormatSettings: TFormatSettings;
  i, vMetadeResultados : Integer;
begin
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

  SetLength(Result, pQtdNumero, 2);

  with dmPrincipal do
  begin
    FDQuery.SQL.Text :=
    '   with numeros_unificados as ( '+
    '    select grupo1 as numero from resultado where data::date >= '+ QuotedStr(DateToStr(pDataInicio, FormatSettings)) +
    '    union all  '+
    '    select grupo2 from resultado where data::date >= '+ QuotedStr(DateToStr(pDataInicio, FormatSettings)) +
    '    union all  '+
    '    select grupo3 from resultado where data::date >=  '+ QuotedStr(DateToStr(pDataInicio, FormatSettings)) +
    '    union all  '+
    '    select grupo4 from resultado where data::date >=  '+ QuotedStr(DateToStr(pDataInicio, FormatSettings)) +
    '    union all  '+
    '    select grupo5 from resultado where data::date >=  '+ QuotedStr(DateToStr(pDataInicio, FormatSettings)) +
    ') '+
    'select numero, count(*) as frequencia '+
    'from numeros_unificados '+
    'group by numero ';

    if pQuentes then
     FDQuery.SQL.Text := FDQuery.SQL.Text + ' order by frequencia desc '
    else
    FDQuery.SQL.Text := FDQuery.SQL.Text + ' order by frequencia asc ';

    if pIntermediarios then
      FDQuery.SQL.Text := FDQuery.SQL.Text + ' limit '+ IntToStr(pQtdNumero * 2)
    else
      FDQuery.SQL.Text := FDQuery.SQL.Text + ' limit '+ IntToStr(pQtdNumero);

    try
      FDQuery.Open;

      if pIntermediarios then
      begin
        vMetadeResultados := Trunc((pQtdNumero * 2)/2);
        for i := 0 to ((FDQuery.RecordCount)-1) do
        begin
          if not(FDQuery.Eof) and (vMetadeResultados < FDQuery.RecNo) then
          begin
            Result[(i - Trunc(vMetadeResultados))][0] := FDQuery.FieldByName('numero').AsInteger;
            Result[(I - Trunc(vMetadeResultados))][1] := FDQuery.FieldByName('frequencia').AsInteger;
          end;
          FDQuery.Next;
        end;
      end
      else
      begin
        for i := 0 to ((FDQuery.RecordCount)-1) do
        begin
          Result[I][0] := FDQuery.FieldByName('numero').AsInteger;
          Result[I][1] := FDQuery.FieldByName('frequencia').AsInteger;
          FDQuery.Next;
        end;
      end;

    except
      on e:Exception do
      raise Exception.Create('Erro na retornaNumerosMais. '+e.Message);
    end;
  end;
end;


procedure apagarUltimaDataResultado(pData: TDateTime);
var
  FormatSettings: TFormatSettings;
begin

  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

  with dmPrincipal do
  begin
    FDQuery.SQL.Text :=
    '	delete ' +
    '	  from resultado ' +
    '	 where data::date = '+QuotedStr(DateToStr(pData, FormatSettings));

    try
      FDQuery.ExecSQL;
    except
      on e:Exception do
      raise Exception.Create('Erro ao tentar excluir resultado. '+e.Message);
    end;
  end;
end;

procedure incluirResultado(pData: TDateTime; pDescricao: String; pPremio1: Integer; pPremio2: Integer; pPremio3: Integer; pPremio4: Integer; pPremio5: Integer; pGrupo1: Integer; pGrupo2: Integer; pGrupo3: Integer; pGrupo4: Integer; pGrupo5: Integer);
begin
  with dmPrincipal do
  begin
    FDQueryAux.SQL.Text :=
        ' 	select codigo                   ' +
        ' 	  from public.resultado         ' +
        ' 	 where data = :data             ' +
        '        and descricao = :descricao ' ;

    FDQueryAux.ParamByName('data').AsDateTime := pData;
    FDQueryAux.ParamByName('descricao').AsString := pDescricao;

    try
      FDQueryAux.Open;
    except
      on e:Exception do
      raise Exception.Create('Erro ao tentar incluir resultado. '+e.Message);
    end;

    if FDQueryAux.IsEmpty then
    begin
      FDQuery.SQL.Text :=
          ' INSERT INTO public.resultado(                                                                                               '+
          ' 	data, descricao, premio1, premio2, premio3, premio4, premio5, grupo1, grupo2, grupo3, grupo4, grupo5)                     '+
          ' 	VALUES (:data, :descricao, :premio1, :premio2, :premio3, :premio4, :premio5, :grupo1, :grupo2, :grupo3, :grupo4, :grupo5) ';

      FDQuery.ParamByName('data').AsDateTime := pData;
      FDQuery.ParamByName('descricao').AsString := pDescricao;
      FDQuery.ParamByName('premio1').AsInteger := pPremio1;
      FDQuery.ParamByName('premio2').AsInteger := pPremio2;
      FDQuery.ParamByName('premio3').AsInteger := pPremio3;
      FDQuery.ParamByName('premio4').AsInteger := pPremio4;
      FDQuery.ParamByName('premio5').AsInteger := pPremio5;

      FDQuery.ParamByName('grupo1').AsInteger := pGrupo1;
      FDQuery.ParamByName('grupo2').AsInteger := pGrupo2;
      FDQuery.ParamByName('grupo3').AsInteger := pGrupo3;
      FDQuery.ParamByName('grupo4').AsInteger := pGrupo4;
      FDQuery.ParamByName('grupo5').AsInteger := pGrupo5;

      try
        FDQuery.ExecSQL;
      except
        on e:Exception do
        raise Exception.Create('Erro ao tentar incluir resultado. '+e.Message);
      end;
    end;
  end;
end;


end.
