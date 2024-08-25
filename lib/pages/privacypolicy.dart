// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';

class Privacypolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //app bar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiProvider.dark ? Colors.black : Colors.white30,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 70,right: 70,bottom: 70),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //title
              Text(
                'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.indigoAccent)
              ),
              //line
               Divider(thickness: 1.5,color: Colors.indigoAccent,),
               SizedBox(height: 10,),
              Row(
                children: [
                  //date
                  Text(
                    'Effective Date: 17-05-2024',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                    )
                ],
              ),
              SizedBox(height: 30),
              //policy
              Text(
                '1. Introduction\n'
                'Welcome to our Privacy Policy. Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application. Please read this privacy policy carefully.\n\n'
                '2. Information Collection\n'
                'We may collect information about you in a variety of ways. The information we may collect from you includes:\n\n'
                '   - Personal Data\n'
                '   - Derivative Data\n'
                '   - Financial Data\n'
                '   - Mobile Device Data\n\n'
                '3. Use of Your Information\n'
                'Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience. Specifically, we may use information collected about you via the application to:\n\n'
                '   - Assist Law Enforcement and Respond to Subpoenas\n'
                '   - Compile Anonymous Data\n'
                '   - Create and Manage Your Account\n'
                '   - Deliver Targeted Advertising\n\n'
                '4. Disclosure of Your Information\n'
                'We may share information we have collected about you in certain situations. Your information may be disclosed as follows:\n\n'
                '   - By Law or to Protect Rights\n'
                '   - Business Transfers\n'
                '   - With Your Consent\n\n'
                '5. Security of Your Information\n'
                'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable.\n\n'
                '6. Contact Us\n'
                'If you have questions or comments about this Privacy Policy, please contact us at:\n\n'
                'g@gmail.com\n'
                'Chopin',
                style: TextStyle(fontWeight: FontWeight.w400)
              ),
            ],
          ),
        ),
      ),
    );
  }
}