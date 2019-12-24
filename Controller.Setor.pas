unit Controller.Setor;

interface

uses
  Controller.Base;

type
  TControllerSetor = class(TControllerBase)
  protected
    function Path: String; override;
    function TableName: String; override;
    function PrimaryKey: String; override;
  end;

implementation

{ TControllerSetor }

function TControllerSetor.PrimaryKey: String;
begin
  Result := 'SET_CODIGO';
end;

function TControllerSetor.Path: String;
begin
  Result := '/setor';
end;

function TControllerSetor.TableName: String;
begin
  Result := 'SETOR';
end;

initialization
  TControllerSetor.ClassName;

end.
