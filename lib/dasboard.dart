import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class DashboardPage extends StatelessWidget {
  final FirebaseApp app;
  const DashboardPage({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        key: UniqueKey(),
        title: 'Comic Reader',
        app: app,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;
  final String title;

  const MyHomePage({Key? key, required this.app, required this.title})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseReference _bannerRef;
  late List<String> _banners;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase _database = FirebaseDatabase(app: widget.app);
    _bannerRef = _database.reference().child('Banner');
    _banners = [];
    _pageController = PageController();
    _loadBanners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadBanners() {
    _bannerRef.once().then((DatabaseEvent snapshot) {
      setState(() {
        _banners = List<String>.from(snapshot.snapshot.value as List<dynamic>);
      });
      _startAutoPlay();
    });
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage < _banners.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1BC0C5),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _banners.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        _banners[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    _banners.length,
                    (int index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _currentPage == index ? 10.0 : 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
