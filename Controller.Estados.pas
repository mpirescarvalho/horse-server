unit Controller.Estados;

interface

uses
  Controller.Base;

type
  TControllerEstados = class(TControllerBase)
  protected
    function Path: String; override;
    function TableName: String; override;
    function PrimaryKey: String; override;
  end;

implementation

{ TControllerEstados }

function TControllerEstados.PrimaryKey: String;
begin
  Result := 'EST_CODIGO';
end;

function TControllerEstados.Path: String;
begin
  Result := '/estados';
end;

function TControllerEstados.TableName: String;
begin
  Result := 'ESTADOS';
end;

end.
