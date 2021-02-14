import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'product.dart';

class ShowCategories extends StatefulWidget {
  @override
  _ShowCategoriesState createState() => _ShowCategoriesState();
}

final Firestore firestore = Firestore.instance;

void _delete(String categoryNamel) async {
  try {
    firestore.collection('Categories').document(categoryNamel).delete();
  } catch (e) {
    print(e);
  }
}

showAlertDialog(BuildContext context, String name) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Ok"),
    onPressed: () {
      _delete(name);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text("Would you like to Delete this Category ..."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _ShowCategoriesState extends State<ShowCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Show Categories')),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: StreamBuilder(
                stream: Firestore.instance.collection('Categories').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Text('Loading');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        shrinkWrap: true,
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document.documentID,
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Row(
                                      children: [
                                        Ink(
                                          decoration: const ShapeDecoration(
                                            color: Colors.orangeAccent,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              //  You enter here what you want the button to do once the user interacts with it
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            iconSize: 30.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Ink(
                                          decoration: const ShapeDecoration(
                                            color: Colors.orangeAccent,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              showAlertDialog(
                                                  context, document.documentID);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                            iconSize: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: Divider(
                                  color: Colors.deepOrange,
                                  height: 15,
                                  thickness: 1,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            )
          ],
        ));
  }
}
