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
            Container(
              margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
              height: 150,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
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
                              TextSpan(
                                text: '00:00:00',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(Icons.play_arrow_rounded, size: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ), // First child ends
            //-------------------------------------------------------------------------------------

            //SECOND CONTAINER
            Container(
              margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
              height: 150,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              child: Icon(Icons.code, color: Colors.white),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Learning Dart',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
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
                                  'Asynchronous programming',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 38, 88, 108),
                                  ),
                                )),
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
                                  'Iterable collections',
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
                              TextSpan(
                                text: '00:00:00',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(Icons.play_arrow_rounded, size: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ), // Second child ends
            //-------------------------------------------------------------------------------------

            //THIRD CHILD
            Container(
              margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
              height: 150,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              child: Icon(
                                Icons.sports_soccer,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Footy Practice',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
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
                                  'Drills and stretching',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 38, 88, 108),
                                  ),
                                )),
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
                                  'Matches',
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
                              TextSpan(
                                text: '00:00:00',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(Icons.play_arrow_rounded, size: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ), //Third child ends
            //--------------------------------------------------------------------------------------
            //FOURTH CHILD
            Container(
              margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
              height: 150,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              child: Icon(
                                Icons.meeting_room,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'DS Meeting',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
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
                                  'Engagement report modify',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 38, 88, 108),
                                  ),
                                )),
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
                                  'Share updates',
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
                              TextSpan(
                                text: '00:00:00',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(Icons.play_arrow_rounded, size: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ), // Fourth child ends
            //--------------------------------------------------------------------------------------
            //FIFTH CHILD
            Container(
              margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
              height: 150,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              child: Icon(Icons.games, color: Colors.white),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Gaming',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
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
                                  'Valorant',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 38, 88, 108),
                                  ),
                                )),
                              ),
                              SizedBox(width: 5),
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
                              TextSpan(
                                text: '00:00:00',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(Icons.play_arrow_rounded, size: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ), // FIfth child ends
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
