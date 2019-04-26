import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import "package:intl/intl.dart";
import 'network.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return new MaterialApp(
        title: 'sth',
        theme: ThemeData(primaryColor: Colors.white),
        home: MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

TextStyle defaultTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16);

List<Color> appColors = [
  Color(0xFF102426),
  Color(0xFF470024),
  Color(0xFF5B1865),
  Color(0xFF2C5784),
  Color(0xFF5688C7)
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Widget> _itemsWidget = [];
  List<LoremObject> _items = [];
  CarouselSlider _slider;
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> createSliderItems(BuildContext context, AsyncSnapshot snapshot) {
    print(snapshot.data);
    _items = snapshot.data;
    _itemsWidget = _items.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              // decoration: BoxDecoration(
              //     color: Colors.amber,
              //     borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                    // Text(i.author),
                    // Image.asset('assets/akali.jpg');
                    // Image.network(i.downloadUrl, fit: BoxFit.fitHeight,),
                    CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  placeholder: (BuildContext context, String str) {
                    return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  },
                  imageUrl: i.downloadUrl,
                ),
              ));
        },
      );
    }).toList();

    return _itemsWidget;
  }

  CarouselSlider createSlider(BuildContext context, AsyncSnapshot snapshot) {
    _slider = CarouselSlider(
      height: MediaQuery.of(context).size.height / 2,
      items: createSliderItems(context, snapshot),
      aspectRatio: 1,
      enlargeCenterPage: true,
      onPageChanged: (page) {
        setState(() {
          _current = page;
        });
      },
    );
    return _slider;
  }

  Widget createBody(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: _incrementCounter,
            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: Text(
              'Skip',
              style: defaultTextStyle,
            ),
          ),
        ),
        Spacer(),
        createSlider(context, snapshot),
        Spacer(), //Slider
        new StackedTittle(
          currentPage: _current,
          title: _items[_current].author ?? '',
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
          child: AutoSizeText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit,' +
                'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
        ),
        Spacer(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Prev', style: defaultTextStyle),
              onPressed: () {
                _slider.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            ),
            new Indicator(items: _itemsWidget, current: _current),
            FlatButton(
              child: Text('Next', style: defaultTextStyle),
              onPressed: () {
                _slider.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            )
          ],
        )
      ],
    );
  }

  void _incrementCounter() {
    setState(() {
      _slider.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          color: appColors[_current % 5],
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: SafeArea(
              child: FutureBuilder(
            future: Networking().getJSONData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return createBody(context, snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ))),
    );
  }
}

class StackedTittle extends StatelessWidget {
  const StackedTittle({
    Key key,
    @required int currentPage,
    @required String title,
  })  : _currentPage = currentPage,
        _title = title,
        super(key: key);

  final int _currentPage;
  final String _title;

  @override
  Widget build(BuildContext context) {
    NumberFormat format = NumberFormat('##');
    format.minimumIntegerDigits = 2;

    String _currentPageString = format.format(_currentPage + 1);
    return Padding(
        padding: EdgeInsets.fromLTRB(36, 36, 36, 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Text(
                _title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                maxLines: 2,
              ),
              Positioned(
                top: -26,
                left: -16,
                child: Text(
                  _currentPageString,
                  style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ],
          ),
        ));
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key key,
    @required List<Widget> items,
    @required int current,
  })  : _items = items,
        _current = current,
        super(key: key);

  final List<Widget> _items;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _items
            .asMap()
            .keys
            .map((index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: _current == index ? 16.0 : 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: _current == index ? Colors.white : Colors.white30),
                ))
            .toList());
  }
}
