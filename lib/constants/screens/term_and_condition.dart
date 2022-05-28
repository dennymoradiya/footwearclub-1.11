import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/screens/widget/expanded_list_tile.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Terms and Conditions"),
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
                    "Terms and Conditions",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  collapsedTextColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: [
                    Text(
                        "The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: “Client”, “You” and “Your” refers to you, the person log on this app and compliant to the Company’s terms and conditions. “The Company”, “Ourselves”, “We”, “Our” and “Us”, refers to our Company. “Party”, “Parties”, or “Us”, refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.")
                  ],
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
              titles: "License",
              text:
                  "Unless otherwise stated, Footwear Club  and/or its licensors own the intellectual property rights for all material on Footwear Club . All intellectual property rights are reserved. You may access this from Footwear Club  for your own personal use subjected to restrictions set in these terms and conditions.\nThis Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Terms And Conditions Template.\nParts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the app. Footwear Club  does not filter, edit, publish or review Comments prior to their presence on the app. Comments do not reflect the views and opinions of Footwear Club ,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Footwear Club  shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this app",
            ),
            const ExpandedListTile(
              titles: "Content Liability",
              text:
                  "We shall not be hold responsible for any content that appears on your app. You agree to protect and defend us against all claims that is rising on your app. No link(s) should appear on any app that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.",
            ),
            const ExpandedListTile(
              titles: "Reservation of Rights",
              text:
                  "We reserve the right to request that you remove all links or any particular link to our app. You approve to immediately remove all links to our app upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our app, you agree to be bound to and follow these linking terms and conditions.",
            ),
            const ExpandedListTile(
              titles: "Disclaimer",
              text:
                  "To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our app and the use of this app. Nothing in this disclaimer will:\nlimit or exclude our or your liability for death or personal injury;\nlimit or exclude our or your liability for fraud or fraudulent misrepresentation;\nlimit any of our or your liabilities in any way that is not permitted under applicable law;\nexclude any of our or your liabilities that may not be excluded under applicable law.",
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
