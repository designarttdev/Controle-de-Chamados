program ControleChamados;

uses
  Vcl.Forms,
  Principal in 'Unit\Principal.pas' {frPrincipal},
  Funcoes in 'Unit\Funcoes.pas' {frFuncoes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.CreateForm(TfrFuncoes, frFuncoes);
  Application.Run;
end.
