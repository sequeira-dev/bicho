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
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 935
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 937
    Height = 339
    ActivePage = TabSheet2
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
      object btnImportarResultadosAPI: TBitBtn
        Left = 430
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Importar'
        TabOrder = 0
        OnClick = btnImportarResultadosAPIClick
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
end
