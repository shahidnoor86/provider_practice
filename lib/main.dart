import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/product_list.dart';
import 'package:provider_practice/providers/product_provider.dart';
import 'package:provider_practice/widgets/product_form.dart';

void main() => runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => Data()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ], child: const MyApp()),
    );

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
    var prodsList = context.watch<ProductProvider>().prodList;
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const MyText(),
        ),
        body: Column(
          children: [
            const Text(
              "Product List from API",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Total Products: ${prodsList.length}",
            ),
            const SizedBox(height: 20),
            const Level1(),
          ],
        ),
      ),
    );
    /* return ChangeNotifierProvider<Data>(
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
    ); */
  }
}

// Provider
class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  getProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.getProducts();
  }

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

    String providedData = context.watch<Data>().data;
    return Column(
      children: [
        const Text("Level 3"),
        const SizedBox(height: 20),
        Text("Shahid Noor -> $providedData"),
        const SizedBox(height: 20),
        const ProductList(),
        const Text("------------------ End of Product List ------------------"),
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              showAddDialog(context);
            },
            child: const Text("Add Product"))
      ],
    );
  }

  showAddDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Info"),
            content: const ProductFormPage(),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("CLOSE"))
            ],
          );
        });
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
