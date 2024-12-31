import 'package:amwalpay/common_libs.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;

  final double? radius;

  const CommonButton(
      {super.key,
      required this.label,
      required this.onTap,
      this.backgroundColor = AppColors.primaryColor,
      this.foregroundColor = AppColors.whiteColor,
      this.height = 45,
      this.width = 200,
      this.radius = 2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child: Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
