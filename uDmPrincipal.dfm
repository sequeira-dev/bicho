object dmPrincipal: TdmPrincipal
  OnCreate = DataModuleCreate
  Height = 600
  Width = 800
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=bicho'
      'User_Name=postgres'
      'Password=postgres'
      'Port=5433'
      'DriverID=PG')
    LoginPrompt = False
    Left = 86
    Top = 54
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 221
    Top = 47
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 166
    Top = 122
  end
  object FDQueryAux: TFDQuery
    Connection = FDConnection
    Left = 240
    Top = 128
  end
end
