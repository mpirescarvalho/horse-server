unit Utils;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBDef,
  FireDAC.Phys.IBWrapper,
  FireDAC.Phys.FB;

function CreateConexao: TFDConnection;

implementation

function CreateConexao: TFDConnection;
var
  Conexao: TFDConnection;
begin
  Conexao := TFDConnection.Create(nil);
  Conexao.Params.Add('Server=127.0.0.1');
  Conexao.Params.Add('Port=3050');
  Conexao.Params.Add('Database=C:\PCMaster\CadizERP\Dados\CADIZERP_LIMPO_TESTE_UTF8.FDB');
  Conexao.Params.Add('User_Name=sysdba');
  Conexao.Params.Add('Password=masterkey');
  Conexao.Params.Add('DriverID=FB');
  Conexao.Params.Add('Pooled=False');
  Conexao.Params.Add('CharacterSet=UTF8');
  Conexao.Connected := True;
  Result := Conexao;
end;

end.
