unit Controller.Cidades;

interface

uses
  Controller.Base, System.JSON;

type
  TControllerCidades = class(TControllerBase)
  public
    function Path: String; override;
    function TableName: String; override;
    function PrimaryKey: String; override;
    procedure AdicionarSubQueries(JsonObj: TJSONObject); override;
  end;

implementation

uses
  Controller.Estados, System.SysUtils;

{ TControllerCidades }

function TControllerCidades.PrimaryKey: String;
begin
  Result := 'CID_CODIGO';
end;

procedure TControllerCidades.AdicionarSubQueries(JsonObj: TJSONObject);
var
  Where: string;
begin
  try
    if JsonObj.GetValue<Integer>('EST_CODIGO') > 0 then
    begin
      Where := Format('EST_CODIGO=%d', [JsonObj.GetValue<Integer>('EST_CODIGO')]);
      JsonObj.AddPair('ESTADO', TControllerEstados(TControllerEstados.New).Query(Where).Items[0]);
    end;
  except
  end;
end;

function TControllerCidades.Path: String;
begin
  Result := '/cidades';
end;

function TControllerCidades.TableName: String;
begin
  Result := 'CIDADES';
end;

initialization
  TControllerCidades.ClassName;

end.
