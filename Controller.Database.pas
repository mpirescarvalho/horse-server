unit Controller.Database;

interface

uses
  Controller.Interfaces, Horse, FireDAC.Comp.Client, FireDAC.DApt, System.JSON,
  System.Generics.Collections;

type
  TControllerDatabase = class
  private
    App: THorse;
    Conexao: TFDConnection;
    Controllers: TList<IController>;
    DataBaseInfo: TDictionary<String, String>;
    FQuery: TFDQuery;
    procedure LoadDatabaseInfo;
    procedure CreateControllers;
    procedure RegistryControllers;
    function GetController(Tabela, PrimaryKey: string): IController;
  public
    constructor Create(App: THorse; Conexao: TFDConnection);
    procedure Init;
  end;

implementation

uses
  System.SysUtils, Controller.Generic, System.Rtti, Controller.Base;

{ TControllerDatabase }

constructor TControllerDatabase.Create(App: THorse; Conexao: TFDConnection);
begin
  Controllers := TList<IController>.Create;
  Self.App := App;
  Self.Conexao := Conexao;
end;

procedure TControllerDatabase.CreateControllers;
var
  I: Integer;
  Key: String;
begin
  for Key in DataBaseInfo.Keys do
    if not DataBaseInfo[Key].Equals('') then
    begin
      Writeln(Format('Iniciando tabela: %s', [Key]));
      Controllers.Add(GetController(Key, DataBaseInfo[Key]));
    end;
  Writeln(Format('Tabelas iniciadas: %d', [Controllers.Count]));
end;

function TControllerDatabase.GetController(Tabela,
  PrimaryKey: string): IController;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  ToPropriedade: TRttiProperty;
  Controller: IController;
  Metodo: TRttiMethod;
begin

  for Tipo in Contexto.GetTypes do
    if (Tipo.TypeKind = tkClass) 
    and Tipo.IsInstance 
    and Tipo.AsInstance.MetaclassType.InheritsFrom(TControllerBase)
    then
    begin
      Metodo := Tipo.AsInstance.GetMethod('New');
      Controller := Metodo.Invoke(Tipo.AsInstance.MetaclassType,[]).AsInterface as IController;      
      if (TControllerBase(Controller).TableName = Tabela) and 
         (TControllerBase(Controller).PrimaryKey = PrimaryKey) then
        Exit(TInterfacedObject(Controller) as IController);
    end;
    
  Exit(TControllerGeneric.Create(Tabela, PrimaryKey));
  
end;

procedure TControllerDatabase.Init;
begin
  LoadDatabaseInfo;
  CreateControllers;
  RegistryControllers;
end;

procedure TControllerDatabase.LoadDatabaseInfo;
var
  SQL: String;
begin

  if not Assigned(DataBaseInfo) then
    DataBaseInfo := TDictionary<String, String>.Create;

  FQuery := TFDQuery.Create(nil);
  try

    FQuery.Connection := Conexao;
    DataBaseInfo.Clear;

    SQL := 'select rdb$relation_name as TABELA, (select first 1 idx.RDB$FIELD_NAME as PRIMARY_KEY from RDB$RELATION_CONSTRAINTS tc join RDB$INDEX_SEGMENTS idx on (idx.RDB$INDEX_NAME = ' +
           'tc.RDB$INDEX_NAME) where ' +
           'tc.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' and ' +
           'tc.RDB$RELATION_NAME = rdb$relations.RDB$RELATION_NAME ' +
           'order by idx.RDB$FIELD_POSITION) ' +
           'from rdb$relations ' +
           'where rdb$view_blr is null ' +
           'and (rdb$system_flag is null or rdb$system_flag = 0)';

    FQuery.Open(SQL);
    FQuery.First;
    while not FQuery.Eof do
    begin
      DataBaseInfo.Add(FQuery.Fields[0].AsString, FQuery.Fields[1].AsString);
      FQuery.Next;
    end;

  finally
    FQuery.Free;
  end;

end;

procedure TControllerDatabase.RegistryControllers;
var
  I: Integer;
begin
  for I := 0 to Pred(Controllers.Count) do
    Controllers[I].Registry(App, Conexao);
end;

end.
