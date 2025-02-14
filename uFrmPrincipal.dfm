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
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 935
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
      OnClick = btnSalvarClick
    end
    object btnCarregar: TButton
      Left = 791
      Top = 10
      Width = 126
      Height = 25
      Caption = 'Carregar arquivo'
      TabOrder = 2
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
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 937
    Height = 339
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Resultados'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 929
        Height = 309
        Align = alClient
        DataSource = dsPrincipalGrupo
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Importar resultados'
      ImageIndex = 1
      object BitBtn1: TBitBtn
        Left = 430
        Top = 32
        Width = 75
        Height = 25
        Caption = 'BitBtn1'
        TabOrder = 0
      end
      object Memo1: TMemo
        Left = 40
        Top = 80
        Width = 849
        Height = 209
        Lines.Strings = (
          'Memo1')
        TabOrder = 1
      end
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 880
    Top = 312
  end
  object dsPrincipalGrupo: TDataSource
    DataSet = FDMemTable1
    Left = 848
    Top = 312
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 816
    Top = 312
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=bicho'
      'User_Name=postgres'
      'Password=postgres'
      'Port=5433'
      'DriverID=PG')
    LoginPrompt = False
    Left = 476
    Top = 83
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 476
    Top = 139
  end
end
