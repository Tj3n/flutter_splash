import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_splash/common/constants.dart';
import 'package:flutter_splash/splash/index.dart';
import 'package:intl/intl.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key key,
    @required SplashBloc splashBloc,
  })  : _splashBloc = splashBloc,
        super(key: key);

  final SplashBloc _splashBloc;

  @override
  SplashScreenState createState() {
    return new SplashScreenState(_splashBloc);
  }
}

class SplashScreenState extends State<SplashScreen> {
  final SplashBloc _splashBloc;
  SplashScreenState(this._splashBloc);

  @override
  void initState() {
    super.initState();
    this._splashBloc.dispatch(LoadSplashEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashEvent, SplashState>(
        bloc: widget._splashBloc,
        builder: (
          BuildContext context,
          SplashState currentState,
        ) {
          if (currentState is UnSplashState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorSplashState) {
            return new Container(
                child: new Center(
              child: new Text(currentState.errorMessage ?? 'Error'),
            ));
          }

          if (currentState is InSplashState) {
            final MovieListModel movieListModel = currentState.movieListModel;
            return new Material(
              color: appColors[0],
              child: SafeArea(
                child: createBody(movieListModel),
              ),
            );
          }
        });
  }

  List<Widget> createSliderItems(MovieListModel movieList) {
    return movieList.movies.map((i) {
      return Builder(
        builder: (BuildContext context) {
          var borderRadius2 = BorderRadius.circular(20);
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: borderRadius2,
                child: 
                // Text("asdf"),
                // Image.asset('assets/akali.jpg');
                Image.network('https://image.tmdb.org/t/p/w185${i.posterPath}', fit: BoxFit.fitHeight,),
              ));
        },
      );
    }).toList();
  }

  CarouselSlider createSlider(MovieListModel movieList) {
    return CarouselSlider(
      height: MediaQuery.of(context).size.height / 2,
      items: createSliderItems(movieList),
      aspectRatio: 1,
      enlargeCenterPage: true,
      onPageChanged: (page) {
        // setState(() {
        // _current = page;
        // });
      },
    );
  }

  Widget createBody(MovieListModel movieList) {
    if (movieList == null) {
      return Text('asdf');
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: FlatButton(
            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: Text(
              'Skip',
              style: defaultTextStyle,
            ),
          ),
        ),
        Spacer(),
        createSlider(movieList),
        Spacer(), //Slider
        new StackedTittle(
          currentPage: 1,
          title: 'Test',
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
                // _slider.previousPage(
                //     duration: Duration(milliseconds: 300),
                //     curve: Curves.easeInOut);
              },
            ),
            // new Indicator(items: _itemsWidget, current: _current),
            FlatButton(
              child: Text('Next', style: defaultTextStyle),
              onPressed: () {
                // _slider.nextPage(
                //     duration: Duration(milliseconds: 300),
                //     curve: Curves.easeInOut);
              },
            )
          ],
        )
      ],
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
