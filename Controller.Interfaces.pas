unit Controller.Interfaces;

interface

uses
  Horse, FireDAC.Comp.Client;

type
  IController = interface
    function Registry(App: THorse; FConn: TFDConnection): IController;
  end;

implementation

end.
