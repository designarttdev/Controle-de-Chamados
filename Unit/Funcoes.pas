unit Funcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.ExtCtrls;

type
  TfrFuncoes = class(TForm)
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
    vIndicator : TActivityIndicator;
    vPanelAnimation : TPanel;
  Function RetornaPanel(vForm : TForm) : TPanel;
  function RetornaAiLoading(vForm : TForm) : TActivityIndicator;
  procedure FechaCarregamento;
  end;

var
  frFuncoes: TfrFuncoes;

implementation

{$R *.dfm}

{ TfrFuncoes }

procedure TfrFuncoes.FechaCarregamento;
begin
  vIndicator.Free;
  vPanelAnimation.Free;
end;

function TfrFuncoes.RetornaAiLoading(vForm: TForm): TActivityIndicator;
begin
  {$REGION 'Cria Animação'}

    //usar a classe "Vcl.WinXCtrls" no Uses para usar este componente
    vIndicator                := TActivityIndicator.Create(self);
    vIndicator.Parent         := vForm;
    vIndicator.IndicatorSize  := aisXLarge;
    vIndicator.FrameDelay     := 40;
    vIndicator.Animate        := True;
    vIndicator.IndicatorType  := aitMomentumDots;
    vIndicator.IndicatorColor := aicBlack;
    vIndicator.StyleElements := [];
    vIndicator.BringToFront;

  {$ENDREGION}

  {$REGION 'Centraliza componentes'}

    vIndicator.Left := Trunc((vForm.ClientWidth / 2) - (vIndicator.Width / 2));
    vIndicator.top  := Trunc((vForm.ClientHeight / 2) - (vIndicator.Height / 2));

  {$ENDREGION}
end;

function TfrFuncoes.RetornaPanel(vForm: TForm): TPanel;
begin
  {$REGION 'Cria Panel'}

    vPanelAnimation        := TPanel.Create(self);
    vPanelAnimation.Parent := vForm;
    vPanelAnimation.Height := vForm.ClientHeight;
    vPanelAnimation.Width  := vForm.ClientWidth;
    vPanelAnimation.Top    := 0;
    vPanelAnimation.Left   := 0;
    vPanelAnimation.BringToFront;

  {$ENDREGION}
end;

end.

