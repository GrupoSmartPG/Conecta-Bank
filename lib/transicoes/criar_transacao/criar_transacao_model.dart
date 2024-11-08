import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'criar_transacao_widget.dart' show CriarTransacaoWidget;
import 'package:flutter/material.dart';

class CriarTransacaoModel extends FlutterFlowModel<CriarTransacaoWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;
  String? _valorTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'g0l6d4ny' /* Insira um valor */,
      );
    }

    return null;
  }

  // State field(s) for gasto_em widget.
  FocusNode? gastoEmFocusNode;
  TextEditingController? gastoEmTextController;
  String? Function(BuildContext, String?)? gastoEmTextControllerValidator;
  // State field(s) for orsamento widget.
  String? orsamentoValue;
  FormFieldController<String>? orsamentoValueController;
  // State field(s) for razao widget.
  FocusNode? razaoFocusNode;
  TextEditingController? razaoTextController;
  String? Function(BuildContext, String?)? razaoTextControllerValidator;

  @override
  void initState(BuildContext context) {
    valorTextControllerValidator = _valorTextControllerValidator;
  }

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();

    gastoEmFocusNode?.dispose();
    gastoEmTextController?.dispose();

    razaoFocusNode?.dispose();
    razaoTextController?.dispose();
  }
}
