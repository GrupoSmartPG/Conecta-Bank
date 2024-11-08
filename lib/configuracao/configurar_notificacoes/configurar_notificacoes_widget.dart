import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'configurar_notificacoes_model.dart';
export 'configurar_notificacoes_model.dart';

class ConfigurarNotificacoesWidget extends StatefulWidget {
  const ConfigurarNotificacoesWidget({super.key});

  @override
  State<ConfigurarNotificacoesWidget> createState() =>
      _ConfigurarNotificacoesWidgetState();
}

class _ConfigurarNotificacoesWidgetState
    extends State<ConfigurarNotificacoesWidget> {
  late ConfigurarNotificacoesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfigurarNotificacoesModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryText,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pop();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            size: 32.0,
          ),
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'sc4ff4ce' /* Notificações */,
          ),
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Lexend',
                color: FlutterFlowTheme.of(context).secondaryBackground,
                fontSize: 25.0,
                letterSpacing: 0.0,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: Image.asset(
              'assets/images/login_bg@2x.png',
            ).image,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'r72zvrv5' /* Escolha abaixo quais notificaç... */,
                ),
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Lexend',
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Material(
                color: Colors.transparent,
                child: SwitchListTile.adaptive(
                  value: _model.switchListTileValue1 ??= true,
                  onChanged: (newValue) async {
                    safeSetState(() => _model.switchListTileValue1 = newValue);
                  },
                  title: Text(
                    FFLocalizations.of(context).getText(
                      'gjygkr0n' /* Notificações Push */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Lexend',
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  subtitle: Text(
                    FFLocalizations.of(context).getText(
                      '3y3yhxbk' /* Receba notificações push de no... */,
                    ),
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  tileColor: FlutterFlowTheme.of(context).primaryText,
                  activeColor: FlutterFlowTheme.of(context).primaryText,
                  activeTrackColor: FlutterFlowTheme.of(context).primary,
                  dense: false,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: SwitchListTile.adaptive(
                value: _model.switchListTileValue2 ??= true,
                onChanged: (newValue) async {
                  safeSetState(() => _model.switchListTileValue2 = newValue);
                },
                title: Text(
                  FFLocalizations.of(context).getText(
                    '1ytebj35' /* Notificações por E-mail */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                ),
                subtitle: Text(
                  FFLocalizations.of(context).getText(
                    '9lvh5nst' /* Receba notificações por e-mail... */,
                  ),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Lexend',
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).primaryText,
                activeColor: FlutterFlowTheme.of(context).primaryText,
                activeTrackColor: FlutterFlowTheme.of(context).primary,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: SwitchListTile.adaptive(
                value: _model.switchListTileValue3 ??= true,
                onChanged: (newValue) async {
                  safeSetState(() => _model.switchListTileValue3 = newValue);
                },
                title: Text(
                  FFLocalizations.of(context).getText(
                    '69d2j74u' /* Serviços de localização */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                ),
                subtitle: Text(
                  FFLocalizations.of(context).getText(
                    '3k8cuv0d' /* Permita-nos rastrear sua local... */,
                  ),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Lexend',
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).primaryText,
                activeColor: FlutterFlowTheme.of(context).primaryText,
                activeTrackColor: FlutterFlowTheme.of(context).primary,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  context.pop();
                },
                text: FFLocalizations.of(context).getText(
                  'isgrgbfs' /* Salvar Alterações */,
                ),
                options: FFButtonOptions(
                  width: 190.0,
                  height: 50.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).textColor,
                        letterSpacing: 0.0,
                      ),
                  elevation: 3.0,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
