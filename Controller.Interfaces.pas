unit Controller.Interfaces;

interface

uses
  Horse, FireDAC.Comp.Client;

type
  IController = interface
    ['{26CBDFC7-ECEC-43C1-97E9-06686C23ACE3}']
    function Registry(App: THorse): IController;
  end;

implementation

end.
