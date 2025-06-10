import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialItem extends StatelessWidget {
  final String imageUrl; // اسم معبر أكثر
  final String
      linkUrl; // رابط الشبكة الاجتماعية، البريد الإلكتروني، أو رقم الهاتف
  final List<BoxShadow>? boxShadow;

  const SocialItem({
    super.key,
    required this.imageUrl,
    required this.linkUrl,
    this.boxShadow,
  });

  // دالة لفتح الرابط
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'لا يمكن فتح الرابط: $url';
    }
  }

  // دالة لفتح البريد الإلكتروني
  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'لا يمكن فتح تطبيق البريد لإرسال رسالة إلى: $email';
    }
  }

  // دالة للاتصال برقم الهاتف
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'لا يمكن فتح تطبيق الهاتف للاتصال بـ: $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (linkUrl.startsWith('mailto:')) {
          // إذا كان الرابط بريدًا إلكترونيًا
          _launchEmail(linkUrl.replaceFirst('mailto:', ''));
        } else if (linkUrl.startsWith('tel:') ||
            RegExp(r'^\+?\d+$').hasMatch(linkUrl)) {
          // إذا كان الرابط رقم هاتف (يدعم + أو أرقام فقط)
          String phoneNumber = linkUrl.startsWith('tel:')
              ? linkUrl.substring(4)
              : linkUrl; // إزالة tel: إذا كانت موجودة
          _makePhoneCall(phoneNumber);
        } else {
          // إذا كان رابط عادي (HTTP أو HTTPS)
          _launchURL(linkUrl);
        }
      },
      child: Container(
        width: 42.w,
        height: 41.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.fill,
          ),
          boxShadow: boxShadow,
        ),
      ),
    );
  }
}
