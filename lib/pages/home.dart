import 'package:flutter/material.dart';
import 'package:time_tracker/pages/stopwatch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(context),
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 226, 246, 253),
      body: SingleChildScrollView(
        child: (Column(
          children: [
            //-------------------------------------------------------------------------------------

            //First Text Row
            Container(
              margin: EdgeInsets.only(
                top: 70,
                left: 120,
                right: 120,
                bottom: 5,
              ),
              height: 25,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //-------------------------------------------------------------------------------------

            //FIRST CONTAINER
            TimeWidget(), // First child ends
            //-------------------------------------------------------------------------------------

            //SECOND CONTAINER
            TimeWidget(),

            //-------------------------------------------------------------------------------------

            //THIRD CHILD
            TimeWidget(),

            //--------------------------------------------------------------------------------------
            //FOURTH CHILD
            TimeWidget(),

            //--------------------------------------------------------------------------------------
            //FIFTH CHILD
            TimeWidget(),
          ],
        )),
      ),
    );
  }

  //------------------------------------------------------------------

  BottomAppBar bottomBar(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(255, 255, 255, 255),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => stopwatchPage()));
            },

            //padding: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Color.fromARGB(255, 27, 87, 110),
              child: Icon(Icons.add, size: 40, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //-----------------------------------------------------------------------------------------

  AppBar appBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      centerTitle: true,
      elevation: 0,
      leading: Icon(Icons.home),
      actions: [
        Icon(Icons.notification_add),
        SizedBox(width: 20),
        Icon(Icons.person),
        SizedBox(width: 20),
        Icon(Icons.settings),
        SizedBox(width: 20),
      ],
      title: Text(
        'TIME TRACKER APP',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          wordSpacing: 8,
        ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 16,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 27, 87, 110),
                    radius: 25,
                    child: Icon(Icons.computer, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Flutter UI Design',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  left: 60,
                  right: 20,
                  bottom: 10,
                  top: 1,
                ),
                child: Row(
                  children: [
                    //SizedBox(width: 100),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 95, 159, 184),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: (Text(
                        'Work',
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 88, 108),
                        ),
                      )),

                      //width: 70,
                    ),
                    SizedBox(width: 5),

                    Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      //width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 95, 159, 184),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: (Text(
                        'Flutter Project',
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 88, 108),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Time: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(text: '00:00:00', style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Icon(Icons.play_arrow_rounded, size: 50),
            ],
          ),
        ],
      ),
    );
  }
}
