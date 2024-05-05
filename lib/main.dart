import 'package:flutter/material.dart';
import 'api.dart';
import 'base.dart';
import 'storage.dart';

void main() {


  runApp(const PepBandApp());

  initialize();

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selected = "FAN";
  final AssetImage pep = const AssetImage('assets/pep.png');

  _selectElement(String element){
    print("A click");
    setState(() {
      _selected = element;
    });
  }

  Widget _buildClickableEvent(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child:  Container(
          width: 400,
          height:80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Color(0x88000000), blurRadius: 8, offset: Offset.fromDirection(1,2))
            ],
          border: Border.all(color:Color(0xfffcce01), width:4),
          color: Color(0xfffffbe7),
          borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: Padding(
          padding: const EdgeInsets.all(10),
          )
          )
    );

  }

  Container _buildSelectionOption(BuildContext context, String _text, Color _bg, Color _textColor, bool selected){
    return Container(
        transform: Matrix4.skewY(-.1),
        decoration: BoxDecoration(
          color: _bg,


        ),
        child: InkWell(
            onTap: (){
              _selectElement(_text);
            },
            child: Container(

                width: double.infinity,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.transparent
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                        ),
                        Row(
                          children: [
                            AnimatedPadding(padding: EdgeInsets.only(right: (selected ? 35.0 : 30)), duration: Duration(milliseconds: 200), child: AnimatedDefaultTextStyle(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                style: TextStyle(fontSize: selected ? 60 : 40, fontWeight: selected ? FontWeight.bold : FontWeight.normal),
                                child: Text(
                                  '$_text',

                                  style: TextStyle(
                                      color: _textColor,
                                    decoration:selected ? TextDecoration.underline : TextDecoration.none

                                  ),
                                )
                            )
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: selected ? 5 : 0,
                              height:40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(0), bottomLeft: Radius.circular(4), bottomRight: Radius.circular(0)),
                                color: Colors.white
                              ),
                            )
                          ],
                        )


                      ],
                    )


                )
            )
    )

    );
  }

  Widget landing(BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[Image(

                    image: pep,
                    fit:BoxFit.contain
                )]
            )
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _buildClickableEvent(context)
              ]
            )
          )



        ],
      ),
    );
  }

  Widget registration(BuildContext context){
    return Scaffold(

        body: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 10),
                  child: Text(
                    "I'm a...",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                )]
            ),

            _buildSelectionOption(context, "FAN", const Color(0xfffcce01), const Color(0xffffffff), _selected == "FAN"),
            _buildSelectionOption(context, "PLAYER", const Color(0xff000000), const Color(0xffffffff), _selected == "PLAYER"),
            _buildSelectionOption(context, "ARM-WAVER", const Color(0xfffcce01), const Color(0xffffffff), _selected == "ARM-WAVER")
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: landing(context)
    );
  }
}
