import 'package:flutter/material.dart';
import 'dart:async';
import 'DashboardMenu.dart'; 

class NewComicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'ComicNeue',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardHomePage(
        title: 'Home',
      ),
    );
  }
}

class DashboardHomePage extends StatefulWidget {
  final String title;

  DashboardHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _DashboardHomePageState createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  late List<String> _banners;
  late List<Map<String, String>> _comicData;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _banners = [
      "https://farm5.staticflickr.com/4905/46683324341_660f16ed0f_o.png",
      "https://farm5.staticflickr.com/4854/32808153198_29f403338a_o.png",
      "https://farm8.staticflickr.com/7854/39718376383_2ef44143ff_o.png",
    ];
    _comicData = [
      {
        "Name": "Cable",
        "Image": "assets/images/Cable.jpg",
      },
      {
        "Name": "X-Force",
        "Image": "assets/images/x_force.jpg",
      },
      {
        "Name": "Avengers",
        "Image": "assets/images/avengers.jpg",
      },
      {
        "Name": "Thor",
        "Image": "assets/images/thor.jpg",
      },
      {
        "Name": "X-men Wolverine",
        "Image": "assets/images/x_men_wolverine.jpg",
      },
      {
        "Name": "DC Essential Graphic Novels 2016",
        "Image": "assets/images/dc_essential_graphic_novels_2016.jpg",
      },
      {
        "Name": "Aqua Man",
        "Image": "assets/images/aqua_man.jpg",
      },
      {
        "Name": "Variant Covers",
        "Image": "assets/images/variant_covers.jpg",
      },
      {
        "Name": "Batman",
        "Image": "assets/images/batman.jpeg",
      },
    ];
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'ComicNeue',
          ),
        ),
        actions: [
          DashboardMenu(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red[600],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.pushNamed(context, '/dashboard'); 
              },
            ),
            ListTile(
              title: Text('New Komik'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.pushNamed(context, '/newcomic'); 
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: _banners.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    _banners[index],
                    fit: BoxFit.cover,
                  );
                },
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: _comicData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          _comicData[index]["Image"]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _comicData[index]["Name"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'ComicNeue',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
