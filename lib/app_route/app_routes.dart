part of 'app_pages.dart';

abstract class Routes{
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const RESETPASSWORD = _Paths.RESETPASSWORD;
  static const HOME = _Paths.HOME;
  static const PUSHUPVIEW = _Paths.PUSHUPVIEW;
  static const REPS = _Paths.REPS;
  static const REPSWEIGHT = _Paths.REPSWEIGHT;
  static const PROGRESSCATEGORY = _Paths.PROGRESSCATEGORY;
  static const PROGRESSDETAILSPAGE = _Paths.PROGRESSDETAILSPAGE;

}

abstract class _Paths{
  static const SPLASH = '/splash';
  static const LOGIN = '/login-page';
  static const SIGNUP = '/signup-page';
  static const RESETPASSWORD = '/reset-password';
  static const HOME = '/home';
  static const PUSHUPVIEW = '/pushup-view';
  static const REPS = '/reps';
  static const REPSWEIGHT = '/reps-weight';
  static const PROGRESSCATEGORY = '/progress-category';
  static const PROGRESSDETAILSPAGE = '/progress-details';

}