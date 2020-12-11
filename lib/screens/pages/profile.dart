import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/squidward.jpg'),
                radius: 50,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            child: Text(
                              'Louis Davin Lie ',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/editprofile');
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Locality',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Jakarta, Indonesia',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Joined Since',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '11th of December, 2020',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
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
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
          Divider(
            height: 20,
            color: Colors.black,
            thickness: 0.4,
          ),
        ],
      ),
    );
  }
}
