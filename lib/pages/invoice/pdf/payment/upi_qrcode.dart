import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pc1/pages/invoice/pdf/payment/upi.dart';

/// Generates the UP IPayment QRCode
class UPIPaymentQRCode extends StatefulWidget {
  const UPIPaymentQRCode({
    Key? key,
    required this.upiDetails,
    this.size,
    this.loader,
    this.noBarcodeWidget,
  }) : super(key: key);

  final UPIDetails upiDetails;
  final double? size;
  final Widget? loader;
  final Widget? noBarcodeWidget;

  @override
  _UPIPaymentQRCodeState createState() => _UPIPaymentQRCodeState();
}

class _UPIPaymentQRCodeState extends State<UPIPaymentQRCode> {
  bool isLoading = true;
  String? barcodeData;

  @override
  void initState() {
    _loadBarcode();
    super.initState();
  }

  Future _loadBarcode() async {
    isLoading = true;
    setState(() {});
    barcodeData =
        _getBarcodeData(Barcode.qrCode(), widget.upiDetails.qrCodeValue);
    isLoading = false;
    setState(() {});
  }

  String _getBarcodeData(
    Barcode bc,
    String data,
  ) {
    return bc.toSvg(
      data,
      width: widget.size ?? MediaQuery.of(context).size.width * 0.7,
      height: widget.size ?? MediaQuery.of(context).size.width * 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: isLoading
          ? Center(
              child: widget.loader ?? const CircularProgressIndicator(),
            )
          : barcodeData == null
              ? widget.noBarcodeWidget ??
                  const Text("No Data Found for Barcode")
              : SvgPicture.string('''$barcodeData'''),
    );
  }
}
