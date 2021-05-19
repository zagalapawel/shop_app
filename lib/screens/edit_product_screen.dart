import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  // Czyszczenie pamięći (niezbędne przy własnych FocusNode)
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    // _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  // Podgląd po zmianie Focus'a
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                // FocusScope (ogólnie focus) daje możliwość przechodzenia do konkretnych komórek wskazanych przez FocusNode()
                // Dzięki "textInputAction: TextInputAction.next" po kliknięciu 'dalej'
                // na klawiaturze focus przejdzie do następnego okienka
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                // textInputAction: TextInputAction.next,
                // tym razem to musi być wyłączone aby multiline działał i zamiast 'dalej' był zwykły 'enter'
                keyboardType: TextInputType.multiline,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(child: Text('Enter a URL'))
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.fill,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      focusNode: _imageUrlFocusNode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
