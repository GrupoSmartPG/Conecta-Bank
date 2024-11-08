import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'solicitar_fundos_widget.dart' show SolicitarFundosWidget;
import 'package:flutter/material.dart';

class SolicitarFundosModel extends FlutterFlowModel<SolicitarFundosWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for razao widget.
  FocusNode? razaoFocusNode;
  TextEditingController? razaoTextController;
  String? Function(BuildContext, String?)? razaoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();

    razaoFocusNode?.dispose();
    razaoTextController?.dispose();
  }
}
