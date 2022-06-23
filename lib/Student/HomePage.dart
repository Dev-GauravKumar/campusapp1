import 'package:campusapp/Student/studentEvent.dart';
import 'package:campusapp/Student/studentNotice.dart';
import 'package:campusapp/Student/studentScholarship.dart';
import 'package:campusapp/Study/studyHome.dart';
import 'package:campusapp/menu.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller=ScrollController();
  int _selectedIndex=0;
  bool get _isAppBarExpanded {
    return _controller.hasClients &&
        _controller.offset > (120 - kToolbarHeight);
  }
  void initState(){
    super.initState();
    _controller.addListener(() {setState((){});});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        extendBody: true,
        drawer: Container(
            width: 250,
            child: const menu()),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          controller: _controller,
            headerSliverBuilder:(context,innerBoxIsSCrolled)=> [
              SliverAppBar(
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: _isAppBarExpanded?AppBar(
                  leadingWidth: 100,
                  leading: Builder(
                      builder: (context) {
                        return Container(
                            color: Color.fromRGBO( 	112,229,177,1),
                            child: Padding(
                              padding: const EdgeInsets.only(top:8,left:25,right: 25,bottom: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(onPressed:  ()=>Scaffold.of(context).openDrawer(), icon: const Icon(Icons.sort,size: 25,color: Colors.black,))),
                            ),);
                      }
                  ),
                  backgroundColor: Color.fromRGBO( 	112,229,177,1),
                  title: RichText(text: const TextSpan(text: 'My   ___',style:TextStyle(color: Colors.black,fontSize: 25),
                  children:[
                    TextSpan(text: '\nCAM',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                    TextSpan(text: 'PU',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                    TextSpan(text: 'S',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                  ],
                ),

                ),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black,size: 25,),),
                ],
                ):SizedBox(),
                ),
                pinned: true,
                expandedHeight: 120,
            flexibleSpace: Stack(
              children:[ Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 150,
                  width: 110,
                  color: Color.fromRGBO( 	112,229,177,1),),
              ),
              ],
            ),
            leadingWidth: 100,
            leading: Builder(
                builder: (context) {
                  return Container(
                      color: Color.fromRGBO( 	112,229,177,1),
                      child:Padding(
                      padding: const EdgeInsets.only(top:8,left: 25,right: 25,bottom: 8),
                  child: Container(
                  decoration: BoxDecoration(
                  border: Border.all(
                  color: Colors.black,
                  width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(onPressed:  ()=>Scaffold.of(context).openDrawer(), icon: const Icon(Icons.sort,size: 25,color: Colors.black,))),
                  ),
                  );
                }
            ),
            backgroundColor: Colors.white,
            forceElevated: innerBoxIsSCrolled,
            title: RichText(text: const TextSpan(text: 'My   ___',style:TextStyle(color: Colors.black,fontSize: 25),
              children:[
                TextSpan(text: '\nCAM',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                TextSpan(text: 'PU',style: TextStyle(color: Color.fromRGBO( 	112,229,177,1),fontSize: 25,fontWeight: FontWeight.bold)),
                TextSpan(text: 'S',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
              ],
            ),

            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.black,
                  )),
            ],
          ),],
        body: pages[_selectedIndex],
        ),
        bottomNavigationBar: bottomBar(context),
      ),
    );
  }
  final pages=const [home(),studentEvent(),studentScholarship(),studyHome()];
  Widget bottomBar(context){
    return CurvedNavigationBar(
      height: 50,
      items: [Icon(Icons.home,color: _selectedIndex==0?Colors.black:Colors.white,),
        Icon(Icons.event,color: _selectedIndex==1?Colors.black:Colors.white,),
        Icon(Icons.school,color: _selectedIndex==2?Colors.black:Colors.white,),
        Icon(Icons.book_sharp,color: _selectedIndex==3?Colors.black:Colors.white,),
      ],
      buttonBackgroundColor: Color.fromRGBO( 	112,229,177,1),
      backgroundColor: Colors.transparent,
      color: Colors.black,
      index: _selectedIndex,
      onTap: (index) => setState(() {
        _selectedIndex = index;
      }),
    );
  }
}
class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      Text('News',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: studentNotice(),
      ),
    ],);
  }
}
