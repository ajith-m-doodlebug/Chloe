import 'package:shared_preferences/shared_preferences.dart';

getLandingPage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String landingPage = preferences.getString("LandingPage") ?? 'Welcome';
  return landingPage;
}

setWelcomeLandingPage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("LandingPage", 'Welcome');
}

setHomeLandingPage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("LandingPage", 'Home');
}
