program HorseServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Rtti,
  Horse,
  Controller.Cidades in 'Controller.Cidades.pas',
  Controller.Interfaces in 'Controller.Interfaces.pas',
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
  FireDAC.Phys.FB,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Controller.Base in 'Controller.Base.pas',
  Controller.Setor in 'Controller.Setor.pas',
  Controller.Marca in 'Controller.Marca.pas',
  Controller.Estados in 'Controller.Estados.pas',
  Controller.Database in 'Controller.Database.pas',
  Controller.Generic in 'Controller.Generic.pas';

var
  App: THorse;
  Conexao: TFDConnection;

procedure SetupConexao;
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
end;

begin
  try
    SetupConexao;
    App := THorse.Create(9000);
    App.Use(Jhonson);

//    App.Use(HorseBasicAuthentication(
//    function(const AUsername, APassword: string): Boolean
//    begin
//      Result := AUsername.Equals('admin') and APassword.Equals('admin');
//    end));

    //Registrar tabelas individuais
//    TControllerCidades.Create.Registry(App, Conexao);
//    TControllerEstados.Create.Registry(App, Conexao);
//    TControllerSetor.Create.Registry(App, Conexao);
//    TControllerMarca.Create.Registry(App, Conexao);

    //Registrar todas as tabelas to banco
    TControllerDatabase.Create(App, Conexao).Init;

    App.Start;
  except on E: Exception do
    Writeln('Erro: ' + E.message);
  end;
end.
