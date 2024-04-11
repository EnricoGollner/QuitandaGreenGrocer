import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/core/utils/utils_services.dart';
import 'package:quitanda_app/src/models/order_model.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  const PaymentDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pagamento com Pix',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                //QR CODE
                Image.memory(
                  UtilsServices.generateQRCode(order.qrCodeImage),
                  height: 200,
                  width: 200,
                ),
                // QrImageView(
                //   data: 'asd12345667788545422',
                //   version: QrVersions.auto,
                //   size: 200.0,
                // ),

                //Vencimento
                Text(
                  'Vencimento: ${Formatters.formatDatetime(order.overdueDateTime)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Total: ${Formatters.priceToCurrency(order.total)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 2,
                      color: CustomColors.customSwatchColor,
                    ),
                  ),
                  onPressed: () {
                    FlutterClipboard.copy(order.copyAndPaste);
                    UtilsServices.showFlutterToast(message: 'Código copiado');
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    'Copy Code',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
