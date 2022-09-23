object frPrincipal: TfrPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Controle Chamados'
  ClientHeight = 786
  ClientWidth = 923
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgChamados: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 272
    Width = 917
    Height = 196
    Align = alBottom
    DataSource = dsChamados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgChamadosCellClick
    OnDblClick = dbgChamadosDblClick
    OnTitleClick = dbgChamadosTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'IDCHAMADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCHAMADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMECLIENTE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Visible = True
      end>
  end
  object dbgMestreDetalhe: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 474
    Width = 917
    Height = 235
    Align = alBottom
    DataSource = dsItChamados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    PopupMenu = pDuplicar
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgMestreDetalheCellClick
    OnDrawColumnCell = dbgMestreDetalheDrawColumnCell
    OnDblClick = dbgMestreDetalheDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'IDITCHAMADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCHAMADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAINICIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFIM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOCHAMADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORAINICIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORAFIM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBS'
        Visible = True
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 923
    Height = 269
    Align = alClient
    TabOrder = 2
    DesignSize = (
      923
      269)
    object lblDataIni: TLabel
      Left = 153
      Top = 8
      Width = 51
      Height = 13
      Caption = 'Data In'#237'cio'
    end
    object lblDescricao: TLabel
      Left = 537
      Top = 9
      Width = 46
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Descri'#231#227'o'
      ExplicitLeft = 524
    end
    object lblObs: TLabel
      Left = 537
      Top = 97
      Width = 27
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Obs.:'
      ExplicitLeft = 524
    end
    object lblHoraIni: TLabel
      Left = 23
      Top = 176
      Width = 51
      Height = 13
      Caption = 'Hora In'#237'cio'
    end
    object lblHoraFim: TLabel
      Left = 127
      Top = 176
      Width = 42
      Height = 13
      Caption = 'Hora Fim'
    end
    object Gauge1: TGauge
      Left = 25
      Top = 256
      Width = 865
      Height = 11
      ForeColor = clMenuHighlight
      Progress = 0
      Visible = False
    end
    object edtNomeCliente: TLabeledEdit
      Left = 375
      Top = 24
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'Cliente'
      TabOrder = 0
    end
    object edtDataInicial: TMaskEdit
      Left = 153
      Top = 24
      Width = 85
      Height = 21
      Alignment = taCenter
      CharCase = ecUpperCase
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object edtChamado: TLabeledEdit
      Left = 248
      Top = 24
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Chamado'
      TabOrder = 2
    end
    object memoDescricao: TMemo
      Left = 537
      Top = 24
      Width = 366
      Height = 67
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object rgStatus: TRadioGroup
      Left = 23
      Top = 51
      Width = 473
      Height = 46
      Caption = 'Status'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Atendendo'
        'Teste')
      TabOrder = 4
    end
    object rgTipoChamado: TRadioGroup
      Left = 23
      Top = 103
      Width = 473
      Height = 58
      Caption = 'Status'
      Columns = 5
      ItemIndex = 3
      Items.Strings = (
        'Sem Class.'
        'Baixa'
        'Normal'
        'Alta'
        'Urgente')
      TabOrder = 5
    end
    object memoObs: TMemo
      Left = 537
      Top = 112
      Width = 366
      Height = 57
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      ScrollBars = ssVertical
      TabOrder = 6
    end
    object edtHoraIni: TMaskEdit
      Left = 23
      Top = 191
      Width = 63
      Height = 21
      Alignment = taCenter
      CharCase = ecUpperCase
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 7
      Text = '  :  '
    end
    object edtHoraFim: TMaskEdit
      Left = 127
      Top = 191
      Width = 63
      Height = 21
      Alignment = taCenter
      CharCase = ecUpperCase
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 8
      Text = '  :  '
    end
    object btnGravar: TButton
      Left = 718
      Top = 189
      Width = 103
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar/Alterar'
      TabOrder = 9
      OnClick = btnGravarClick
    end
    object btnFinalizar: TButton
      Left = 828
      Top = 189
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Finalizar'
      TabOrder = 10
      OnClick = btnFinalizarClick
    end
    object edtPesquisa: TLabeledEdit
      Left = 25
      Top = 235
      Width = 808
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 42
      EditLabel.Height = 13
      EditLabel.Caption = 'Pesquisa'
      TabOrder = 11
    end
    object btnLimparCampos: TButton
      Left = 537
      Top = 189
      Width = 107
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Limpar Campos'
      TabOrder = 12
      OnClick = btnLimparCamposClick
    end
    object edtIdChamado: TLabeledEdit
      Left = 24
      Top = 24
      Width = 86
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 58
      EditLabel.Height = 13
      EditLabel.Caption = 'Id Chamado'
      Enabled = False
      TabOrder = 13
    end
    object btnRestaurar: TButton
      Left = 361
      Top = 189
      Width = 107
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Atualizar/Restaurar'
      TabOrder = 15
      OnClick = btnRestaurarClick
    end
    object btnPesquisar: TButton
      Left = 837
      Top = 232
      Width = 66
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Pesquisar'
      TabOrder = 16
      OnClick = btnPesquisarClick
    end
    object btnImportar: TBitBtn
      Left = 208
      Top = 189
      Width = 75
      Height = 25
      Caption = 'btnImportar'
      ParentDoubleBuffered = True
      TabOrder = 14
      OnClick = btnImportarClick
    end
  end
  object pnlTotais: TPanel
    Left = 0
    Top = 712
    Width = 923
    Height = 74
    Align = alBottom
    TabOrder = 3
    object edtTotalHoras: TLabeledEdit
      Left = 23
      Top = 32
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Total Horas'
      ReadOnly = True
      TabOrder = 0
    end
  end
  object vQueryChamado: TFDQuery
    Connection = fdConn
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      
        'SELECT C.IDCHAMADO, C.CODCHAMADO, C.NOMECLIENTE, C.DESCRICAO FRO' +
        'M CHAMADOS C'
      'ORDER BY C.IDCHAMADO DESC')
    Left = 280
    Top = 344
    object vQueryChamadoIDCHAMADO: TIntegerField
      FieldName = 'IDCHAMADO'
    end
    object vQueryChamadoCODCHAMADO: TIntegerField
      FieldName = 'CODCHAMADO'
    end
    object vQueryChamadoNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
    end
    object vQueryChamadoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 255
    end
  end
  object vQueryItChamados: TFDQuery
    IndexFieldNames = 'CODCHAMADO'
    MasterSource = dsChamados
    MasterFields = 'CODCHAMADO'
    DetailFields = 'CODCHAMADO'
    Connection = fdConn
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 296
    Top = 560
    object vQueryItChamadosIDITCHAMADO: TIntegerField
      FieldName = 'IDITCHAMADO'
    end
    object vQueryItChamadosCODCHAMADO: TIntegerField
      FieldName = 'CODCHAMADO'
    end
    object vQueryItChamadosDATAINICIO: TSQLTimeStampField
      FieldName = 'DATAINICIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object vQueryItChamadosDATAFIM: TSQLTimeStampField
      FieldName = 'DATAFIM'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object vQueryItChamadosSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object vQueryItChamadosTIPOCHAMADO: TStringField
      FieldName = 'TIPOCHAMADO'
    end
    object vQueryItChamadosHORAINICIO: TSQLTimeStampField
      FieldName = 'HORAINICIO'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object vQueryItChamadosHORAFIM: TSQLTimeStampField
      FieldName = 'HORAFIM'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object vQueryItChamadosOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
  end
  object dsChamados: TDataSource
    DataSet = vQueryChamado
    Left = 192
    Top = 344
  end
  object dsItChamados: TDataSource
    DataSet = vQueryItChamados
    Left = 200
    Top = 560
  end
  object fdConn: TFDConnection
    Params.Strings = (
      
        'Database=D:\Bibliotecas\Desktop\Controle de Chamados\BD\CHAMADOS' +
        '.FDB'
      'User_Name=sysdba'
      'Password=Msol1000'
      'DriverID=IB')
    Left = 552
    Top = 288
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 624
    Top = 288
  end
  object vQuery: TFDQuery
    Connection = fdConn
    Left = 600
    Top = 544
  end
  object pDuplicar: TPopupMenu
    Left = 456
    Top = 360
    object btnDuplicar: TMenuItem
      Caption = 'Duplicar'
      OnClick = btnDuplicarClick
    end
  end
  object fdConnOrigem: TFDConnection
    Params.Strings = (
      
        'Database=D:\Bibliotecas\Desktop\Controle de Chamados\DadosAntigo' +
        's\bd.mdb'
      'DriverID=MSAcc')
    Left = 576
    Top = 368
  end
end
