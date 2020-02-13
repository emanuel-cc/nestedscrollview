import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

const _kTabs = ["Tab 1", "Tab 2"];

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  ScrollController scrollController;
   bool lastStatus = true;

  scrollListener(){
    if(isShrink != lastStatus){
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink{
    return scrollController.hasClients && scrollController.offset > (200.0 - kToolbarHeight);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final Widget tabBar = TabBar(
        tabs: _kTabs.map<Widget>((String name) => Tab(text: name)).toList());

    return Scaffold(
      body: DefaultTabController(
        length: _kTabs.length,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                primary: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.symmetric(horizontal: 70.0),
                  collapseMode: CollapseMode.parallax,
                  title: Text('Texto de Referencia'),
                  background: Container(
                    width: double.infinity,
                    height: 240.0,
                    color: Colors.blue,
                  ),
                ),
                expandedHeight: 350.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: !isShrink ? Colors.black:Colors.white,
                    ),
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: (){
                      
                    },
                  )
                ],
              ),
              SliverAppBar(
                title: Text("Title"),
                bottom: tabBar,
                pinned: false,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: TabBarView(
            children: _kTabs.map((String name) {
              return Container(
                key: PageStorageKey(name),
                child: MyListView(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> with AutomaticKeepAliveClientMixin {
  @override
  final bool wantKeepAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );
  }
}