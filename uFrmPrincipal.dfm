object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmPrincipal'
  ClientHeight = 380
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 937
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 774
    Height = 339
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 937
    object TabSheet1: TTabSheet
      Caption = 'Resultados'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 766
        Height = 309
        Align = alClient
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
      object Panel2: TPanel
        Left = 139
        Top = 149
        Width = 478
        Height = 115
        BevelOuter = bvNone
        TabOrder = 0
        object gauLogImporatacao: TGauge
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 472
          Height = 15
          Align = alBottom
          Progress = 0
          ExplicitWidth = 338
        end
        object memLogImportacao: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 24
          Width = 472
          Height = 88
          Align = alBottom
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object GroupBox1: TGroupBox
        Left = 139
        Top = 38
        Width = 478
        Height = 105
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 49
          Height = 30
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object btnImportarResultadosAPI: TBitBtn
          Left = 16
          Top = 72
          Width = 454
          Height = 30
          Caption = 'IMPORTAR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnImportarResultadosAPIClick
        end
        object DataInicio: TDateTimePicker
          Left = 79
          Top = 12
          Width = 129
          Height = 38
          Date = 45661.000000000000000000
          Time = 0.581977870373521000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object chkImportacao: TCheckBox
          Left = 224
          Top = -1
          Width = 497
          Height = 65
          Caption = 'Atualizar todos os dias '#13#10'apartir desta data?'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 2
          WordWrap = True
        end
      end
    end
  end
  object TimerImportacao: TTimer
    Interval = 60000
    OnTimer = TimerImportacaoTimer
    Left = 476
    Top = 11
  end
end
