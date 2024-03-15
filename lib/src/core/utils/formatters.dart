import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Formatters {
  static String priceToCurrency(double price) {
    final NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  static String dateToDateTime(DateTime date) {
    initializeDateFormatting();
    
    final DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(date);
  } 
}