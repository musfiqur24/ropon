import 'package:flutter/material.dart';

class BougainvilleaDetailPage extends StatefulWidget {
  const BougainvilleaDetailPage({Key? key}) : super(key: key);

  @override
  State<BougainvilleaDetailPage> createState() =>
      _BougainvilleaDetailPageState();
}

class _BougainvilleaDetailPageState extends State<BougainvilleaDetailPage> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Plant Image
            _buildHeaderSection(),

            // Content Section
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE91E63),
            Color(0xFFEC407A),
            Color(0xFFF48FB1),
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Header Icons
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Logo
                        Row(
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
                                  'assets/images/logo.png',
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'রোপণ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Plant Info and Image
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                child: Row(
                  children: [
                    // Left side - Plant Info
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Outdoor Tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'Outdoor',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Plant Name
                            const Text(
                              'বাগানবিলাস',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const Text(
                              '(Bougainvillea)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Plant Family
                            const Text(
                              'Bougainvillea Family\nDeciduous Climbers',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Varieties
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'VARIETIES',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const Text(
                                  '100',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Action Buttons
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isFavorite ? Colors.red : Colors.grey,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2E7D32),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Right side - Plant Image
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 300,
                        child: Image.asset(
                          'assets/images/bougainvillea.png', // Large bougainvillea image
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Section
          const Text(
            'OVERVIEW',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 20),

          // Care Requirements
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCareItem(
                Icons.wb_sunny_outlined,
                'LIGHT',
                '35-40%',
                const Color(0xFF2E7D32),
              ),
              _buildCareItem(
                Icons.thermostat_outlined,
                'TEMPERATURE',
                '70-75°',
                const Color(0xFF2E7D32),
              ),
              _buildCareItem(
                Icons.water_drop_outlined,
                'WATER',
                '250ml',
                const Color(0xFF2E7D32),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // About Section
          const Text(
            'ABOUT',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'বাগানবিলাস হলো একটি সুন্দর, রঙিন ফুল যা বাগান সাজানোর জন্য খুবই জনপ্রিয়। এই গাছের ফুলগুলো চোখে পড়ার মতো উজ্জ্বল রঙের হয়ে থাকে। বাগানবিলাস গাছ লতানো প্রকৃতির এবং এটি দেয়াল বা বেড়ার উপর দিয়ে বেড়ে উঠতে পারে।\n\nবাগানবিলাস গাছ রোপণ করতে হলে - প্রথমে একটি ভালো জায়গা বেছে নিতে হবে। এরপর মাটি প্রস্তুত করতে হবে, মাটি যেন নিকাশ ভালো হয়, তবে এটি কম পানিতেও বেঁচে থাকতে পারে। এটি গরম, শুষ্ক, ঠান্ডা সব আবহাওয়ায় বেঁচে থাকতে পারে।\n\nএই গাছের প্রধান বৈশিষ্ট্য হলো এর প্রাণবন্ত রঙ - গোলাপি, লাল, সাদা, হলুদ, বেগুনি, কমলা, নীল ইত্যাদি বিভিন্ন রঙের ফুল পাওয়া যায়।',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 30),

          // Varieties Section
          const Text(
            'VARIETIES',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bougainvillea_pink.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image:
                          AssetImage('assets/images/bougainvillea_orange.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCareItem(
      IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
