import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

TextEditingController _productName = TextEditingController();
TextEditingController _productModel = TextEditingController();
TextEditingController _productImageUrl = TextEditingController();
TextEditingController _productPrice = TextEditingController();
TextEditingController _productPriceDiscount = TextEditingController();
TextEditingController _productStars = TextEditingController();

class _SecondRouteState extends State<SecondRoute> {
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedItem;
  String categotySelectedName;

  final Firestore firestore = Firestore.instance;

  void _createProduct(
      String categoryProductName,
      String productNamel,
      String productModell,
      String productImageUrlL,
      String productPricel,
      String productPriceDiscountL,
      String productStarsL) async {
    try {
      await firestore
          .collection('Categories')
          .document(categoryProductName)
          .collection("Products")
          .document(productNamel)
          .setData({
        'productModel': productModell,
        'productImageUrl': productImageUrlL,
        'productPrice': productPricel,
        'productPriceDiscount': productPriceDiscountL,
        'productStars': productStarsL,
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(categoryNameList);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedItem);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
            stream: Firestore.instance.collection('Categories').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text('Loading');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(shrinkWrap: true, children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Choose Category",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                        ),
                        DropdownButton<String>(
                            value: _selectedItem,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value;
                              });
                            }),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _productName,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Model',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _productModel,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Image',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _productImageUrl,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Price',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _productPrice,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Discount Price',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _productPriceDiscount,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Stars',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _productStars,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0)),
                            child: Text('Add Category'),
                            onPressed: () {
                              _createProduct(
                                  _selectedItem,
                                  _productName.text.toString(),
                                  _productModel.text.toString(),
                                  _productImageUrl.text.toString(),
                                  _productPrice.text.toString(),
                                  _productPriceDiscount.text.toString(),
                                  _productStars.text.toString());
                            })
                      ],
                    )
                  ]);
              }
            },
          ),
        ),
      ),
    );
  }
}
