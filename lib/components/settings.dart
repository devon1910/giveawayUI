import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/screens/updateProfile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:settings_ui/settings_ui.dart';
class Settings extends StatefulWidget {
  // Settings({required this.token});

  // final token;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool themeStatus= true;
  bool secStatus=false;
  bool finStatus=false;
  bool passStatus=false;
  bool notiStatus=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    themeStatus=!themeStatus;
                //    print(toggle);
                  });
                },
                initialValue: themeStatus,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                    onPressed: (value){
                      pushNewScreenWithRouteSettings(context,
                          settings: RouteSettings(name: UpdateProfile.routeName),
                          screen: UpdateProfile(
                              token: "widget.token",
                              parameter: "username",
                              icon: Icons.person,
                              keypadType: TextInputType.name),
                          withNavBar: false,
                          pageTransitionAnimation:
                          PageTransitionAnimation.cupertino);
                    },
                leading: Icon(Icons.person),
                title: Text('Username'),
                 value: Text('Cheif'),
              ),
              SettingsTile.navigation(
                onPressed: (value){
                  pushNewScreenWithRouteSettings(context,
                      settings: RouteSettings(name: UpdateProfile.routeName),
                      screen: UpdateProfile(
                          token: "widget.token",
                          parameter: "phone",
                          icon: Icons.phone,
                          keypadType: TextInputType.phone,),
                      withNavBar: false,
                      pageTransitionAnimation:
                      PageTransitionAnimation.cupertino);
                },
                leading: Icon(Icons.phone),
                title: Text('Phone Number'),
               // value: Text('English'),
              ),
              SettingsTile.navigation(
                onPressed: (value){
                  pushNewScreenWithRouteSettings(context,
                      settings: RouteSettings(name: UpdateProfile.routeName),
                      screen: UpdateProfile(
                          token: "widget.token",
                          parameter: "pin",
                          icon: Icons.lock,
                          keypadType: TextInputType.number,),
                      withNavBar: false,
                      pageTransitionAnimation:
                      PageTransitionAnimation.cupertino);
                },
                leading: Icon(Icons.password_sharp),
                title: Text('Transaction Pin'),
                // value: Text('English'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Security'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    finStatus=!finStatus;

                  });
                },
                initialValue: finStatus,
                leading: Icon(Icons.fingerprint_outlined),
                title: Text('Use Fingerprint'),
                description: Text('Allow app to access stored finger Ids'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                // value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    notiStatus=!notiStatus;
                  });
                },
                initialValue: notiStatus,
                leading: Icon(Icons.notifications_active),
                title: Text('Enable Notifications'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: Text('SignOut'),
                // value: Text('English'),
              ),
            ],
          ),
        ],
        darkTheme: SettingsThemeData()
        ),
      );
  }
}
