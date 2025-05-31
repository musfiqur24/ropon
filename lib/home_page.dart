import 'package:flutter/material.dart';
import 'bougainvillea_detail_page.dart';
import 'marketplace_page.dart';
import 'camera_page.dart'; // <--- Changed import to camera_page.dart

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),

              const SizedBox(height: 20),

              // Banner Section
              _buildBannerSection(),

              const SizedBox(height: 20),

              // Search Bar
              _buildSearchBar(),

              const SizedBox(height: 30),

              // Navigation Grid
              _buildNavigationGrid(),

              const SizedBox(height: 30),

              // Trending Greens Section
              _buildTrendingGreensSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Color(0xFF8BC34A),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 30,
                    height: 30,
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
          // Icons
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF8BC34A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image (left side)
                  Container(
                    width: 150, // Fixed width to maintain current size
                    height: 160, // Fixed height to maintain current size
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/girl_with_plant.png',
                        fit: BoxFit
                            .contain, // Changed to contain to prevent cropping
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), // Spacing between image and text
                  // Text Content (right side)
                  SizedBox( // Changed Container to SizedBox for simplicity, maintaining width
                    width: 140, // Fixed width for text section
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Exclusive\nOffer',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Get your 1st plant\n@ 60% off',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Pagination dots
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: index == _currentBannerIndex ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: index == _currentBannerIndex
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Plants',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
            ),
            suffixIcon: Icon(
              Icons.fullscreen, // Assuming this is for filter or scan
              color: Colors.grey.shade500,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationGrid() {
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.camera_alt_outlined, 'label': 'Camera'},
      {'icon': Icons.local_hospital_outlined, 'label': 'Diagnosis'},
      {'icon': Icons.shopping_cart_outlined, 'label': 'Cart'},
      {'icon': Icons.store_outlined, 'label': 'MarketPlace'},
      {'icon': Icons.add_circle_outline, 'label': 'Post your Plant'},
      {'icon': Icons.chat_bubble_outline, 'label': 'Community\nChat'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: navItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate based on tapped item
              final String label = navItems[index]['label'];
              if (label == 'MarketPlace') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MarketplacePage(),
                  ),
                );
              } else if (label == 'Camera') { // <--- Condition for Camera tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(), // <--- Navigate to CameraPage
                  ),
                );
              }
              // You can add more conditions for other navigation items here
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
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
                  child: Icon(
                    navItems[index]['icon'],
                    color: const Color(0xFF2E7D32),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  navItems[index]['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingGreensSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trending Greens',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Plant Cards
          _buildPlantCard(
            'বাগানবিলাস',
            '(Bougainvillea)',
            'Bougainvillea Family\nDeciduous Climbers',
            'assets/images/bougainvillea.png',
            const Color(0xFFE91E63),
            '+15',
          ),

          const SizedBox(height: 15),

          _buildPlantCard(
            'টমেটো',
            '(Tomato)',
            'Nightshade Family\nVegetable (Edible Berry)',
            'assets/images/tomato.png',
            const Color(0xFFFF9800),
            '+2',
          ),
        ],
      ),
    );
  }

  Widget _buildPlantCard(
      String bengaliName,
      String englishName,
      String description,
      String imagePath,
      Color badgeColor,
      String badgeText,
      ) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page if it's bougainvillea
        if (bengaliName == 'বাগানবিলাস') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BougainvilleaDetailPage(),
            ),
          );
        }
      },
      child: Container(
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
          children: [
            // Plant Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 15),

            // Plant Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                          ],
                        ),
                      ),
                      // Heart Icon
                      Icon(
                        Icons.favorite,
                        color: Colors.red.shade400,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badgeText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}