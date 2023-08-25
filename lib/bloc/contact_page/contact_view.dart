import 'dart:typed_data';

import 'package:bwy/constants/constants.dart';
import 'package:bwy/extension/string_extension.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:bwy/widget/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:ui' as ui;

import '../../lang/locale_keys.g.dart';
import '../../size_config.dart';
import '../../utils/box_constants.dart';
import '../../widget/box.dart';
import '../../widget/fabs.dart';
import '../home_page/home_view.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  LatLng currentLocation = const LatLng(40.207705891352155, 28.990919780777475);
  // BitmapDescriptor bwyIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  int _selectedIndex = Pages.CONTACTUS.index;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static List<Widget> _widgetOptions = <Widget>[
    Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  ];
  @override
  void initState() {
    // addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.contact_appBarTitle.locale,
            style: TextStyle(
                fontFamily: 'REM',
                color: Colors.white,
                fontSize: SizeConfig.defaultSize! * 2.4,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Stack(
        children: [
          // Positioned(right: 0, bottom: 0, child: FABs.buildMessageFab(context)),
          Positioned(right: 0, bottom: 0, child: FABs.buildCallFab(context)),
        ],
      ),
      body: _buildBody(context), // single child scroll view was wrapping
      bottomNavigationBar: _bottomNavigationBar(context),
    ));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),

          _headerContainer(),
          Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
          // Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20),
          //     child: Text('İletişim Bilgilerim',
          //         style: TextStyle(
          //             color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold))),
          Expanded(child: _googleMapsContainer()),
        ],
      ),
    );
  }

  Widget _googleMapsContainer() {
    return MyContainer(
      backgroundColor: Color(0xffF8F9FA),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 17,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          addMarker('primary', currentLocation);
        },
        markers: _markers.values.toSet(),
        myLocationButtonEnabled: false,
      ),
    );
  }

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  // }

  // Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
  //   final Uint8List imageData = await getBytesFromAsset(path, width);
  //   return BitmapDescriptor.fromBytes(imageData);
  // }

  // Future<void> addCustomIcon() async {
  //   final icon = await getBitmapDescriptorFromAssetBytes("assets/images/bwy_logo.png", 70);
  //   setState(() {
  //     bwyIcon = icon;
  //   });
  // }

  addMarker(String id, LatLng location) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        // icon: bwyIcon,
        infoWindow: const InfoWindow(title: 'Bursa Web Yazılım', snippet: 'Konum Gösteriliyor'));
    _markers[id] = marker;
    setState(() {});
  }

  Widget _headerContainer() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset('assets/images/bwy_header_contact_us1.png', height: 270, fit: BoxFit.fitHeight),
        ),
        Positioned(
          top: 24,
          left: 24,
          child: Container(width: 280, child: Text('+90 224 408 38 48', style: CustomTextStyles().titleTextStyle())),
        ),
        Positioned(
          left: 24,
          top: 80,
          child: Container(
              width: 280, child: Text('info@\nbursawebyazilim.com', style: CustomTextStyles().titleTextStyle())),
        ),
        Positioned(
          left: 24,
          bottom: 24,
          child: Container(width: 280, child: Text(officeAddress, style: CustomTextStyles().titleTextStyle())),
        ),
      ],
    );
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.white.withOpacity(.1), // beyaza cevir
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: const Color(0xff222023),
            color: Colors.grey,
            tabs: [
              GButton(
                icon: Icons.dashboard_outlined,
                text: LocaleKeys.home_appBarTitle.locale,
              ),
              GButton(
                icon: Icons.computer_outlined,
                text: LocaleKeys.about_us_appBarTitle.locale,
              ),
              GButton(
                icon: Icons.phone_outlined,
                text: LocaleKeys.contact_appBarTitle.locale,
              ),
              GButton(
                icon: Icons.person_outline,
                text: LocaleKeys.profile_appBarTitle.locale,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/home');
                case 1:
                  Navigator.pushNamed(context, '/bwy', arguments: -1);
                case 2:
                  Navigator.pushNamed(context, '/contact');
                case 3:
                  Navigator.pushNamed(context, '/profile');
              }
            },
          ),
        ),
      ),
    );
  }
}
