import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/wallets_page.dart';

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
  final TextEditingController walletAddressController = TextEditingController();
  final TextEditingController walletNicknameController =
      TextEditingController();

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    vertical: MediaQuery.of(context).size.height * 0.12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        validator: (text) =>
                            AppController.instance.validator(text ?? ''),
                        controller: walletAddressController,
                        decoration: const InputDecoration(
                          hintText: 'Digite o endereço de sua carteira',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          controller: walletNicknameController,
                          decoration: const InputDecoration(
                            hintText: 'Apelido da carteira',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppController.instance
                                  .registerWallet(
                                      walletAddressController.text,
                                      walletNicknameController.text.isEmpty
                                          ? AppController.instance
                                              .formattingAddress(
                                                  walletAddressController.text)
                                          : walletNicknameController.text)
                                  .then((value) =>
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const WalletPage(),
                                        ),
                                      ));
                            }
                          },
                          child: const Text('Registrar')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
