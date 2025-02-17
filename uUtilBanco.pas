unit uUtilBanco;

interface

procedure incluirJogo(pData: TDateTime; pDescricao: String; pPremio1: Integer; pPremio2: Integer; pPremio3: Integer; pPremio4: Integer; pPremio5: Integer;
                      pGrupo1: Integer; pGrupo2: Integer; pGrupo3: Integer; pGrupo4: Integer; pGrupo5: Integer);

implementation

uses
  FireDAC.Comp.Client, uDmPrincipal, System.SysUtils;

procedure incluirJogo(pData: TDateTime; pDescricao: String; pPremio1: Integer; pPremio2: Integer; pPremio3: Integer; pPremio4: Integer; pPremio5: Integer;
                      pGrupo1: Integer; pGrupo2: Integer; pGrupo3: Integer; pGrupo4: Integer; pGrupo5: Integer);
begin

  with dmPrincipal do
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
      raise Exception.Create('Erro ao tentar incluir jogo. '+e.Message);
    end;
  end;
end;

end.
