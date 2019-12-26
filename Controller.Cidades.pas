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
  end;

implementation

uses
  Controller.Estados, System.SysUtils;

{ TControllerCidades }

function TControllerCidades.PrimaryKey: String;
begin
  Result := 'CID_CODIGO';
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
