import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String title;
  final String description;
  final double price;
  final String status;

  Item({required this.title, required this.description, required this.price, required this.status});

  factory Item.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Item(
      title: data['title'],
      description: data['description'],
      price: data['price'],
      status: data['status'],
    );
  }
}

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Item item = Item.fromSnapshot(document);

              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.description),
                trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailsPage(item: item)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ItemDetailsPage extends StatefulWidget {
  final Item item;

  ItemDetailsPage({required this.item});

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description:'),
            Text(widget.item.description),
            SizedBox(height: 16.0),
            Text('Price: \$${widget.item.price.toStringAsFixed(2)}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _handleBuySell(widget.item); // Handle buy/sell operation
              },
              child: Text('Buy/Sell'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBuySell(Item item) async {
    try {
      if (item.status == 'available') {
        // Perform buy operation
        // Update item status in Firebase
        await FirebaseFirestore.instance.collection('items').doc(item.title).update({'status': 'sold'});

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('You have bought the item ${item.title}.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
// Perform sell operation
        // Update item status in Firebase
        await FirebaseFirestore.instance.collection('items').doc(item.title).update({'status': 'available'});

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('You have sold the item ${item.title}.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
