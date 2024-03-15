import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class Formatters {
  static String priceToCurrency(double price) {
    final NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  static String dateToDateTime(DateTime date) {
    initializeDateFormatting('pt_BR', DateFormat.YEAR_MONTH_DAY);
    
    final DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(date);
  } 
}