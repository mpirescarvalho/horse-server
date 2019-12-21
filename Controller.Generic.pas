unit Controller.Generic;

interface

uses
  Controller.Base;

type
  TControllerGeneric = class(TControllerBase)
  private
    FTable: String;
    FPrimaryKey: String;
  protected
    function Path: String; override;
    function TableName: String; override;
    function PrimaryKey: String; override;
  public
    constructor Create(Tabela, PrimaryKey: String); reintroduce;
  end;

implementation

uses
  System.SysUtils;

{ TControllerGenerics }

constructor TControllerGeneric.Create(Tabela, PrimaryKey: String);
begin
  inherited Create;
  FTable := Tabela;
  FPrimaryKey := PrimaryKey;
end;

function TControllerGeneric.Path: String;
begin
  Result := Format('/%s', [FTable.ToLower]);
end;

function TControllerGeneric.PrimaryKey: String;
begin
  Result := FPrimaryKey;
end;

function TControllerGeneric.TableName: String;
begin
  Result := FTable;
end;

end.
