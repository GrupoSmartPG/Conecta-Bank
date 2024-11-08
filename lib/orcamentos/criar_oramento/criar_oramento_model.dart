import '/flutter_flow/flutter_flow_util.dart';
import 'criar_oramento_widget.dart' show CriarOramentoWidget;
import 'package:flutter/material.dart';

class CriarOramentoModel extends FlutterFlowModel<CriarOramentoWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;
  String? _valorTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ubr3hfn7' /* Please enter an amount */,
      );
    }

    return null;
  }

  // State field(s) for nome_orsamento widget.
  FocusNode? nomeOrsamentoFocusNode;
  TextEditingController? nomeOrsamentoTextController;
  String? Function(BuildContext, String?)? nomeOrsamentoTextControllerValidator;
  // State field(s) for descricao widget.
  FocusNode? descricaoFocusNode;
  TextEditingController? descricaoTextController;
  String? Function(BuildContext, String?)? descricaoTextControllerValidator;

  @override
  void initState(BuildContext context) {
    valorTextControllerValidator = _valorTextControllerValidator;
  }

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();

    nomeOrsamentoFocusNode?.dispose();
    nomeOrsamentoTextController?.dispose();

    descricaoFocusNode?.dispose();
    descricaoTextController?.dispose();
  }
}
