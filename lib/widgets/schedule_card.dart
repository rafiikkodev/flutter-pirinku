import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class ScheduleCard extends StatelessWidget {
  final String time; // Format: "HH:mm" atau "HH.mm"
  final String message;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ScheduleCard({
    Key? key,
    required this.time,
    required this.message,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  bool _isApproaching() {
    try {
      // Parse time string (support both "09:00" and "09.00" format)
      final cleanTime = time.replaceAll('.', ':');
      final timeParts = cleanTime.split(':');

      if (timeParts.length != 2) return false;

      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      final now = DateTime.now();
      final scheduleTime = DateTime(now.year, now.month, now.day, hour, minute);

      // Check if schedule time is in the future
      if (scheduleTime.isBefore(now)) {
        return false;
      }

      // Check if within 1 hour (60 minutes)
      final difference = scheduleTime.difference(now);
      return difference.inMinutes <= 60 && difference.inMinutes >= 0;
    } catch (e) {
      return false;
    }
  }

  Color _getBackgroundColor() {
    return _isApproaching() ? primaryGreenColor : txtSecondary;
  }

  Color _getTextColor() {
    return _isApproaching() ? txtWhite : txtPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isApproaching();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 149,
        decoration: ShapeDecoration(
          color: _getBackgroundColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 24,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            // Image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.restaurant,
                              size: 40,
                              color: Colors.grey[500],
                            ),
                          );
                        },
                      ),
                    )
                  : Icon(Icons.restaurant, size: 40, color: Colors.grey[500]),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: _getTextColor(),
                      fontSize: 16,
                      fontFamily: 'Visby Round CF',
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: TextStyle(
                      color: _getTextColor(),
                      fontSize: 14,
                      fontFamily: 'Visby Round CF',
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
