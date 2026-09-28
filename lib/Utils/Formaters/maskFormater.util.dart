import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final cpfFormatterUtil = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter maskCelular() {
  return MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
}

MaskTextInputFormatter maskTelefoneFixo() {
  return MaskTextInputFormatter(
    mask: '(##) ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
