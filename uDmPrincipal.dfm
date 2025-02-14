object dmPrincipal: TdmPrincipal
  OnCreate = DataModuleCreate
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=bicho'
      'User_Name=postgres'
      'Password=postgres'
      'Port=5433'
      'DriverID=PG')
    LoginPrompt = False
    Left = 108
    Top = 67
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 276
    Top = 59
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 208
    Top = 152
  end
end
