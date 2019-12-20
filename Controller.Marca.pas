unit Controller.Marca;

interface

uses
  Controller.Base;

type
  TControllerMarca = class(TControllerBase)
  protected
    function Path: String; override;
    function TableName: String; override;
    function PrimaryKey: String; override;
  end;

implementation

{ TControllerMarca }

function TControllerMarca.PrimaryKey: String;
begin
  Result := 'MAR_CODIGO';
end;

function TControllerMarca.Path: String;
begin
  Result := '/marca';
end;

function TControllerMarca.TableName: String;
begin
  Result := 'MARCA';
end;

end.
