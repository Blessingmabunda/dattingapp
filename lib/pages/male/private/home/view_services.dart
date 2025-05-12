import 'package:flutter/material.dart';

import '../../../../shared/botton_nav_bar.dart';

class ViewService extends StatefulWidget {
  static const String routeName = '/viewservice';

  @override
  _ViewServiceState createState() => _ViewServiceState();
}

class _ViewServiceState extends State<ViewService> {
  final Map<String, int> services = {
    '1 Hour Meetup': 50,
    'Dinner Date': 100,
    'Overnight': 300,
  };

  List<String> cart = [];
  String selectedLocation = 'I Host';

  int get totalPrice => cart.fold(0, (sum, item) => sum + services[item]!);

  final List<String> locations = [
    'I Host',
    'You Host',
    'I Travel',
    'You Travel',
  ];

  void addToCart(String service) {
    setState(() {
      if (!cart.contains(service)) {
        cart.add(service);
      }
    });
  }

  void removeFromCart(String service) {
    setState(() {
      cart.remove(service);
    });
  }

  void sendRequest() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request sent successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sarah's Services",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFF001F54), // AppBar uses blue
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001F54),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: services.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final name = services.keys.elementAt(index);
                    final price = services.values.elementAt(index);
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'R$price',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.pink, // Price in pink
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => addToCart(name),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink, // Button pink
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Cart Section
              if (cart.isNotEmpty) ...[
                SizedBox(height: 20),
                Text(
                  'Your Selection',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001F54),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ...cart.map((item) => Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Text(
                                'R${services[item]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close, size: 18),
                                onPressed: () => removeFromCart(item),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedLocation,
                          items: locations
                              .map((loc) => DropdownMenuItem(
                            value: loc,
                            child: Text(loc),
                          ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => selectedLocation = val);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Location Preference',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R$totalPrice',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: sendRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF001F54), // Button pink
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Send Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: HookUpNavBar(
        currentIndex: 0,
        onTap: (index) {
          print("Tapped tab: $index");
          // Handle navigation logic here
        },
      ),
    );
  }
}
