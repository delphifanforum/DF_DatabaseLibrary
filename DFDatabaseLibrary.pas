{*******************************************************************************
*                                                                              *
*  This is a database library for Delphi using FireDAC                           *
*                                                                              *
*  Library created by the DelphiFan Forum                                       *
*                                                                              *
*******************************************************************************}
unit DFDatabaseLibrary;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TDFDatabaseLibrary = class
  private
    FConnection: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Connect(const AServer, ADatabase, AUsername, APassword: string; const APort: Integer; const ADatabaseType: string);
    procedure Disconnect;

    procedure CreateTable(const ATableName: string; const AFields: string);
    procedure DropTable(const ATableName: string);

    function ExecuteQuery(const ASQL: string; const AParams: array of Variant): TFDQuery;
    procedure ExecuteUpdate(const ASQL: string; const AParams: array of Variant);
    procedure ExecuteInsert(const ASQL: string; const AParams: array of Variant);
  end;

implementation

{ TDFDatabaseLibrary }

constructor TDFDatabaseLibrary.Create;
begin
  FConnection := TFDConnection.Create(nil);
end;

destructor TDFDatabaseLibrary.Destroy;
begin
  Disconnect;
  FConnection.Free;
  inherited;
end;

procedure TDFDatabaseLibrary.Connect(const AServer, ADatabase, AUsername, APassword: string; const APort: Integer; const ADatabaseType: string);
begin
  FConnection.Params.Clear;
  FConnection.Params.Add('Server=' + AServer);
  FConnection.Params.Add('Database=' + ADatabase);
  FConnection.Params.Add('Username=' + AUsername);
  FConnection.Params.Add('Password=' + APassword);
  FConnection.Params.Add('Port=' + IntToStr(APort));
  FConnection.Params.Add('DriverID=' + ADatabaseType);
  FConnection.Connected := True;
end;

procedure TDFDatabaseLibrary.Disconnect;
begin
  FConnection.Connected := False;
end;

procedure TDFDatabaseLibrary.CreateTable(const ATableName, AFields: string);
begin
  ExecuteUpdate('CREATE TABLE ' + ATableName + ' (' + AFields + ')', []);
end;

procedure TDFDatabaseLibrary.DropTable(const ATableName: string);
begin
  ExecuteUpdate('DROP TABLE ' + ATableName, []);
end;

function TDFDatabaseLibrary.ExecuteQuery(const ASQL: string; const AParams: array of Variant): TFDQuery;
var
  Query: TFDQuery;
  I: Integer;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := ASQL;
    for I := Low(AParams) to High(AParams) do
    begin
      Query.ParamByName('Param' + IntToStr(I)).Value := AParams[I];
    end;
    Query.Open;
    Result := Query;
  except
    Query.Free;
    raise;
  end;
end;

procedure TDFDatabaseLibrary.ExecuteUpdate(const ASQL: string; const AParams: array of Variant);
var
  Query: TFDQuery;
  I: Integer;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := ASQL;
    for I := Low(AParams) to High(AParams) do
    begin
      Query.ParamByName('Param' + IntToStr(I)).Value := AParams[I];
    end;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TDFDatabaseLibrary.ExecuteInsert(const ASQL: string;const AParams: array of Variant);
begin
  ExecuteUpdate(ASQL, AParams);
end;

end.
