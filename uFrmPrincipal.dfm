object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmPrincipal'
  ClientHeight = 380
  ClientWidth = 937
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 41
    Align = alTop
    TabOrder = 0
    object BtnAdicionar: TButton
      Left = 252
      Top = 11
      Width = 125
      Height = 25
      Caption = 'Salvar registro'
      TabOrder = 0
      OnClick = BtnAdicionarClick
    end
    object btnSalvar: TButton
      Left = 657
      Top = 10
      Width = 128
      Height = 25
      Caption = 'Salvar em arquivo'
      TabOrder = 1
      Visible = False
      OnClick = btnSalvarClick
    end
    object btnCarregar: TButton
      Left = 791
      Top = 10
      Width = 126
      Height = 25
      Caption = 'Carregar arquivo'
      TabOrder = 2
      Visible = False
      OnClick = btnCarregarClick
    end
    object EditNome: TEdit
      Left = 11
      Top = 12
      Width = 121
      Height = 23
      TabOrder = 3
    end
    object DatePickerNascimento: TDateTimePicker
      Left = 138
      Top = 13
      Width = 108
      Height = 23
      Date = 45700.000000000000000000
      Time = 0.911538101849146200
      TabOrder = 4
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 937
    Height = 339
    Align = alClient
    DataSource = dsPrincipalGrupo
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 272
    Top = 80
  end
  object dsPrincipalGrupo: TDataSource
    DataSet = FDMemTable1
    Left = 328
    Top = 64
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 200
    Top = 168
  end
end
