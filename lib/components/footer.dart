import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  Footer({super.key});
  final Uri _url = Uri.parse('https://bdnaash.com');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Made with 💚 by efzet'),
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Data is provided by ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 24,
                child: InkWell(
                  onTap: () async {
                    await _launchUrl();
                  },
                  child: SvgPicture.network(
                    'https://cdn.bdnaash.com/images/logo.svg',
                    height: 24,
                  ),
                ),
              )
            ]),
      ],
    );
  }
}
