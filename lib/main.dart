import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopack_user/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shopack_user/features/cart/presentation/bloc/cubit/address_cubit.dart';
import 'package:shopack_user/features/cart/presentation/bloc/location_bloc.dart';
import 'core/local/shared_preference.dart';
import 'core/theme/theme_data.dart';
import 'dependancy_injection.dart';
import 'features/cart/data/datasource/local_datasource.dart';
import 'features/favorite/presentation/bloc/favourite_bloc.dart';
import 'features/home/presentation/bloc/BottomNavigationBar_bloc.dart';
import 'features/profile/data/datasources/profile_local_datasource.dart';
import 'features/profile/presentation/bloc/update_password_bloc.dart';
import 'features/setpassword/presentation/bloc/reset_password_bloc.dart';
import 'features/shop/presentation/bloc/products_bloc.dart';
import 'features/shop/presentation/bloc/send_review_bloc.dart';
import 'core/utilities/router.dart';
import 'core/utilities/routes.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'features/forgotpass&verifyemail/presentation/forgotpass&verifyemail_bloc/forgotpass&verifyemail_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await PreferenceHelper.init();
final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  await CacheManager().init();
  await CartLocalDataSourceManager().init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<RegisterBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ForgetpasswordAndeVerifyEmailBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ResetPasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<BottomNavigationBarBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ProductsBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<UpdatePasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<SendReviewBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<FavouriteBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<LocationBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<AddressCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        onGenerateRoute: onGenerate,
        initialRoute: AppRoutes.login,
      ),
    );
  }
}
