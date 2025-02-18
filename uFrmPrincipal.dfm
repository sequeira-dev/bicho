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
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Dashboard'
      object Label4: TLabel
        Left = 182
        Top = 12
        Width = 52
        Height = 15
        Caption = 'Apartir de'
      end
      object Label5: TLabel
        Left = 182
        Top = 62
        Width = 107
        Height = 15
        Caption = 'Quantos n'#250'meros'
      end
      object DateTimePicker1: TDateTimePicker
        Left = 182
        Top = 33
        Width = 99
        Height = 23
        Date = 45706.000000000000000000
        Time = 0.592200451392273000
        TabOrder = 0
      end
      object BitBtn1: TBitBtn
        Left = 3
        Top = 12
        Width = 173
        Height = 94
        Caption = 'Processar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn1Click
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 112
        Width = 766
        Height = 197
        Align = alBottom
        Caption = ' GRUPO '
        TabOrder = 2
        object pnlMaisQuente: TPanel
          Left = 2
          Top = 17
          Width = 185
          Height = 178
          Align = alLeft
          TabOrder = 0
          ExplicitLeft = 72
          ExplicitTop = 24
          ExplicitHeight = 170
          object Label2: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 177
            Height = 15
            Align = alTop
            Caption = 'Os mais QUENTES'
            ExplicitWidth = 95
          end
          object Memo1: TMemo
            AlignWithMargins = True
            Left = 4
            Top = 25
            Width = 177
            Height = 149
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object pnlMaisFrios: TPanel
          Left = 187
          Top = 17
          Width = 185
          Height = 178
          Align = alLeft
          TabOrder = 1
          ExplicitLeft = 442
          ExplicitTop = 33
          object Label3: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 177
            Height = 15
            Align = alTop
            Caption = 'Os mais FRIOS'
            ExplicitWidth = 76
          end
          object Memo2: TMemo
            AlignWithMargins = True
            Left = 4
            Top = 25
            Width = 177
            Height = 149
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object SpinEdit1: TSpinEdit
        Left = 182
        Top = 82
        Width = 52
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
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
          Time = 45661.000000000000000000
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
  object Timer: TTimer
    Interval = 60000
    OnTimer = TimerTimer
    Left = 444
    Top = 65531
  end
end
