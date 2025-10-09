import 'package:chargerrr_app/components/container_design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class StationsCard extends StatelessWidget {
  final String stationName;
  final int availablePoints;
  final int totalPoints;
  final String address;
  final VoidCallback onPressed;
  final List amenities;
  const StationsCard({
    super.key,
    required this.stationName,
    required this.availablePoints,
    required this.totalPoints,
    required this.address,
    required this.onPressed,
    required this.amenities,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ContainerDesign(
        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(12),
        //   color: Colors.white,
        //   border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  stationName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  child: Icon(Icons.favorite_outline, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(color: Colors.grey.shade700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/energy.png',
                  height: 15,
                  color: Colors.green.shade800,
                ),
                const SizedBox(width: 5),
                Text(
                  '$availablePoints/$totalPoints available',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 25),
                Image.asset('assets/clock.png', height: 15, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  "24/7",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 25),
                Icon(Icons.star_outline, size: 20, color: Color(0xffbf9b30)),
                const SizedBox(width: 5),
                Text(
                  "4",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: amenities.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.15),
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      amenities[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, _) => SizedBox(width: 10),
              ),
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
