// lib/cart_page.dart
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Dummy data for cart items.
  // In a real app, this data would come from a global state manager (like Provider)
  // or be fetched from a database.
  List<Map<String, dynamic>> _cartItems = [
    {
      'id': 'bougainvillea_orange_1', // Unique ID for each item
      'name_bengali': 'হালকা গোলাপী বাগানবিলাস',
      'name_english': '(Bougainvillea)',
      'price': 100, // Price per unit
      'quantity': 2,
      'listed_by': 'Plant Lovers BD',
      'location': 'Keraniganj, Dhaka',
      'image': 'assets/images/bougainvillea_orange.png',
    },
    {
      'id': 'bougainvillea_pink_1', // Unique ID
      'name_bengali': 'গোলাপী বাগানবিলাস',
      'name_english': '(Bougainvillea)',
      'price': 110, // Price per unit
      'quantity': 1,
      'listed_by': 'Plant Lovers BD',
      'location': 'Middle Badda, Dhaka',
      'image': 'assets/images/bougainvillea_pink.png',
    },
    // You can add more dummy items here for testing
    // {
    //   'id': 'jasmine_1',
    //   'name_bengali': 'জেসমিন ফুল',
    //   'name_english': '(Jasmine)',
    //   'price': 80,
    //   'quantity': 3,
    //   'listed_by': 'Flower Farm',
    //   'location': 'Gulshan, Dhaka',
    //   'image': 'assets/images/logo.png', // Placeholder if no jasmine image
    // },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate totals dynamically based on _cartItems
    int productPrice = 0;
    for (var item in _cartItems) {
      productPrice += (item['price'] * item['quantity'] as int);
    }

    int packagingCharge = 40; // Example static charge
    int deliveryCharge = 40; // Example static charge
    int total = productPrice + packagingCharge + deliveryCharge;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', // Ensure your logo is here
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'রোপণ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline, color: Colors.white, size: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User/Delivery Info
            const Text(
              'CART',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            _buildUserInfoCard(
              name: 'Name: Musfique Rahman',
              address: 'Delivery Address: Middle Badda, Link Road, Dhaka.',
              contact: 'Contact Number: 018XXXXXXXXX',
            ),
            const SizedBox(height: 20),

            // Order List Header
            const Text(
              'ORDER LIST',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            // Cart Items
            _cartItems.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: _buildCartItemCard(
                    imagePath: item['image'],
                    bengaliName: item['name_bengali'],
                    englishName: item['name_english'],
                    listedBy: item['listed_by'],
                    location: item['location'],
                    price: item['price'], // Price per unit
                    quantity: item['quantity'],
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        if (newQuantity <= 0) {
                          // If quantity becomes 0 or less, remove the item
                          _cartItems.removeAt(index);
                        } else {
                          _cartItems[index]['quantity'] = newQuantity;
                        }
                      });
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            // Only show divider and summary if cart is not empty
            if (_cartItems.isNotEmpty) ...[
              const Divider(color: Colors.grey, thickness: 1), // Divider as in image

              // Price Summary
              _buildPriceSummaryRow('Product Price', productPrice),
              _buildPriceSummaryRow('Packaging Charge', packagingCharge),
              _buildPriceSummaryRow('Delivery Charge', deliveryCharge),

              const SizedBox(height: 10),
              const Divider(color: Colors.grey, thickness: 1), // Divider as in image

              // Total Price
              _buildTotalRow('Total', total),
              const SizedBox(height: 10),
              _buildCashOnDeliveryNote(),
            ],
            const SizedBox(height: 30),

            // Action Buttons (always show, but disable if cart is empty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  'CANCEL',
                  Colors.red.shade700,
                  _cartItems.isNotEmpty
                      ? () {
                    // TODO: Implement cancel logic, maybe clear cart and pop
                    setState(() {
                      _cartItems.clear(); // Clear all items
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order Cancelled and Cart Cleared!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // Navigator.pop(context); // Optional: Pop after cancelling
                  }
                      : null, // Disable if cart is empty
                ),
                _buildActionButton(
                  'CONFIRM',
                  const Color(0xFF2E7D32),
                  _cartItems.isNotEmpty
                      ? () {
                    // TODO: Implement confirm order logic (e.g., send to backend)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order Confirmed!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    setState(() {
                      _cartItems.clear(); // Clear cart after confirmation
                    });
                    // Optionally navigate away or clear cart
                    // Navigator.pop(context);
                  }
                      : null, // Disable if cart is empty
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard({required String name, required String address, required String contact}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            address,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 5),
          Text(
            contact,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard({
    required String imagePath,
    required String bengaliName,
    required String englishName,
    required String listedBy,
    required String location,
    required int price,
    required int quantity,
    required Function(int) onQuantityChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plant Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Plant Info and Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bengaliName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  englishName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Listed By: $listedBy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tk. ${price.toString()}', // Display price per unit
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Quantity Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF8BC34A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    // Only decrease if quantity is greater than 1
                    if (quantity > 1) {
                      onQuantityChanged(quantity - 1);
                    } else if (quantity == 1) {
                      // If quantity is 1 and decreased, prompt to remove or remove directly
                      // For simplicity, directly remove item if quantity becomes 0 or less
                      onQuantityChanged(0); // This will trigger removal in parent
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    color: quantity > 0 ? Colors.white : Colors.white.withOpacity(0.5), // Dim if cannot decrease
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  quantity.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    onQuantityChanged(quantity + 1);
                  },
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummaryRow(String label, int amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            amount.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, int amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Text(
            amount.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildCashOnDeliveryNote() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        '(Cash on Delivery)',
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed, // Pass the onPressed directly
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null ? color : Colors.grey, // Grey out if disabled
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}