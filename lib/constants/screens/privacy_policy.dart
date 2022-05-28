import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';

import 'widget/expanded_list_tile.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Privacy Policy"),
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: EdgeInsets.all(15),
                  title: Text(
                    "Introduction",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  collapsedTextColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: [Text("Footwear Club Privacy Policy: Account means a unique account created for You to access our Service or parts of our Service. Company (referred to as either “the Company”, “We”, “Us” or “Our” in this Agreement) refers to Footwear Club . Cookies are small files that are placed on Your computer, mobile device or any other device by a website, containing the details of Your browsing history on that website among its many uses. Country refers to: Gujarat, India Device means any device that can access the Service such as a computer, a cellphone or a digital tablet. Personal Data is any information that relates to an identified or identifiable individual. Service refers to the App")],
                  trailing: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                )
              ],
            ),
           
            const ExpandedListTile(
              titles: "Usage Data",
              text:
                  "Usage Data is collected automatically when using the Service. Usage Data may include information such as Your Device’s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data. When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data. We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.",
            ),
            const ExpandedListTile(
              titles: "Use of Your Personal Data",
              text:
                  "The Company may use Personal Data for the following purposes:\nTo provide and maintain our Service, including to monitor the usage of our Service. To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.\nFor the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service. To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application’s push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.\nTo provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.",
            ),
              const ExpandedListTile(
              titles: "Retention of Data",
              text:
                  "The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.\nThe Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.",
            ),
              const ExpandedListTile(
              titles: "Disclosure",
              text:
                  "Business Transactions If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.\nLaw enforcement Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).\nOther legal requirements The Company may disclose Your Personal Data in the good faith belief that such action is necessary to: Comply with a legal obligation Protect and defend the rights or property of the Company Prevent or investigate possible wrongdoing in connection with the Service Protect the personal safety of Users of the Service or the public Protect against legal liability",
            ),
              const ExpandedListTile(
              titles: "Children’s Privacy",
              text:
                  "Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.\nIf We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent’s consent before We collect and use that information.",
            ),
              const ExpandedListTile(
              titles: "Contact Us",
              text:
                  "If you have any questions about this Privacy Policy, You can contact us:\nBy email: support@footwearclub.com",
            ),
          ],
        ));
  }
}

