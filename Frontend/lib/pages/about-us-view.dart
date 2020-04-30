import 'package:flutter/material.dart';
import '../custom-widgets/custom-drawer.dart';
import '../util/appcolor.dart';

const DummyText =
    "The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt fox. Bright vixens jump; dozy fowl quack. Quick wafting zephyrs vex bold Jim. Quick zephyrs blow, vexing daft Jim. Sex-charged fop blew my junk TV quiz. How quickly daft jumping zebras vex. Two driven jocks help.";

class AboutUsView extends StatelessWidget {

        // ** INSTRUCTIONS FOR ADDING Your Image and Information on About Us Page ** //
  // Step 1: Have you photo in .jpg format. 
  // Step 2: Move your photo that you want to put on About us page to [member-pics folder]
  // Step 3: Go to [pubspec.yaml] in the root directory, go to line 46, insert a line like this - "member-pics/[Your Photo File].jpg" under [asset:]
  // Step 4: Go back to this file, go to line 100. Check which line 100-103 that has not been filled (meaning if the parameters are "Member X", "Title X", "member-pics/memberOnePic.jpg")
    // Step 4B (For new contributor only): If you are a new contributor, you would need to add in another renderMethod() because there are only 4, on the line after the last renderMethod()
    // Step 4C: Move to Step 5

  // Step 5: renderMember() takes in a name, title, and an image link in Step 2. Just replace "Member X" with your name, "Title X" with your title and "member-pics/memberOnePic.jpg" with your  

  Container renderMember(String name, String title, String imageRelativeLink) {
    return Container(
        //'member-pics/memberOnePic.jpg' => Example of Relative link
        margin: EdgeInsets.fromLTRB(30, 25, 0, 0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imageRelativeLink,
                width: 90,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name,
                        style: TextStyle(
                            color: AppColor.primaryDarkColor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: 20)),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(title,
                          style: TextStyle(
                              color: AppColor.primaryDarkColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 17)),
                    ),
                  ],
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: AppColor.primaryColor,
          appBar: AboutUsAppBar(),
          endDrawer: CustomDrawer(),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text("About Us",
                        style: TextStyle(
                            color: AppColor.primaryDarkColor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: 20)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 25, 30, 0),
                    child: Text(DummyText, // Replace this
                        style: TextStyle(
                            color: AppColor.primaryDarkColor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            height: 1.8)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 25, 0, 0),
                    child: Text("The Team",
                        style: TextStyle(
                            color: AppColor.primaryDarkColor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: 20)),
                  ),
                  renderMember("Member 1", "Title 1", "member-pics/memberOnePic.jpg"),
                  renderMember("Member 2", "Title 2", "member-pics/memberOnePic.jpg"),
                  renderMember("Member 3", "Title 3", "member-pics/memberOnePic.jpg"),
                  renderMember("Member 4", "Title 4", "member-pics/memberOnePic.jpg"),
                  // If you are new contributor, add another renderMember() here
                  // Example: renderMember("John Doe", "Web Designer", "member-pics/JohnDoe.jpg"),
    
                  SizedBox(height: 30)
                ]
          ),
      ),
    );
  }
}

class AboutUsAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: AppColor.primaryColor,
        iconTheme: IconThemeData(
            opacity: 20,
            color: AppColor.primaryDarkColor,
            size: IconTheme.of(context).size),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

}
