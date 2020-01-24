import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lazyloader extends StatefulWidget {
  @override
  _LazyloaderState createState() => _LazyloaderState();
}

class _LazyloaderState extends State<Lazyloader> {
  Firestore _firestore = Firestore.instance;
  List _products = [];
  bool _loadingProducts = true;
  int _paginationLimit = 10;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsIsAvailable = true;

  _getProducts() async {
    Query q = _firestore.collection('noticias').limit(_paginationLimit);
    setState(() => _loadingProducts = true);
    QuerySnapshot querySnapshot = await q.getDocuments();

    if (querySnapshot.documents.length > 0) {
      _lastDocument = querySnapshot.documents.last;
    }

    _products.addAll(querySnapshot.documents);
    setState(() => _loadingProducts = false);
  }

  _getMoreProducts() async {
    if (!_moreProductsIsAvailable || _gettingMoreProducts) return;

    _gettingMoreProducts = true;
    Query q = _firestore
        .collection('noticias')
        .orderBy('titulo')
        .startAfterDocument(_lastDocument)
        .limit(_paginationLimit);

    QuerySnapshot querySnapshot = await q.getDocuments();
    if (querySnapshot.documents.length > 0) {
      _lastDocument = querySnapshot.documents.last;
    }
    _moreProductsIsAvailable = querySnapshot.documents.length > 0;

    _products.addAll(querySnapshot.documents);
    _gettingMoreProducts = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getProducts();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        _getMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: _loadingProducts == true
          ? Container(
              child: Center(
                child: Text("loading"),
              ),
            )
          : Container(
              child: _products.length == 0
                  ? Center(
                      child: Text("no data"),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _products.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ListTile(
                          title: Text(_products[index].data['titulo']),
                        );
                      },
                    )),
    );
  }
}
