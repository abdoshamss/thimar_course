import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import 'package:thimar_course/features/auth/resend_code/bloc.dart';
import 'package:thimar_course/features/categories/bloc.dart';
import 'package:thimar_course/features/category_product/bloc.dart';
import 'package:thimar_course/features/edit_profile/cubit.dart';
import 'package:thimar_course/features/notifications/bloc.dart';
import 'package:thimar_course/features/privacy/bloc.dart';
import 'package:thimar_course/features/about_app/bloc.dart';
import 'package:thimar_course/features/give_advices/bloc.dart';
import 'package:thimar_course/features/slider/bloc.dart';
import '../../features/FAVS/bloc.dart';
import '../../features/auth/activation/bloc.dart';
import '../../features/auth/check_code/bloc.dart';
import '../../features/auth/forget_password/bloc.dart';
import '../../features/auth/get_cities/bloc.dart';
import '../../features/auth/log_out/bloc.dart';
import '../../features/auth/login/bloc.dart';
import '../../features/auth/register/bloc.dart';
import '../../features/auth/reset_password/bloc.dart';
import '../../features/faqs/bloc.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerSingleton((container) => DioHelper());
  container.registerFactory((c) => LoginBLoc(c.resolve<DioHelper>()));
  container.registerFactory((c) => AboutAppBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => EditProfileCubit(c.resolve<DioHelper>()));
  container.registerFactory((c) => PrivacyBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => GiveAdviceBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => GetCitiesScreenBLoc(c.resolve<DioHelper>()));
  container.registerFactory((c) => RegisterBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => CategoriesBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ForgetPasswordBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ResetPasswordBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => CheckCodeBloc(c.resolve<DioHelper>()));

  container.registerFactory((c) => ActivationBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => FavsBloc(c.resolve<DioHelper>()));


  container.registerFactory((c) => ResendCodeBloc(c.resolve<DioHelper>()));
  container
      .registerFactory((c) => CategoryProductBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => SliderDataBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => NotificationsBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => LogOutBLoc(c.resolve<DioHelper>()));
  container.registerFactory((c) => FAQSBloc(c.resolve<DioHelper>()));
}
