import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../utils/navigation_helper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("SSKRU ComSci.co"),
            accountEmail: Text("phisan.s@sskru.ac.th"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40, color: Colors.white),
              backgroundColor: Colors.blueAccent,
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent, // เปลี่ยนเป็นสีพื้นหลังสวยงาม
            ),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.star, color: Colors.amber),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.favorite, color: Colors.pink),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text("About"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.grid_3x3_outlined),
            title: Text("Products"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Contact"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              AuthController authController = AuthController();
              authController.logout();

              NavigationHelper.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
