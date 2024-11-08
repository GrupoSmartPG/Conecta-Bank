import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'editar_transacao_widget.dart' show EditarTransacaoWidget;
import 'package:flutter/material.dart';

class EditarTransacaoModel extends FlutterFlowModel<EditarTransacaoWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;
  String? _valorTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'i2p3q1lz' /* Please enter an amount */,
      );
    }

    return null;
  }

  // State field(s) for gosta widget.
  FocusNode? gostaFocusNode;
  TextEditingController? gostaTextController;
  String? Function(BuildContext, String?)? gostaTextControllerValidator;
  // State field(s) for orsamentos widget.
  String? orsamentosValue;
  FormFieldController<String>? orsamentosValueController;
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

    gostaFocusNode?.dispose();
    gostaTextController?.dispose();

    razaoFocusNode?.dispose();
    razaoTextController?.dispose();
  }
}
