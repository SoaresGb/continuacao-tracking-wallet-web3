import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';

class NewWallet extends StatefulWidget {
  const NewWallet({
    super.key,
    required this.controller,
  });

  final AppController controller;

  @override
  State<NewWallet> createState() => _NewWalletState();
}

class _NewWalletState extends State<NewWallet> {
  @override
  Widget build(BuildContext context) => Form(
        key: widget.controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (text) => widget.controller.validator(
                      text ?? '',
                    ),
                    controller: widget.controller.addressController,
                    decoration: const InputDecoration(
                      hintText: 'Digite o endereço de sua carteira',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Text('BTC?'),
                Switch.adaptive(
                  value: widget.controller.isBtc,
                  onChanged: (s) => setState(() => widget.controller.isBtc = s),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                controller: widget.controller.nameController,
                decoration: const InputDecoration(
                  hintText: 'Apelido da carteira',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.controller.addWallet(() {
                setState(() {});
              }),
              child: const Text('Registrar'),
            ),
          ],
        ),
      );
}
