import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

// Provider
/*class MyApp extends StatelessWidget {
  final String data = "My Name is Shahid";

  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) => data,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text(data),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}*/

// ChangeNotifierProvider
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (_) => Data(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const MyText(),
          ),
          body: const Level1(),
        ),
      ),
    );
  }
}

// Provider
class Level1 extends StatelessWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Level2();
  }
}

// Provider
class Level2 extends StatelessWidget {
  const Level2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [MyTextField(), Level3()],
    );
  }
}

// Provider //ChangeNotifierProvider
class Level3 extends StatelessWidget {
  const Level3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider
    // String providedData = Provider.of<String>(context);

    //ChangeNotifierProvider
    String providedData = Provider.of<Data>(context).data;
    return Text("Shahid Noor -> $providedData");
  }
}

// ChangeNotifierProvider
class Data extends ChangeNotifier {
  String data = "My Name is Shahid Noor";

  void changeString(String newStr) {
    data = newStr;
    notifyListeners();
  }
}

// ChangeNotifierProvider
class MyText extends StatelessWidget {
  const MyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context).data);
  }
}

// ChangeNotifierProvider
class MyTextField extends StatelessWidget {
  const MyTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController txtController = TextEditingController();
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          controller: txtController,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blueGrey)),
            onPressed: () {
              print(txtController.text);
              // Provider.of<Data>(context).changeString(newText);

              // use read() here because this callback is outside the normal build lifecycle
              // and we don't want to subscribe to updates from the provider
              context.read<Data>().changeString(txtController.text);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}
