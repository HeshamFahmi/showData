import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'show_product.dart';
import 'show_categories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

TextEditingController _categoryName = TextEditingController();
TextEditingController _categoryImageUrl = TextEditingController();

List<String> categoryNameList = List<String>();

class _MyHomePageState extends State<MyHomePage> {
  final Firestore firestore = Firestore.instance;

  void _createCategory(String categoryNamel, String categoryImageUrlL) async {
    try {
      await firestore.collection('Categories').document(categoryNamel).setData({
        'categoryImageUrl': categoryImageUrlL,
      });
    } catch (e) {
      print("fdfsad");
      print(e);
    }
  }

  void _read() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("Categories").getDocuments();
    categoryNameList.clear();

    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      categoryNameList.add(a.documentID);
    }
  }

  void _update() async {
    try {
      firestore.collection('users').document('testUser').updateData({
        'firstName': 'testUpdated',
      });
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('users').document('testUser').delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _read();
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor"),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome Vendor To E-Mall ...",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Category Name',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _categoryName,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Category Image',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _categoryImageUrl,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RaisedButton(
                            color: Colors.orange,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0)),
                            child: Text('Add Category'),
                            onPressed: () {
                              _createCategory(_categoryName.text.toString(),
                                  _categoryImageUrl.text.toString());
                            }),
                      ],
                    ),
                    RaisedButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text('Add Product'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRoute()),
                          );
                        }),
                    RaisedButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text('Show Categories'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowCategories()),
                          );
                        }),
                    RaisedButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text('Show Products'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowProduct()),
                          );
                        })
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
