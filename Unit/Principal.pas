unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait, Vcl.Menus, System.MaskUtils, FireDAC.Phys.MSAcc,
  FireDAC.Phys.MSAccDef, StrUtils, Vcl.Samples.Gauges, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, System.Win.TaskbarCore, Vcl.Taskbar;

type
  TfrPrincipal = class(TForm)
    vQueryChamado: TFDQuery;
    vQueryItChamados: TFDQuery;
    dsChamados: TDataSource;
    dsItChamados: TDataSource;
    fdConn: TFDConnection;
    FDSchemaAdapter1: TFDSchemaAdapter;
    vQueryItChamadosIDITCHAMADO: TIntegerField;
    vQueryItChamadosCODCHAMADO: TIntegerField;
    vQueryItChamadosSTATUS: TStringField;
    vQueryItChamadosTIPOCHAMADO: TStringField;
    vQueryItChamadosDATAINICIO: TSQLTimeStampField;
    vQueryItChamadosDATAFIM: TSQLTimeStampField;
    vQueryItChamadosHORAINICIO: TSQLTimeStampField;
    vQueryItChamadosHORAFIM: TSQLTimeStampField;
    vQueryChamadoIDCHAMADO: TIntegerField;
    vQueryChamadoCODCHAMADO: TIntegerField;
    vQueryChamadoNOMECLIENTE: TStringField;
    vQuery: TFDQuery;
    pDuplicar: TPopupMenu;
    btnDuplicar: TMenuItem;
    vQueryItChamadosOBS: TStringField;
    vQueryChamadoDESCRICAO: TStringField;
    dbgChamados: TDBGrid;
    dbgMestreDetalhe: TDBGrid;
    pnlTop: TPanel;
    lblDataIni: TLabel;
    lblDescricao: TLabel;
    lblObs: TLabel;
    lblHoraIni: TLabel;
    lblHoraFim: TLabel;
    edtNomeCliente: TLabeledEdit;
    edtDataInicial: TMaskEdit;
    edtChamado: TLabeledEdit;
    memoDescricao: TMemo;
    rgStatus: TRadioGroup;
    rgTipoChamado: TRadioGroup;
    memoObs: TMemo;
    edtHoraIni: TMaskEdit;
    edtHoraFim: TMaskEdit;
    edtPesquisa: TLabeledEdit;
    edtIdChamado: TLabeledEdit;
    pnlTotais: TPanel;
    edtTotalHoras: TLabeledEdit;
    fdConnOrigem: TFDConnection;
    Gauge1: TGauge;
    ImageList1: TImageList;
    btnImportar: TButton;
    btnGravar: TButton;
    btnFinalizar: TButton;
    btnLimparCampos: TButton;
    btnRestaurar: TButton;
    btnPesquisar: TButton;
    Taskbar1: TTaskbar;
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLimparCamposClick(Sender: TObject);
    procedure dbgChamadosCellClick(Column: TColumn);
    procedure dbgChamadosDblClick(Sender: TObject);
    procedure dbgMestreDetalheCellClick(Column: TColumn);
    procedure dbgMestreDetalheDblClick(Sender: TObject);
    procedure dbgMestreDetalheDrawColumnCell(Sender: TObject; const Rect: TRect;
        DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnDuplicarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure dbgChamadosTitleClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    vTotHoras : Double;
    vChamado : String;
    vEditaChamado, vEditaItChamado, vHabilitaAll, vOrdenouDesc : Boolean;
    vNomeCampoSelecionado : String;
    procedure AjustarColunas(DBGrid: TDBgrid);
    Function MinparaHora(Minuto: Double): string;
    function AutoIncremento(vNomeTabela, vNomeCampoTabela : String) : Integer;
    procedure HabilitaDesabilitaCampos;
    procedure VerificaCamposRadioGroup(var vStatus: string; var vTipo: string);
    procedure LimpaCampos;
    procedure ConsultaChamados;
    function AnsiToAscii(str: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPrincipal: TfrPrincipal;

implementation

{$R *.dfm}

procedure TfrPrincipal.FormShow(Sender: TObject);
begin

  vTotHoras := 0;

  fdConn.Connected := True;

  ConsultaChamados;

//  vQueryChamado.SQL.Add('ORDER BY C.IDCHAMADO DESC');
  vQueryChamado.Open;
  vQueryChamado.Last;

  vQueryItChamados.Close;
  vQueryItChamados.Sql.Clear;
  vQueryItChamados.SQL.Add('SELECT IT.IDITCHAMADO, IT.CODCHAMADO, IT.DATAINICIO, IT.DATAFIM, IT.STATUS, IT.HORAINICIO, IT.HORAFIM, IT.TIPOCHAMADO, IT.OBS');
  vQueryItChamados.SQL.Add('FROM ITCHAMADO IT --WHERE IT.CODCHAMADO = :CODCHAMADO');
  vQueryItChamados.SQL.Add('ORDER BY IT.IDITCHAMADO DESC');
  vQueryItChamados.Open;
  vQueryItChamados.First;

  vQueryItChamados.Open;

  edtDataInicial.Text := DateTimeToStr(Date);

  AjustarColunas(dbgMestreDetalhe);
  AjustarColunas(dbgChamados);

  vEditaChamado   := False;
  vEditaItChamado := False;
  vHabilitaAll    := True;
  HabilitaDesabilitaCampos;
  vHabilitaAll    := False;
end;

procedure TfrPrincipal.AjustarColunas(DBGrid : TDBgrid);
var
  ColumnCount, RowCount : integer;
  DataSetTemp           : TDataSet;
  DataSourceTemp        : TDataSource;
  contCol, contRow      : integer;
  AValue                : integer;
  MStrValue, AStrValue  : string;
begin
  //captura colunas do dbgrid
  ColumnCount := DBGrid.Columns.Count;
  //verifica se existem colunas
  if (ColumnCount = 0) then Exit;
  //verifica se o TDataSet do DataSource referenciado no DBGrid está ativo (haha)
  if not DBGrid.DataSource.DataSet.Active  then Exit;

  //captura em variáveis temporárias o dataset e datasource, e também a quantidade de linhas que sua query retornou no record count
  DataSetTemp    := DBGrid.DataSource.DataSet;
  DataSourceTemp := DBGrid.DataSource;
  //esta instrução foi feita para evitar que o usuário veja o processo de redimensionamento do dbgrid.
  DBGrid.DataSource := nil;
  RowCount          := DataSetTemp.RecordCount;

  //varre todas as colunas do dbgrid
  for contCol := 0 to ColumnCount-1 do
  begin
    AValue    := 0;
    AStrValue := '';

    DataSetTemp.First;
    //Seta o primeiro valor como o TÍTULO da coluna para evitar que os campos fiquem "invisíveis", quando não houver campo preenchido.
    MStrValue := DBGrid.Columns[contCol].Title.Caption;
    while not DataSetTemp.Eof do
    begin
    //captura valor e o length do campo atual
      AValue    := Length(DataSetTemp.FieldByName(DBGrid.Columns[contCol].FieldName).AsString);
      AStrValue := DataSetTemp.FieldByName(DBGrid.Columns[contCol].FieldName).AsString;
      DataSetTemp.Next;

      //verifica se a próxima variável é maior que a anterior
      //e mantém a maior.
      if length(MStrValue) < AValue then
        MStrValue := AStrValue;
    end;

    //seta a largura atual com o tamanho do campo maior capturado
    //anteriormente (Observe que há uma conversão de texto para Width,
    //isto é para capturar o valor real da largura do texto.)
    DBGrid.Columns[contCol].Width := DBGrid.Canvas.TextWidth(MStrValue)+25;
  end;

  //DataSource novamente referenciado, para evitar Acess Violation.
  DBGrid.DataSource := DataSourceTemp;
end;

function TfrPrincipal.AutoIncremento(vNomeTabela,
  vNomeCampoTabela: String): Integer;
var
  vQueryAux : TFDQuery;
begin
  vQueryAux := TFDQuery.Create(nil);
  vqueryAux.Connection := fdConn;

  vQueryAux.Close;
  vQueryAux.Sql.Clear;
  vQueryAux.Sql.Text := 'SELECT MAX(' + vNomeCampoTabela + ') AS PROXIMO FROM ' + vNomeTabela;
  vQueryAux.Open;

  if vQueryAux.FieldByName('PROXIMO').isnull then
    Result := 0
  else
    Result := vQueryAux.FieldByName('PROXIMO').AsInteger + 1;

  vQueryAux.Free;
end;

procedure TfrPrincipal.btnFinalizarClick(Sender: TObject);
var
  i, vNumeroCHamado : Integer;
  vStatus, vTipo, vHoraInicioF, vHoraFimF : String;
  vHoraIni, vHoraFim : TDateTime;
begin
  vNumeroCHamado := 0;
  if Trim(edtChamado.Text) = '' then
  begin
    Application.MessageBox('Favor informar um pedido!', 'Atenção!', MB_OK +
      MB_ICONWARNING);
    dbgMestreDetalhe.SetFocus;
    Exit;
  end;
  vQueryItChamados.Close;
  vQueryItChamados.Sql.Clear;
  vQueryItChamados.SQL.Add('SELECT C.* FROM ITCHAMADO C WHERE C.CODCHAMADO = :CODCHAMADO');
  vQueryItChamados.ParamByName('CODCHAMADO').AsInteger := StrToInt(Trim(edtChamado.Text));
  vQueryItChamados.Open;
  vQueryItChamados.First;

  vHoraInicioF := vQueryItChamadosHORAINICIO.AsString;
  vHoraFimF    := vQueryItChamadosHORAFIM.AsString;

  vHoraIni := vQueryItChamadosHORAINICIO.AsDateTime;
  vHoraFim := vQueryItChamadosHORAFIM.AsDateTime;

  vNumeroCHamado := vQueryItChamados.FieldByName('CODCHAMADO').AsInteger;
  if (Trim(edtIdChamado.Text) <> '') then
  begin
    try
      if fdConn.InTransaction then
        fdConn.Rollback;

      fdConn.StartTransaction;

      if vNumeroCHamado <> 0 then
      begin
        vQueryItChamados.Close;
        vQueryItChamados.Sql.Clear;
        vQueryItChamados.SQL.Add('UPDATE ITCHAMADO IT SET IT.DATAFIM = :DATAFIM, IT.STATUS = :STATUS');

        if Length(vHoraFimF) = 10 then
        begin
          vQueryItChamados.SQL.Add(', IT.HORAFIM = :HORAFIM');
          vQueryItChamados.ParamByName('HORAFIM').AsDateTime := Now;

          if StrToDateTime(FormatDateTime('hh:MM', vQueryItChamados.ParamByName('HORAFIM').AsDateTime)) < StrToDateTime(FormatDateTime('hh:MM', vHoraIni)) then
          begin
            Application.MessageBox('Hora Inicial maior que Hora Final',
              'Atenção!', MB_OK + MB_ICONSTOP);
            btnLimparCamposClick(nil);
            Exit;
          end;
        end;

        vQueryItChamados.SQL.Add('WHERE IT.CODCHAMADO = :CODCHAMADO AND IT.IDITCHAMADO = :IDITCHAMADO');
        vQueryItChamados.SQL.Add('AND IT.DATAINICIO < CURRENT_TIMESTAMP-(1/24)');
        vQueryItChamados.ParamByName('DATAFIM').AsDateTime    := Date;
        vQueryItChamados.ParamByName('CODCHAMADO').AsInteger  := vNumeroCHamado;
        vQueryItChamados.ParamByName('IDITCHAMADO').AsInteger := StrToInt(Trim(edtIdChamado.Text));
        vQueryItChamados.ParamByName('STATUS').AsString       := 'F';

        vQueryItChamados.ExecSQL;

        fdConn.Commit;
      end;
      vQueryItChamados.Close;

      vEditaChamado   := False;
      vEditaItChamado := True;

//      HabilitaDesabilitaCampos;
      btnLimparCamposClick(nil);

      FormShow(self);

    Except
      on E:Exception do
      begin
        ShowMessage('Erro: ' + e.Message);
        fdConn.Rollback;
      end;
    end;
  end;
end;

procedure TfrPrincipal.HabilitaDesabilitaCampos;
begin
  if vEditaChamado then
  begin
    edtDataInicial.Enabled := False;
    rgStatus.Enabled       := False;
    rgTipoChamado.Enabled  := False;
    memoDescricao.Enabled  := True;
    memoObs.Enabled        := False;
    edtHoraIni.Enabled     := False;
    edtHoraFim.Enabled     := False;
    edtPesquisa.Enabled    := False;
    edtNomeCliente.Enabled := True;
  end
  else if vEditaItChamado then
  begin
    edtDataInicial.Enabled := True;
    rgStatus.Enabled       := True;
    rgTipoChamado.Enabled  := True;
    edtHoraIni.Enabled     := True;
    edtHoraFim.Enabled     := True;
    edtPesquisa.Enabled    := True;
    memoObs.Enabled        := True;
    memoDescricao.Enabled  := False;
    edtNomeCliente.Enabled := False;
  end
  else if vHabilitaAll then
  begin
    edtDataInicial.Enabled := True;
    rgStatus.Enabled       := True;
    rgTipoChamado.Enabled  := True;
    memoObs.Enabled        := True;
    edtHoraIni.Enabled     := True;
    edtHoraFim.Enabled     := True;
    edtPesquisa.Enabled    := True;
    memoDescricao.Enabled  := True;
    edtNomeCliente.Enabled := True;
  end;
end;

procedure TfrPrincipal.VerificaCamposRadioGroup(var vStatus: string; var vTipo: string);
begin
  if rgStatus.ItemIndex = 0 then
    vStatus := 'A'
  else if rgStatus.ItemIndex = 1 then
    vStatus := 'T';
  if rgTipoChamado.ItemIndex = 0 then
    vTipo := 'SEM CLASSIFICAÇÃO'
  else if rgTipoChamado.ItemIndex = 1 then
    vTipo := 'BAIXA'
  else if rgTipoChamado.ItemIndex = 2 then
    vTipo := 'NORMAL'
  else if rgTipoChamado.ItemIndex = 3 then
    vTipo := 'ALTA'
  else if rgTipoChamado.ItemIndex = 4 then
    vTipo := 'URGENTE';
end;

procedure TfrPrincipal.LimpaCampos;
begin
  // habilita campos novamente
  vEditaChamado           := False;
  vEditaItChamado         := True;
  HabilitaDesabilitaCampos;
  vEditaItChamado         := False;
  vEditaChamado           := False;
  // ------

  edtChamado.Text         := '';
  edtNomeCliente.Text     := '';
  edtIdChamado.Text       := '';
  edtDataInicial.Text     := DateTimeToStr(Date);
  rgStatus.ItemIndex      := 0;
  rgTipoChamado.ItemIndex := 3;
  memoDescricao.Text      := '';
  memoObs.Text            := '';
  edtHoraIni.Text         := '';
  edtHoraFim.Text         := '';
  edtPesquisa.Text        := '';

  edtChamado.SetFocus;
  edtChamado.SelectAll;

  edtPesquisa.EditLabel.Caption := 'PESQUISA'
end;

procedure TfrPrincipal.ConsultaChamados;
begin
  vQueryChamado.Close;
  vQueryChamado.Sql.Clear;
  vQueryChamado.SQL.Add('SELECT C.IDCHAMADO, C.CODCHAMADO, C.NOMECLIENTE, C.DESCRICAO FROM CHAMADOS C');
end;

procedure TfrPrincipal.btnGravarClick(Sender: TObject);
var
  i, vNumeroCHamado : Integer;
  vStatus, vTipo : String;
begin
  vNumeroCHamado := 0;
  vQueryChamado.Close;
  vQueryChamado.Sql.Clear;
  vQueryChamado.SQL.Add('SELECT C.* FROM CHAMADOS C WHERE C.CODCHAMADO = :CODCHAMADO');
  vQueryChamado.ParamByName('CODCHAMADO').AsInteger := StrToInt(Trim(edtChamado.Text));
  vQueryChamado.Open;
  vQueryChamado.First;

  vNumeroCHamado := vQueryChamado.FieldByName('CODCHAMADO').AsInteger;
  try
    if fdConn.InTransaction then
      fdConn.Rollback;

    fdConn.StartTransaction;

    if (vQueryChamado.RecordCount = 0) AND (not vEditaChamado) then
    begin
      vQueryChamado.Close;
      vQueryChamado.Sql.Clear;
      vQueryChamado.SQL.Add('INSERT INTO CHAMADOS ( IDCHAMADO, CODCHAMADO, NOMECLIENTE, DESCRICAO ) VALUES ( :IDCHAMADO, :CODCHAMADO, :NOMECLIENTE, :DESCRICAO )');
      vQueryChamado.ParamByName('IDCHAMADO').AsInteger  := AutoIncremento('CHAMADOS', 'IDCHAMADO');
      vQueryChamado.ParamByName('DESCRICAO').AsString   := Trim(memoDescricao.Lines.Text);
      vQueryChamado.ParamByName('CODCHAMADO').AsInteger := StrToInt(Trim(edtChamado.Text));
      vQueryChamado.ParamByName('NOMECLIENTE').AsString := Trim(edtNomeCliente.Text);
      vQueryChamado.ExecSQL;
    end
    else if (vQueryChamado.RecordCount = 1) AND (vEditaChamado) then
    begin
      vQueryChamado.Close;
      vQueryChamado.Sql.Clear;
      vQueryChamado.SQL.Add('UPDATE CHAMADOS C SET C.NOMECLIENTE = :NOMECLIENTE, C.DESCRICAO = :DESCRICAO WHERE C.CODCHAMADO = :CODCHAMADO AND C.IDCHAMADO = ' + edtIdChamado.Text);
      vQueryChamado.ParamByName('CODCHAMADO').AsInteger := vNumeroCHamado;
      vQueryChamado.ParamByName('NOMECLIENTE').AsString := Trim(edtNomeCliente.Text);
      vQueryChamado.ParamByName('DESCRICAO').AsString   := Trim(memoDescricao.Lines.Text);
      vQueryChamado.ExecSQL;
    end;

    vQueryItChamados.Close;
    vQueryItChamados.Sql.Clear;

    if (edtDataInicial.Enabled) and (edtIdChamado.Text = '') then
    Begin

      vQueryItChamados.Sql.Text :=  {000}  'INSERT INTO ITCHAMADO ( IDITCHAMADO,' +
                                    {001}  'CODCHAMADO, ' +
                                    {002}  'DATAINICIO, ' +
                                    {003}  'STATUS, ' +
                                    {004}  'HORAINICIO, ' +
                                    {005}  'HORAFIM, ' +
                                    {006}  'TIPOCHAMADO, ' +
                                    {007}  'OBS ' +

                                    {000}  ') VALUES( :IDITCHAMADO,' +
                                    {001}  ':CODCHAMADO, ' +
                                    {002}  ':DATAINICIO, ' +
                                    {003}  ':STATUS, ' +
                                    {004}  ':HORAINICIO, ' +
                                    {005}  ':HORAFIM, ' +
                                    {006}  ':TIPOCHAMADO, ' +
                                    {007}  ':OBS ' +
                                    {008}  ') ';

      VerificaCamposRadioGroup(vStatus, vTipo);
      vQueryItChamados.ParamByName('IDITCHAMADO').AsInteger := AutoIncremento('ITCHAMADO', 'IDITCHAMADO');
      vQueryItChamados.ParamByName('CODCHAMADO').AsInteger  := StrToInt(Trim(edtChamado.Text));
      vQueryItChamados.ParamByName('DATAINICIO').AsDateTime := StrToDateTIme(edtDataInicial.Text);
      vQueryItChamados.ParamByName('STATUS').AsString       := vStatus;
      vQueryItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTIme(edtHoraIni.Text);
      vQueryItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTIme(edtHoraFim.Text);
      vQueryItChamados.ParamByName('TIPOCHAMADO').AsString  := vTipo;
      vQueryItChamados.ParamByName('OBS').AsString          := Trim(memoObs.Lines.Text);

      vQueryItChamados.ExecSQL;
    End
    else if vEditaItChamado then
    begin
      vQueryItChamados.Sql.Text :=  {000}  'UPDATE ITCHAMADO IT SET IT.CODCHAMADO = :CODCHAMADO, ' +
                                    {001}  'IT.DATAINICIO = :DATAINICIO, ' +
                                    {002}  'IT.DATAFIM = :DATAFIM, ' +
                                    {003}  'IT.STATUS = :STATUS, ' +
                                    {004}  'IT.HORAINICIO = :HORAINICIO, ' +
                                    {005}  'IT.HORAFIM = :HORAFIM, ' +
                                    {007}  'IT.TIPOCHAMADO = :TIPOCHAMADO, ' +
                                    {008}  'IT.OBS = :OBS ' +
                                    {009}  'WHERE  IT.CODCHAMADO = :CODCHAMADO  ' +
                                    {010}  'AND IT.IDITCHAMADO = :IDITCHAMADO ';

      VerificaCamposRadioGroup(vStatus, vTipo);
      vQueryItChamados.ParamByName('IDITCHAMADO').AsInteger := StrToInt(Trim(edtIdChamado.Text));
      vQueryItChamados.ParamByName('CODCHAMADO').AsInteger  := StrToInt(Trim(edtChamado.Text));
      vQueryItChamados.ParamByName('DATAINICIO').AsDateTime := StrToDateTIme(edtDataInicial.Text);
      vQueryItChamados.ParamByName('STATUS').AsString       := vStatus;
      if (StrToDateTIme(edtHoraIni.Text) > StrToDateTIme(edtHoraFim.Text)) and (edtHoraFim.Text <> '00:00') then
      begin
        Application.MessageBox('Hora Inicial maior que Hora Final',
          'Atenção!', MB_OK + MB_ICONSTOP);
        btnLimparCamposClick(nil);
        Exit;
      end;
      vQueryItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTIme(edtHoraIni.Text);
      vQueryItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTIme(edtHoraFim.Text);
      vQueryItChamados.ParamByName('TIPOCHAMADO').AsString  := vTipo;
      vQueryItChamados.ParamByName('OBS').AsString          := Trim(memoObs.Lines.Text);

      vQueryItChamados.ExecSQL;
    end;

    fdConn.Commit;
    vQueryItChamados.Close;
    vQueryChamado.Close;

    vEditaChamado := False;
    vEditaItChamado := True;

//    HabilitaDesabilitaCampos;
    btnLimparCamposClick(nil);

    FormShow(self);

  Except
    on E:Exception do
    begin
      ShowMessage('Erro: ' + e.Message);
      fdConn.Rollback;
    end;
  end;
end;

procedure TfrPrincipal.btnLimparCamposClick(Sender: TObject);
begin
  LimpaCampos;
//  FormShow(nil);
end;

procedure TfrPrincipal.dbgChamadosCellClick(Column: TColumn);
begin
  vQueryItChamados.Close;
  vQueryItChamados.Sql.Clear;
  vQueryItChamados.SQL.Add('SELECT IT.IDITCHAMADO, IT.CODCHAMADO, IT.DATAINICIO, IT.DATAFIM, IT.STATUS, IT.HORAINICIO, IT.HORAFIM, IT.TIPOCHAMADO, IT.OBS');
  vQueryItChamados.SQL.Add('FROM ITCHAMADO IT WHERE IT.CODCHAMADO = :CODCHAMADO');
  vQueryItChamados.SQL.Add('ORDER BY IT.IDITCHAMADO DESC');
  vQueryItChamados.ParamByName('CODCHAMADO').AsInteger := StrToInt(dbgChamados.Columns.Items[1].Field.Text);
  vQueryItChamados.Open;

  if dbgChamados.Columns.Items[1].Field.Text <> vChamado then
  begin
    vTotHoras := 0;
    vChamado := '';
  end;
end;

procedure TfrPrincipal.dbgChamadosDblClick(Sender: TObject);
begin
  LimpaCampos;

  vEditaChamado   := True;
  vEditaItChamado := False;

  edtIdChamado.Text   := dbgChamados.Columns.Items[0].Field.Text;
  edtChamado.Text     := dbgChamados.Columns.Items[1].Field.Text;
  edtNomeCliente.Text := dbgChamados.Columns.Items[2].Field.Text;
  memoDescricao.Text  := dbgChamados.Columns.Items[3].Field.Text;

  HabilitaDesabilitaCampos;

  if Trim(edtChamado.Text) = '' then
    edtChamado.SetFocus
  else if Trim(edtNomeCliente.Text) = '' then
    edtNomeCliente.SetFocus
  else if Trim(memoDescricao.Text) = '' then
    memoDescricao.SetFocus;
end;

procedure TfrPrincipal.dbgMestreDetalheCellClick(Column: TColumn);
var
  vAux : Double;
  i : integer;
begin

  if dbgMestreDetalhe.SelectedRows.Count = 1 then
    vTotHoras := 0;

  vQuery.Close;
  vQuery.Sql.Clear;
  vQuery.SQL.Add('SELECT DATEDIFF(MINUTE, CAST(IT.HORAINICIO AS TIME), CAST(IT.HORAFIM AS TIME) ) AS DIFERENCA');
  vQuery.SQL.Add('FROM ITCHAMADO IT WHERE IT.IDITCHAMADO = :IDCHAMADO');
  vQuery.ParamByName('IDCHAMADO').AsInteger := StrToInt(dbgMestreDetalhe.Columns.Items[0].Field.Text);
  vQuery.Open;

  if (Length(vQueryItChamadosHORAFIM.AsString) = 10) or (vQuery.FieldByName('DIFERENCA').AsFloat < 0) then
    vTotHoras := 0
  else
    vTotHoras := vTotHoras + StrToFloat(MinparaHora(vQuery.FieldByName('DIFERENCA').AsFloat));

  edtTotalHoras.Text := FormatFloat('00.00', vTotHoras).Replace(',', ':');
//  edtTotalHoras.Text := FormatMaskText('##:##;0;_', FloatToStr(vTotHoras)); // com máscara porém fica com uma vírgula
//  edtTotalHoras.Text := FloatToStr(vTotHoras).Replace(',', ':');
end;

procedure TfrPrincipal.dbgMestreDetalheDblClick(Sender: TObject);
var
  vStatus, vTipo : String;
begin
  LimpaCampos;

  vEditaChamado   := False;
  vEditaItChamado := True;

  edtIdChamado.Text   := dbgMestreDetalhe.Columns.Items[0].Field.Text;
  edtChamado.Text     := dbgMestreDetalhe.Columns.Items[1].Field.Text;
  edtDataInicial.Text := dbgMestreDetalhe.Columns.Items[2].Field.Text;

  //apenas para mostrar o cliente e descrição
  edtNomeCliente.Text := dbgChamados.Columns.Items[2].Field.Text;
  memoDescricao.Text  := dbgChamados.Columns.Items[3].Field.Text;
  // ---------------

  vStatus := dbgMestreDetalhe.Columns.Items[4].Field.Text;
  if vStatus = 'A' then
    rgStatus.ItemIndex := 0
  else if vStatus = 'T' then
    rgStatus.ItemIndex := 1;

  vTipo := Trim(dbgMestreDetalhe.Columns.Items[5].Field.Text);
  if vTipo = 'SEM CLASSIFICAÇÃO' then
  	rgTipoChamado.ItemIndex := 0
  else if vTipo = 'BAIXA' then
  	rgTipoChamado.ItemIndex := 1
  else if vTipo = 'NORMAL' then
  	rgTipoChamado.ItemIndex := 2
  else if vTipo = 'ALTA' then
  	rgTipoChamado.ItemIndex := 3
  else if vTipo = 'URGENTE' then
  	rgTipoChamado.ItemIndex := 4;

  edtHoraIni.Text := FormatDateTime('hh:mm', StrToDateTime(dbgMestreDetalhe.Columns.Items[6].Field.Text));
  if Length(vQueryItChamadosHORAFIM.AsString) = 10 then
    edtHoraFim.Text := '00:00'
  else
    edtHoraFim.Text := FormatDateTime('hh:mm', StrToDateTime(dbgMestreDetalhe.Columns.Items[7].Field.Text));
  memoObs.Text    := Trim(dbgMestreDetalhe.Columns.Items[8].Field.Text);

  HabilitaDesabilitaCampos;
end;

procedure TfrPrincipal.dbgMestreDetalheDrawColumnCell(Sender: TObject; const
    Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if dbgMestreDetalhe.Columns.Items[4].Field.Text = 'F' then
  begin
    dbgMestreDetalhe.Canvas.Font.Color  := clWhite;
    dbgMestreDetalhe.Canvas.Brush.Color := clGreen;
  end
  else if dbgMestreDetalhe.Columns.Items[4].Field.Text = 'A' then
  begin
    dbgMestreDetalhe.Canvas.Font.Color  := clBlack;
    dbgMestreDetalhe.Canvas.Brush.Color := $0000D8DD;
  end
  else if dbgMestreDetalhe.Columns.Items[4].Field.Text = 'T' then
  begin
    dbgMestreDetalhe.Canvas.Font.Color  := clWhite;
    dbgMestreDetalhe.Canvas.Brush.Color := clMaroon;
  end;

  dbgMestreDetalhe.Canvas.FillRect(Rect);
  dbgMestreDetalhe.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrPrincipal.btnDuplicarClick(Sender: TObject);
begin
  try
    if fdConn.InTransaction then
      fdConn.Rollback;

    fdConn.StartTransaction;
    vQuery.Close;
    vQuery.Sql.Clear;
    vQuery.Sql.Text :=  {000}  'INSERT INTO ITCHAMADO ( IDITCHAMADO, ' +
                        {001}  'CODCHAMADO, ' +
                        {002}  'DATAINICIO, ' +
                        {003}  'STATUS, ' +
                        {004}  'HORAINICIO, ' +
                        {005}  'HORAFIM, ' +
                        {006}  'TIPOCHAMADO, ' +
                        {007}  'OBS ' +

                        {000}  ') VALUES( :IDITCHAMADO,' +
                        {001}  ':CODCHAMADO, ' +
                        {002}  ':DATAINICIO, ' +
                        {003}  ':STATUS, ' +
                        {004}  ':HORAINICIO, ' +
                        {005}  ':HORAFIM, ' +
                        {006}  ':TIPOCHAMADO, ' +
                        {007}  ':OBS ' +
                        {008}  ') ';

    vQuery.ParamByName('IDITCHAMADO').AsInteger := AutoIncremento('ITCHAMADO', 'IDITCHAMADO');
    vQuery.ParamByName('CODCHAMADO').AsInteger  := StrToInt(dbgMestreDetalhe.Columns.Items[1].Field.Text);
    vQuery.ParamByName('DATAINICIO').AsDateTime := StrToDateTIme(dbgMestreDetalhe.Columns.Items[2].Field.Text);
//    vQuery.ParamByName('DATAFIM').AsDateTime    := dbgMestreDetalhe.Columns.Items[3].Field.Text; // não tem pois vai ser inserido depois
    vQuery.ParamByName('STATUS').AsString       := {dbgMestreDetalhe.Columns.Items[4].Field.Text}'A';
    vQuery.ParamByName('TIPOCHAMADO').AsString  := dbgMestreDetalhe.Columns.Items[5].Field.Text;
    vQuery.ParamByName('HORAINICIO').AsDateTime := StrToDateTIme(dbgMestreDetalhe.Columns.Items[6].Field.Text);
    vQuery.ParamByName('HORAFIM').AsDateTime    := StrToDateTIme(dbgMestreDetalhe.Columns.Items[7].Field.Text);
    vQuery.ParamByName('OBS').AsString          := dbgMestreDetalhe.Columns.Items[8].Field.Text;

    vQuery.ExecSQL;

    fdConn.Commit;

    vQueryItChamados.Close;
    vQueryChamado.Close;

    FormShow(self);

  Except
    on E:Exception do
    begin
      ShowMessage('Erro: ' + e.Message);
      fdConn.Rollback;
    end;
  end;

end;

procedure TfrPrincipal.btnImportarClick(Sender: TObject);
var
  QrConsulta, vQueryInserirChamado, vQueryInserirItChamados : TFDQuery;
  I : Integer;
begin
  Gauge1.Progress := 0;
  // importar dados da planilha
  QrConsulta := TFDQuery.Create(nil);
  QrConsulta.Connection := fdConnOrigem;
  QrConsulta.Close;
  QrConsulta.Sql.Clear;
  QrConsulta.Sql.Text := 'SELECT ' + sLineBreak
                      + 'DTINICIO, ' + sLineBreak
                      + 'DTFIM, ' + sLineBreak
                      + 'CHAMADOS, ' + sLineBreak
                      + 'STATUS, ' + sLineBreak
                      + 'HINICIO1, ' + sLineBreak
                      + 'PAUSA1, ' + sLineBreak
                      + 'HINICIO2, ' + sLineBreak
                      + 'PAUSA2, ' + sLineBreak
                      + 'HINICIO3, ' + sLineBreak
                      + 'PAUSA3, ' + sLineBreak
                      + 'HINICIO4, ' + sLineBreak
                      + 'PAUSA4, ' + sLineBreak
                      + 'HINICIO5, ' + sLineBreak
                      + 'PAUSA5, ' + sLineBreak
                      + 'TOTHORAS, ' + sLineBreak
                      + 'CLIENTE, ' + sLineBreak
                      + 'DESCRICAO, ' + sLineBreak
                      + 'TIPO, ' + sLineBreak
                      + 'OBS ' + sLineBreak
                      + 'FROM PLANILHA1 ' + sLineBreak
                      + 'ORDER BY DTINICIO, HINICIO1 ';
  QrConsulta.FetchOptions.Mode := fmAll;
  QrConsulta.Open;
  QrConsulta.First;

  Gauge1.MinValue := 0;
  Gauge1.MaxValue := QrConsulta.RecordCount;
  TaskBar1.ProgressMaxValue := QrConsulta.RecordCount;
  TaskBar1.ProgressState := TTaskBarProgressState.Normal;
  Gauge1.Visible  := True;

  vQueryInserirChamado := TFDQuery.Create(nil);
  vQueryInserirChamado.Connection := fdConn;
  vQueryInserirChamado.Close;

  vQueryInserirItChamados := TFDQuery.Create(nil);
  vQueryInserirItChamados.Connection := fdConn;
  vQueryInserirItChamados.Close;

  vQueryInserirChamado.Sql.Clear;
  vQueryInserirChamado.Sql.Add('DELETE FROM CHAMADOS;');
  vQueryInserirChamado.ExecSQL;

  vQueryInserirItChamados.Sql.Clear;
  vQueryInserirItChamados.Sql.Add('DELETE FROM ITCHAMADO;');
  vQueryInserirItChamados.ExecSQL;

  while not QrConsulta.Eof do
  begin
    try
      if fdConn.InTransaction then
        fdConn.Rollback;

      fdConn.StartTransaction;

      vQueryInserirChamado.Sql.Clear;
      vQueryInserirChamado.Sql.Text := {000}  'SELECT *  ' +
                                        {001}  'FROM CHAMADOS C  ' +
                                        {002}  'WHERE  C.CODCHAMADO = :CODCHAMADO ';
      vQueryInserirChamado.ParamByName('CODCHAMADO').AsInteger := QrConsulta.FieldByName('CHAMADOS').AsInteger;
      vQueryInserirChamado.Open;
      vQueryInserirChamado.First;

      if vQueryInserirChamado.RecordCount = 0 then
      begin
        vQueryInserirChamado.Sql.Clear;
        vQueryInserirChamado.SQL.Add('INSERT INTO CHAMADOS ( IDCHAMADO, CODCHAMADO, NOMECLIENTE, DESCRICAO ) VALUES ( :IDCHAMADO, :CODCHAMADO, :NOMECLIENTE, :DESCRICAO )');
        vQueryInserirChamado.ParamByName('IDCHAMADO').AsInteger  := AutoIncremento('CHAMADOS', 'IDCHAMADO');
        vQueryInserirChamado.ParamByName('DESCRICAO').AsString   := UpperCase(Trim(AnsiToAscii(QrConsulta.FieldByName('DESCRICAO').AsString)));
        vQueryInserirChamado.ParamByName('CODCHAMADO').AsInteger := QrConsulta.FieldByName('CHAMADOS').AsInteger;
        vQueryInserirChamado.ParamByName('NOMECLIENTE').AsString := UpperCase(Trim(AnsiToAscii(QrConsulta.FieldByName('CLIENTE').AsString)));
        vQueryInserirChamado.ExecSQL;
      end;

      for I := 1 to 5 do
      begin
        vQueryInserirItChamados.Sql.Clear;
        vQueryInserirItChamados.Sql.Text :=  {000}  'INSERT INTO ITCHAMADO ( IDITCHAMADO,' +
                                      {001}  'CODCHAMADO, ' +
                                      {002}  'DATAINICIO, ' +
                                      {003}  'STATUS, ' +
                                      {004}  'HORAINICIO, ' +
                                      {005}  'HORAFIM, ' +
                                      {006}  'TIPOCHAMADO, ' +
                                      {007}  'OBS ' +

                                      {000}  ') VALUES( :IDITCHAMADO,' +
                                      {001}  ':CODCHAMADO, ' +
                                      {002}  ':DATAINICIO, ' +
                                      {003}  ':STATUS, ' +
                                      {004}  ':HORAINICIO, ' +
                                      {005}  ':HORAFIM, ' +
                                      {006}  ':TIPOCHAMADO, ' +
                                      {007}  ':OBS ' +
                                      {008}  ') ';

        vQueryInserirItChamados.ParamByName('IDITCHAMADO').AsInteger := AutoIncremento('ITCHAMADO', 'IDITCHAMADO');
        vQueryInserirItChamados.ParamByName('CODCHAMADO').AsInteger  := QrConsulta.FieldByName('CHAMADOS').AsInteger;
        vQueryInserirItChamados.ParamByName('DATAINICIO').AsDateTime := QrConsulta.FieldByName('DTINICIO').AsDateTime;
        vQueryInserirItChamados.ParamByName('STATUS').AsString       := UpperCase(Trim(QrConsulta.FieldByName('STATUS').AsString));
        if i = 1 then
        begin
          vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('HINICIO1').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('HINICIO1').AsString)));
          vQueryInserirItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('PAUSA1').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('PAUSA1').AsString)));
        end
        else
        if i = 2 then
        begin
          vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('HINICIO2').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('HINICIO2').AsString)));
          vQueryInserirItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('PAUSA2').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('PAUSA2').AsString)));
        end
        else
        if i = 3 then
        begin
          vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('HINICIO3').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('HINICIO3').AsString)));
          vQueryInserirItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('PAUSA3').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('PAUSA3').AsString)));
        end
        else
        if i = 4 then
        begin
          vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('HINICIO4').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('HINICIO4').AsString)));
          vQueryInserirItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('PAUSA4').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('PAUSA4').AsString)));
        end
        else
        if i = 5 then
        begin
          vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('HINICIO5').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('HINICIO5').AsString)));
          vQueryInserirItChamados.ParamByName('HORAFIM').AsDateTime    := StrToDateTime(IfThen(Trim(QrConsulta.FieldByName('PAUSA5').AsString) = '', '30/12/1899', Trim(QrConsulta.FieldByName('PAUSA5').AsString)));
        end;

        vQueryInserirItChamados.ParamByName('TIPOCHAMADO').AsString  := UpperCase(Trim(QrConsulta.FieldByName('TIPO').AsString));
        vQueryInserirItChamados.ParamByName('OBS').AsString          := UpperCase(Trim(memoObs.Lines.Text));

        if (DateTimeToStr(vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime) = '30/12/1899 00:00:00')
          OR (DateTimeToStr(vQueryInserirItChamados.ParamByName('HORAINICIO').AsDateTime) = '30/12/1899') then
          Continue
        else
          vQueryInserirItChamados.ExecSQL;
      end;

      fdConn.Commit;
      QrConsulta.Next;

    Except
      on E:Exception do
      begin
        ShowMessage('Erro: ' + e.Message);
        fdConn.Rollback;
        TaskBar1.ProgressValue := TaskBar1.ProgressValue;
        TaskBar1.ProgressState := TTaskBarProgressState.Error;
        Break;
      end;
    end;
    Gauge1.Progress := Gauge1.Progress +1;
    TaskBar1.ProgressValue := TaskBar1.ProgressValue + 1;
    Application.ProcessMessages;
  end;
  Gauge1.Visible := False;
  TaskBar1.ProgressValue := 0;
  QrConsulta.Free;
  vQueryInserirChamado.Free;
  vQueryInserirItChamados.Free;
end;

procedure TfrPrincipal.dbgChamadosTitleClick(Column: TColumn);
var
  I : integer;
begin
  vNomeCampoSelecionado := '';

  for I := 0 to dbgChamados.Columns.Count - 1 do
    dbgChamados.Columns.Items[i].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];
  vNomeCampoSelecionado := Column.FieldName;
  ConsultaChamados;
  if (not vOrdenouDesc) then
  begin
    vQueryChamado.SQL.Add('ORDER BY C.' + vNomeCampoSelecionado + ' DESC');
    vOrdenouDesc := True;
  end
  else
  begin
    vQueryChamado.SQL.Add('ORDER BY C.' + vNomeCampoSelecionado + '');
    vOrdenouDesc := False;
  end;
  edtPesquisa.EditLabel.Caption := 'PESQUISANDO POR: '+ vNomeCampoSelecionado;
  vQueryChamado.Open;
  vQueryChamado.First;
end;

procedure TfrPrincipal.btnPesquisarClick(Sender: TObject);
begin
  ConsultaChamados;
  vQueryChamado.Sql.Add('WHERE C.' + Trim(vNomeCampoSelecionado) + ' LIKE ''%' + Trim(edtPesquisa.Text) + '%''');
  vQueryChamado.Sql.Add('ORDER BY C.' + Trim(vNomeCampoSelecionado) + ' DESC');
  vQueryChamado.Open;
  vQueryChamado.First;
end;

Function TfrPrincipal.MinparaHora(Minuto: Double): string;
var
hr : Integer;
min : Double;
vTempoFloat : String;
begin
  hr := 0;
  while minuto >= 60 do begin
    minuto := minuto - 60;
    hr := hr + 1;
  end;
  min := minuto;
//  Result := FormatFloat('00:', hr) + FormatFloat('00', min); // forma correta de calcular o tempo, porém eu vou usar como float abaixo
  vTempoFloat := FormatFloat('00:', hr) + FormatFloat('00', min);
  Result := vTempoFloat.Replace(':', ',');
end;

function TfrPrincipal.AnsiToAscii(str:String):String;
var
i: Integer;
begin
  for i := 1 to Length ( str ) do
    case str[i] of
      'á': str[i] := 'a';
      'é': str[i] := 'e';
      'í': str[i] := 'i';
      'ó': str[i] := 'o';
      'ú': str[i] := 'u';
      'à': str[i] := 'a';
      'è': str[i] := 'e';
      'ì': str[i] := 'i';
      'ò': str[i] := 'o';
      'ù': str[i] := 'u';
      'â': str[i] := 'a';
      'ê': str[i] := 'e';
      'î': str[i] := 'i';
      'ô': str[i] := 'o';
      'û': str[i] := 'u';
      'ä': str[i] := 'a';
      'ë': str[i] := 'e';
      'ï': str[i] := 'i';
      'ö': str[i] := 'o';
      'ü': str[i] := 'u';
      'ã': str[i] := 'a';
      'õ': str[i] := 'o';
      'ñ': str[i] := 'n';
      'ç': str[i] := 'c';
      'Á': str[i] := 'A';
      'É': str[i] := 'E';
      'Í': str[i] := 'I';
      'Ó': str[i] := 'O';
      'Ú': str[i] := 'U';
      'À': str[i] := 'A';
      'È': str[i] := 'E';
      'Ì': str[i] := 'I';
      'Ò': str[i] := 'O';
      'Ù': str[i] := 'U';
      'Â': str[i] := 'A';
      'Ê': str[i] := 'E';
      'Î': str[i] := 'I';
      'Ô': str[i] := 'O';
      'Û': str[i] := 'U';
      'Ä': str[i] := 'A';
      'Ë': str[i] := 'E';
      'Ï': str[i] := 'I';
      'Ö': str[i] := 'O';
      'Ü': str[i] := 'U';
      'Ã': str[i] := 'A';
      'Õ': str[i] := 'O';
      'Ñ': str[i] := 'N';
      'Ç': str[i] := 'C';
    end;
  Result := str;
end;

procedure TfrPrincipal.btnRestaurarClick(Sender: TObject);
begin
  FormShow(nil);
end;

procedure TfrPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if ActiveControl = edtPesquisa then
    begin
      if edtPesquisa.Text = '' then
      begin
        btnRestaurarClick(nil);
      end
      else
        btnPesquisarClick(nil);
    end;
  end;

end;

end.
