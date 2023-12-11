import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShOp_MaTe'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StockScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
            ),
            child: Text(
              'Stock',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerTrackScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
            ),
            child: Text(
              'Customer Track',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ],
      ),
    );
  }
}

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List<Product> products = [];
  void editProduct(int index, Product editedProduct) {
    setState(() {
      products[index] = editedProduct;
    });
  }

  void addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Show the form when the plus icon is pressed
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddProductForm(addProduct);
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Actions')),
            ],
            rows: products.asMap().entries.map((entry) {
              int index = entry.key;
              Product product = entry.value;

              return DataRow(cells: [
                DataCell(Text(product.name)),
                DataCell(Text(product.quantity.toString())),
                DataCell(Text(product.price.toString())),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
// Show the form when the edit icon is pressed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditProductForm(
                              index,
                              product,
                              editProduct,
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Implement delete functionality here
                        deleteProduct(index);
                      },
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class AddProductForm extends StatelessWidget {
  final Function(Product) onFormSubmit;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  AddProductForm(this.onFormSubmit);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: Form(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Process the submitted form data (add to local DB in a real app)
            Product product = Product(
              name: nameController.text,
              quantity: int.tryParse(quantityController.text) ?? 0,
              price: double.tryParse(priceController.text) ?? 0.0,
            );

            onFormSubmit(product);

            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}

class Product {
  final String name;
  final int quantity;
  final double price;

  Product({required this.name, required this.quantity, required this.price});
}

class CustomerTrackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Track'),
      ),
      body: Center(
        child: Text(
          'This is the CTrack Screen!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class EditProductForm extends StatelessWidget {
  final int index;
  final Product originalProduct;
  final Function(int, Product) onFormSubmit;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController priceController;

  EditProductForm(this.index, this.originalProduct, this.onFormSubmit)
      : nameController = TextEditingController(text: originalProduct.name),
        quantityController =
            TextEditingController(text: originalProduct.quantity.toString()),
        priceController =
            TextEditingController(text: originalProduct.price.toString());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Product'),
      content: Form(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Process the submitted form data
            Product editedProduct = Product(
              name: nameController.text,
              quantity: int.tryParse(quantityController.text) ?? 0,
              price: double.tryParse(priceController.text) ?? 0.0,
            );

            onFormSubmit(index, editedProduct);

            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Save Changes'),
        ),
      ],
    );
  }
}
