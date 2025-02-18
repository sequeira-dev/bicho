program bicho;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uUtilBanco in 'uUtilBanco.pas',
  uDmPrincipal in 'uDmPrincipal.pas' {dmPrincipal: TDataModule},
  uUtil in 'uUtil.pas',
  uConstantes in 'uConstantes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
