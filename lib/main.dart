import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

final localStorage = GetStorage();

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => dataProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: ScrollPage(),
      ),
    );
  }
}

class ScrollPage extends StatefulWidget {
  const ScrollPage({super.key});

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  
  @override
  void initState() {
   
        Provider.of<dataProvider>(context, listen: false).getDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = localStorage.read("fetachDetails");
    var fetachdata =Provider.of<dataProvider>(context);
    return Scaffold(
        body: (localStorage.read("fetachDetails") != null)
            ? RefreshIndicator(
              onRefresh:()=> fetachdata.getDetails(),
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['name']),
                    );
                  }),
            )
            : Container());
  }
}
