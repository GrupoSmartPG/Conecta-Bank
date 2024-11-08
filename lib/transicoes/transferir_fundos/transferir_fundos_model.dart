import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'transferir_fundos_widget.dart' show TransferirFundosWidget;
import 'package:flutter/material.dart';

class TransferirFundosModel extends FlutterFlowModel<TransferirFundosWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();
  }
}
