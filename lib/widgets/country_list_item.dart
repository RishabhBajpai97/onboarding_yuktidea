import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onboarding_yuktidea/notifiers/user_notifier.dart';

class CountryListItem extends ConsumerStatefulWidget {
  final dynamic countryItem;
  const CountryListItem({super.key, this.countryItem});

  @override
  ConsumerState<CountryListItem> createState() => _CountryListItemState();
}

class _CountryListItemState extends ConsumerState<CountryListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref
            .read(userNotifierProvider.notifier)
            .setMobileCountry(widget.countryItem);
        Navigator.of(context).pushNamed("/mobile");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Center(
          child: SizedBox(
            width: 297.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 34.w,
                  height: 22.h,
                  child: SvgPicture.network(
                    widget.countryItem["flag"],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  widget.countryItem["name"],
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  widget.countryItem["tel_code"],
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
