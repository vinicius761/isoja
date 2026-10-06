import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final maskCpf = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

final maskRg = MaskTextInputFormatter(
  mask: '##.###.###-A',
  filter: {"#": RegExp(r'[0-9]'), "A": RegExp(r'[0-9xX]')},
  type: MaskAutoCompletionType.lazy,
);

final maskCnh = MaskTextInputFormatter(
  mask: '###########',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

final maskCep = MaskTextInputFormatter(
  mask: '#####-###',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

final maskTelefone = MaskTextInputFormatter(
  mask: '#####-####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
