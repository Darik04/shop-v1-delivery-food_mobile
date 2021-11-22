
String getConvertedNumber(String number){
  return number
    .replaceAll(RegExp("\\("), "")
    .replaceAll(RegExp("\\)"), "")
    .replaceAll(RegExp("-"), "")
    .replaceAll(RegExp(r"\s+\b|\b\s"), "");
}