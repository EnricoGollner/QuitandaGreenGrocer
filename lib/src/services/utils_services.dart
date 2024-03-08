import 'package:intl/intl.dart';

class UtilServices {
  String priceToCurrency(double price) {
    final NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }
}