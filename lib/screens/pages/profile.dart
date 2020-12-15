import 'package:flutter/material.dart';
import 'package:overflow/screens/shared/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      color: Colors.orange[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/squidward.jpg'),
                      radius: 50,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      currentUser.username,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(Icons.settings),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/editprofile');
                                  },
                                  alignment: Alignment.center,
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Locality',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      currentUser.country,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Joined Since',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '11th of December, 2020',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       children: [
                //         Container(
                //           // width: MediaQuery.of(context).size.width * 0.27,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                // Text(
                //   'Name',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // ),
                // SizedBox(height: 5),
                // Text(
                //   currentUser.username,
                //   style: TextStyle(
                //     fontSize: 12,
                //   ),
                //   maxLines: 1,
                // ),
                //             ],
                //           ),
                //         ),
                //         FlatButton(
                //           onPressed: () {},
                //           child: Text('Edit Profile'),
                //         )
                //         // IconButton(
                //         //   icon: Icon(Icons.settings),
                //         //   onPressed: () {
                //         //     Navigator.pushNamed(context, '/editprofile');
                //         //   },
                //         //   alignment: Alignment.center,
                //         //   iconSize: 20,
                //         // ),
                //         // RaisedButton(
                //         //   onPressed: () {
                //         //     Navigator.pushNamed(context, '/editprofile');
                //         //   },
                //         //   child: Text(
                //         //     'Edit Profile',
                //         //     style: TextStyle(),
                //         //   ),
                //         // )
                //       ],
                //     ),
                //     SizedBox(height: 20),
                //     Row(
                //       children: [
                //         Container(
                //           width: MediaQuery.of(context).size.width * 0.28,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                // Text(
                //   'Locality',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // ),
                // SizedBox(height: 5),
                // Text(
                //   currentUser.state +
                //       ", " +
                //       currentUser.country.substring(8),
                //   style: TextStyle(
                //     fontSize: 12,
                //   ),
                // ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           width: MediaQuery.of(context).size.width * 0.32,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                // Text(
                //   'Joined Since',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // ),
                // SizedBox(height: 5),
                // Text(
                //   '11th of December, 2020',
                //   style: TextStyle(
                //     fontSize: 12,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         )
                //       ],
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Bio',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
