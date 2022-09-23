SELECT DTINICIO, DTFIM, CHAMADOS, STATUS, HINICIO, PAUSA, HINICIO2, PAUSA2, HINICIO3, PAUSA3, HINICIO4, PAUSA4, HINICIO5, PAUSA5, TOTHORAS, CLIENTE, DESCRICAO, TIPO, OBS
FROM PLANILHA1

QrConsulta.FieldByName('DTINICIO').AsString
QrConsulta.FieldByName('DTFIM').AsString
QrConsulta.FieldByName('CHAMADOS').AsString
QrConsulta.FieldByName('STATUS').AsString
QrConsulta.FieldByName('HINICIO1').AsString
QrConsulta.FieldByName('PAUSA1').AsString
QrConsulta.FieldByName('HINICIO2').AsString
QrConsulta.FieldByName('PAUSA2').AsString
QrConsulta.FieldByName('HINICIO3').AsString
QrConsulta.FieldByName('PAUSA3').AsString
QrConsulta.FieldByName('HINICIO4').AsString
QrConsulta.FieldByName('PAUSA4').AsString
QrConsulta.FieldByName('HINICIO5').AsString
QrConsulta.FieldByName('PAUSA5').AsString
QrConsulta.FieldByName('TOTHORAS').AsString
QrConsulta.FieldByName('CLIENTE').AsString
QrConsulta.FieldByName('DESCRICAO').AsString
QrConsulta.FieldByName('TIPO').AsString
QrConsulta.FieldByName('OBS').AsString


QrConsulta.Free;
vQueryInserirChamado.Free;
vQueryInserirItChamados.Free;