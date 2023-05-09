import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:quickworks/models/job.dart';
import 'package:share_plus/share_plus.dart';

void shareLink(Job job) async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://www.quickjobs.com/Job?title==${job.title}"),
    socialMetaTagParameters: SocialMetaTagParameters(
        description: job.description,
        title: job.title,
        imageUrl: Uri.parse(job.image)),
    uriPrefix: "https://quickjobsapp.page.link",
    androidParameters:
        const AndroidParameters(packageName: "com.quickworks.quickworks"),
  );
  var dynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  await Share.share(dynamicLink.shortUrl.toString());
}
