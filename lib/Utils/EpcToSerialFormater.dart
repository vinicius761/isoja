String epcToSerialFormater(String epcHex) {
  // Converte o EPC de hexadecimal para inteiro
  BigInt epcInt = BigInt.parse(epcHex, radix: 16);

  // Converte para binário e garante 96 bits (preenche com zeros à esquerda)
  String epcBin = epcInt.toRadixString(2).padLeft(96, '0');

  // Pega os últimos 36 bits (serial)
  String serialBin = epcBin.substring(epcBin.length - 36);

  // Converte para decimal
  BigInt serialDecimal = BigInt.parse(serialBin, radix: 2);

  // Retorna como string
  return serialDecimal.toString();
}
