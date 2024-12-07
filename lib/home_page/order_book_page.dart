import 'package:flutter/material.dart';

import '../jsonclass.dart';
import '../localdb.dart';
import 'bottombar/bottombar.dart';

class OrderFormPage extends StatefulWidget {
  final String description;
  final String name;
  final String price;
  final String imageUrl;

  const OrderFormPage({
    Key? key,
    required this.description,
    required this.name,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _OrderFormPageState createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  // Radio button values for payment method
  String? _paymentMethod = 'online'; // Default selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Book',
        ),
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Delivery Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Full Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.lightBlue.shade100)),
                        prefixIcon: Icon(Icons.person,
                            color: Colors.lightBlue.shade200),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Full Name is required';
                        }
                        return null;
                      },
                    ),
                    //const SizedBox(height: 20),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    // Phone Number Field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.lightBlue.shade100)),
                        prefixIcon:
                            Icon(Icons.phone, color: Colors.lightBlue.shade200),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone Number is required';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    // Address Field
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.lightBlue.shade100)),
                        prefixIcon:
                            Icon(Icons.home, color: Colors.lightBlue.shade300),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    // City Field
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.lightBlue.shade100)),
                        prefixIcon: Icon(Icons.location_city,
                            color: Colors.lightBlue.shade300),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'City is required';
                        }
                        return null;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    // Pin Code Field
                    TextFormField(
                      controller: _pinCodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Pin Code',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.lightBlue.shade100)),
                        prefixIcon: Icon(Icons.pin_drop,
                            color: Colors.lightBlue.shade300),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Pin Code is required';
                        }
                        if (value.length != 6) {
                          return 'Enter a valid 6-digit Pin Code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Payment Method Radio Buttons
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text('Online Transaction'),
                      leading: Radio<String>(
                        value: 'online',
                        groupValue: _paymentMethod,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value;
                          });
                        },
                      ),
                      // trailing: const Icon(Icons.credit_card),
                    ),
                    ListTile(
                      title: const Text('Cash on Delivery'),
                      leading: Radio<String>(
                        value: 'cod',
                        groupValue: _paymentMethod,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value;
                          });
                        },
                      ),
                      // trailing: const Icon(Icons.money),
                    ),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Order Cancel'),
                                  content: const Text(
                                    'Are you sure! Your order has been cancel.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Bottomnavigation(
                                                    index: 0,
                                                  ))),
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'NO',
                                        style:
                                            TextStyle(color: Colors.lightGreen),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Quick',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Order Placed'),
                                    content: const Text(
                                      'Thank you! Your order has been placed successfully.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          print('order');
                                          try {
                                            print("enter the order table");
                                            var order =
                                                await DatabaseHandler.orders();
                                            print(order.length);
                                            print(order);
                                            var order_detail = Order_Detail(
                                                widget.description,
                                                widget.name,
                                                widget.price,
                                                widget.imageUrl);
                                            await DatabaseHandler.insertOrder(
                                                order_detail);
                                          } catch (e) {
                                            // Show error message if something goes wrong
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Failed to add product: $e"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }

                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade400,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Place Order',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                    // Place Order Button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
