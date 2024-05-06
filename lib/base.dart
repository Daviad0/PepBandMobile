

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pep/boxexpand.dart';
import 'package:pep/event.dart';
import 'api.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'constants.dart';
import 'helpers.dart';

class PepBandApp extends StatelessWidget{


  const PepBandApp({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      color: primaryColor,
      home: const PepBandLanding(),
      routes: <String, WidgetBuilder>{
        "/landing": (BuildContext context) => const MainPage(),
        "/login": (BuildContext context) => const PepBandLogin(),
      },
      initialRoute: "/landing",
      theme: ThemeData(

        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: primaryColor
        ),
        // colorScheme: ColorScheme(
        //   background: Color.fromARGB(255, 255, 255, 255)
        // )
      )
    );
  }

}

class DiagBackground extends CustomPainter {
  final heightMult = 0.7;
  final heightDiffMult = 0.8;
  final Color color;


  DiagBackground(this.color);

  @override
  paint(Canvas canvas, Size size){
    Path p = new Path();
    p.lineTo(size.width, 0);
    p.lineTo(size.width, size.height * heightDiffMult * heightMult);
    p.lineTo(0, size.height * heightMult);
    p.lineTo(0, 0);

    Paint paint = Paint();
    paint.color = this.color;

    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;



}

class PepBandLogin extends StatefulWidget{
  const PepBandLogin({super.key});

  @override
  State<PepBandLogin> createState() => _PepBandLoginState();
}

class _PepBandLoginState extends State<PepBandLogin>{
  String res = "No Message";

  _mtu_cas() async{
    try{
      final result = await FlutterWebAuth.authenticate(url: "https://pep.robosmrt.com/account/authenticate?app=true", callbackUrlScheme: "pepband");
      var token = Uri.parse(result).queryParameters["token"];

      var user_data = await validateToken(token!);
      print(user_data);
    }catch(e){
      print("HI");
    }



  }

  _get_users(){
    fetchUsers().then((data) => {
      print(data)
    });
  }

  _setMessage(message){
    setState(() {
      res = message;
    });
  }

  _fetch_base(){
    fetchAPI().then((data) => {
      _setMessage(data["message"])
    });
  }

  _PepBandLoginState(){
    // fetchAPI().then((data) => {
    //   _setMessage(data["message"])
    // });
  }

  Widget _background(BuildContext context){
    return Scaffold(
      body: CustomPaint(
        painter: DiagBackground(Color.fromARGB(255, 255, 206, 0)),
        size: Size.infinite
      )
    );
  }

  Widget _bottomSection(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => {
              _mtu_cas()
            },
            child: Text(
                "Visit Application Anyway"
            ),
          )
        ],
      )
    );
  }
  
  Widget _centerOptions(BuildContext context){
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                )
              ),

              ElevatedButton(
                onPressed: () => {
                  _fetch_base()
                },
                child: Text(
                    res
                ),
              ),

              ElevatedButton(
                onPressed: () => {
                  _get_users()
                },
                child: Text(
                    "Try Fetch Users"
                ),
              )
            ],
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
        body: 
        Stack(
          children: [
            _background(context),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,


                children: [
                  _centerOptions(context),
                  _bottomSection(context)
                ]
            )

          ],
        )
        
    );
  }
}

class MainPage extends StatefulWidget{

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  bool _menuOpen = false;

  // there's a max header height
  double _validateHeaderHeight(double height){
    if(height > headerMaxHeight) return headerMaxHeight;
    if(height < 50) return 50;
    return height;
  }

  double _vaidateLogoOffset(double offset){
    if(offset < 0) return 0;
    return offset;
  }

  _setMenuOpen(bool open){
    setState(() {
      _menuOpen = open;
    });
  }


  Widget accountDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("[Username]", style: largeText, overflow: TextOverflow.fade)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("[Role]", style: mediumText, overflow: TextOverflow.fade)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text("Account"),
                    onPressed: () => {
                      _setMenuOpen(!_menuOpen)
                    }
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    child: Text("Log Out"),
                    onPressed: () => {}
                )
              ],
            )
          )

        ],
      )
    );
  }

  Widget logoImage(BuildContext context, bool shadow){

    Widget imageElement = Image(
        image: AssetImage("assets/pep.png"),
        height: getHeightFactor(context, 0.15)
    );

    if(shadow){
      imageElement = DropShadowImage(
        image: imageElement as Image,
        borderRadius: 4,
        blurRadius: 8,
        offset: Offset.zero,
      );
    }

    Widget elementToRight = Container();

    if(!shadow){
      elementToRight = ClipRect(
        clipBehavior: Clip.hardEdge,

        child: AnimatedContainer(
            duration: new Duration(milliseconds: (animationDuration/2 * 1000).round()),
            curve: Curves.easeInOut,
            width: _menuOpen ? 0 : getWidthFactor(context, 0.7),
            child: AnimatedOpacity(
              duration: new Duration(milliseconds: (animationDuration/2 * 1000).round()),
              opacity: _menuOpen ? 0 : 1,

              child: accountDetails(context),
            )
        )
      );

    }

    return AnimatedPadding(
        duration: new Duration(milliseconds: (animationDuration/2 * 1000).round()),
        padding: !_menuOpen ? EdgeInsets.only(top: 50) : EdgeInsets.only(top: _vaidateLogoOffset(_validateHeaderHeight(getHeightFactor(context, 0.2)) - (getHeightFactor(context, 0.2)/2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: shadow ? [
            ] : [
              imageElement,
              elementToRight
              ]
        )
    );
  }



  Widget header(BuildContext context){

    double closedHeight = _validateHeaderHeight(getHeightFactor(context, 0.2));
    double openHeight = getHeightFactor(context, 0.8);

    print(closedHeight);
    print(openHeight);

    return SafeArea(
      top: true,
      bottom: true,
      child: Stack(
        children: [

          logoImage(context, true),
          AnimatedContainer(
            decoration: headerStyle,
            height: _menuOpen ? closedHeight : openHeight,
            duration: new Duration(milliseconds: (animationDuration * 1000).round()),
            curve: Curves.easeInOut




          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              logoImage(context, false)
            ]
          )




        ],
      )

    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      top: false,
      bottom: false,
      child: FractionallySizedBox(
        heightFactor: 1.0,
        widthFactor: 1.0,
        child: Container(
            color: Colors.white,
            child:
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Column(
                  children: [
                    ElevatedButton(
                      child: Text("Change Open"),
                      onPressed: () => {
                        _setMenuOpen(!_menuOpen)
                      },
                    ),
                    Text(
                        _menuOpen.toString()
                    )
                  ]
              )
            )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          content(context),
          header(context)

        ]
      )
    );
  }
}


class PepBandLanding extends StatefulWidget{

  const PepBandLanding({super.key});

  @override
  State<PepBandLanding> createState() => _PepBandLandingState();
}

class _PepBandLandingState extends State<PepBandLanding>{



  List<dynamic> events = <dynamic>[];

  _getEvents() async{
    List<dynamic> gottenEvents;
    Map<String, dynamic> result = await fetchEvents();
    if(result["events"] != null){
      gottenEvents = result["events"];

      setState(() {
        events = gottenEvents;
      });
    }
  }

  _PepBandLandingState(){
    _getEvents();
  }
  

  Widget _eventList(BuildContext){
    List<EventView> views = <EventView>[];

    for(dynamic e in events){
      Map<String, dynamic> event = e as Map<String, dynamic>;

      EventView ev = new EventView(event: event);
      
      views.add(ev);
    }
    
    return Column(
      children: views
    );

  }




  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: _eventList(BuildContext)
    );
  }

}