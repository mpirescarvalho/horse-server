unit Controller.Cidades;

interface

uses
  Controller.Base;

type
  TControllerCidades = class(TControllerBase)
  protected
    function Path: String; override;
    function TableName: String; override;
    function PrimaryKey: String; override;
  end;

implementation

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
