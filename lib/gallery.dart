import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        selectedIndex: 0,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              buildprofile(),
              searchbar(),
              menu(),

              // HANYA bagian ini yang bisa di-scroll
              Expanded(child: productMasonryGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildprofile() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello,Welcome'),
              SizedBox(height: 4),
              Text(
                'Albert Stevano',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/Profile.png')),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchbar() {
    const border = Color(0xFFE9ECF1);
    const dark = Color(0xFF262626);
    const radius = 12.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search clothes…',
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/search-normal.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    borderSide: BorderSide(color: border),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    borderSide: BorderSide(color: border),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(radius)),
                child: Ink(
                  height: double.infinity,
                  width: 48,
                  decoration: const BoxDecoration(
                    color: dark,
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    border: Border.fromBorderSide(BorderSide(color: border)),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/Filter.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menu() {
    final items = const [
      ('All Items', 'assets/Default Icon.png'),
      ('Dress', 'assets/dress.png'),
      ('T-Shirt', 'assets/tshirt.png'),
      ('Pants', 'assets/pants.png'),
    ];
    int selected = 0;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: StatefulBuilder(
        builder: (context, setSBState) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(items.length, (i) {
                final (label, asset) = items[i];
                final isSelected = i == selected;
                return Padding(
                  padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
                  child: InkWell(
                    onTap: () => setSBState(() => selected = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            asset,
                            width: 20,
                            height: 20,
                            color: isSelected ? Colors.white : Colors.black,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color:
                                  isSelected
                                      ? Colors.white
                                      : const Color(0xFF1F2430),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget productMasonryGrid() {
    // data dummy
    final images = [
      'assets/Product 1.png',
      'assets/Product 2.png',
      'assets/Product 3.png',
      'assets/Product 4.png',
    ];
    final titles = [
      'Modern Light Clothes',
      'Light Dress Bless',
      'Classic Shades',
      'Autumn Casual',
    ];
    final subtitles = ['T-Shirt', 'Dress Modern', 'Jacket', 'Dress'];
    final prices = [212.99, 162.99, 89.50, 134.49];
    final ratios = [0.78, 0.68, 0.55, 0.70];
    final ratings = [5.0, 4.8, 4.6, 4.9];

    const textPrimary = Color(0xFF1F2430);
    const textSecondary = Color.fromARGB(255, 103, 107, 116);

    final liked = <int>{};

    return StatefulBuilder(
      builder: (context, setSBState) {
        return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: images.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 20, bottom: 24),
          itemBuilder: (context, i) {
            final img = images[i];
            final title = titles[i];
            final subtitle = subtitles[i];
            final price = prices[i];
            final ratio = ratios[i];
            final rating = ratings[i];
            final isLiked = liked.contains(i);

            return Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: ratio,
                            child: Image.asset(
                              img,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => Container(
                                    height: 140,
                                    color: const Color(0xFFF1F2F6),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                    ),
                                  ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap:
                                  () => setSBState(() {
                                    isLiked ? liked.remove(i) : liked.add(i);
                                  }),
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Image.asset(
                                  isLiked
                                      ? 'assets/heart (1).png'
                                      : 'assets/heart.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textSecondary,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/star.png'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
