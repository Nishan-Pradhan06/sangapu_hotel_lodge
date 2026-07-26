import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // <-- Pass custom title
  final double height; // <-- Allow custom height

  const AdminCustomAppBar({
    super.key,
    required this.title,
    this.height = 100, // default height
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // optional: hide default back button
      toolbarHeight: height,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                width: 35,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: const Offset(1, 0),
                    ),
                  ],
                ),
                child: SvgPicture.asset('assets/svg/bell.svg'),
              ),
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF6B48FF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/verified.svg'),
                    const SizedBox(width: 5),
                    Text(
                      'Admin',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B48FF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
