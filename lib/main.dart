import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/wallets_page.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/widgets/new_wallet_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foxbit Tracking Web3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: 'Foxbit Tracking Web3',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        AppController.instance.getLocalWallets().then((value) {
          if (value.isNotEmpty) {
            Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
              builder: (BuildContext context) => const WalletPage(),
            ));
          }
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).primaryColor),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: 100,
                    width: 200,
                    child: Image.asset(
                      "assets/foxbittracking.png",
                      fit: BoxFit.fitWidth,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.12,
                  ),
                  child: NewWallet(
                    controller: AppController.instance,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
