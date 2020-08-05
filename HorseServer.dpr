program HorseServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Rtti,
  Horse,
  Controller.Cidades in 'Controller.Cidades.pas',
  Controller.Interfaces in 'Controller.Interfaces.pas',
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Controller.Base in 'Controller.Base.pas',
  Controller.Setor in 'Controller.Setor.pas',
  Controller.Marca in 'Controller.Marca.pas',
  Controller.Estados in 'Controller.Estados.pas',
  Controller.Database in 'Controller.Database.pas',
  Controller.Generic in 'Controller.Generic.pas',
  Utils in 'Utils.pas';

var
  App: THorse;

begin
  try
    App := THorse.Create(9000);
    App.Use(Jhonson);
    TControllerDatabase.Create(App).Init;
    App.Start;
  except on E: Exception do
    begin
      Writeln('Erro: ' + E.message);
      Readln;
    end;
  end;
end.
