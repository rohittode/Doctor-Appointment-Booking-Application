import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle value = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54);

  @override
  void initState() {
    super.initState();
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        apps = [];
      });
    });
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "kondalwadevijaya@okhdfcbank",
      receiverName: "Vijaya",
      transactionRefId: "TestingUPIIndiaPlugin",
      transactionNote: 'See you at clinic',
      amount: 2.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (apps!.isEmpty) {
      return Center(
        child: Text("No apps found to handle transaction", style: header),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () async {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(height: 8),
                      Text(app.name, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  Widget displayTransactionData(UpiResponse? transaction) {
    if (transaction == null) {
      return const Text('No transaction initiated yet');
    }

    String txnId = transaction.transactionId ?? 'N/A';
    String resCode = transaction.responseCode ?? 'N/A';
    String txnRef = transaction.transactionRefId ?? 'N/A';
    String status = transaction.status ?? 'N/A';
    String approvalRef = transaction.approvalRefNo ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Transaction Id: $txnId', style: value),
        Text('Response Code: $resCode', style: value),
        Text('Reference Id: $txnRef', style: value),
        Text('Status: $status', style: value),
        Text('Approval No: $approvalRef', style: value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Pay using UPI', style: TextStyle(fontSize: 24)),
            ),
            Expanded(
              child: displayUpiApps(),
            ),
            FutureBuilder<UpiResponse>(
              future: _transaction,
              builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return displayTransactionData(snapshot.data);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}