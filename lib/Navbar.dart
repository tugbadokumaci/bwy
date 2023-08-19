import 'package:bwy/shared_preferences_service.dart';
import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/utils/constants.dart';
import 'package:bwy/utils/custom_colors.dart';
import 'package:bwy/widget/box.dart';
import 'package:bwy/widget/circle_avatar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final navbarWidth = MediaQuery.of(context).size.width * 0.8;

    return Container(
      width: navbarWidth,
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            // height: 230, // For settting drawer height
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Hesap bilgileri',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close, color: Colors.white)),
                    ],
                  ),
                  CircleAvatar(
                    child: Image.asset('assets/images/default_person.png'),
                    radius: 25,
                  ),
                  const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),

                  Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text('${Constants.USER.following.length} Takip Edilen',
                  //         style: Theme.of(context).textTheme.titleMedium),
                  //     const SizedBox(width: 10),
                  //     Text('${Constants.USER.followers.length} Takipçi',
                  //         style: Theme.of(context).textTheme.titleMedium),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Benim Sayfam', style: Theme.of(context).textTheme.titleMedium),
            leading: const Icon(Icons.person_outlined, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home', arguments: Constants.USER.userId);
            },
          ),
          ListTile(
            title: Text('Ödemelerim', style: Theme.of(context).textTheme.titleMedium),
            leading: const Icon(Icons.wallet_outlined, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Hesap Ayarlarım', style: Theme.of(context).textTheme.titleMedium),
            leading: const Icon(Icons.settings, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('İletişim', style: Theme.of(context).textTheme.titleMedium),
            leading: const Icon(Icons.phone_outlined, color: Colors.white),
            onTap: () {
              // Navigator.pushReplacementNamed(context, )
              Navigator.pop(context);
            },
          ),
          Divider(color: CustomColors.lightGray),
          const ExpansionTile(
            title: Text(
              'Bursa Web Yazılım',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  'İstatistikler',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          const ExpansionTile(
            title: Text(
              'Hizmetlerimiz',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  'İstatistikler',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              'Blog',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Çıkış yap',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  SharedPreferencesService.clearLocalStorage();
                  Navigator.pushReplacementNamed(context, '/welcome');
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
