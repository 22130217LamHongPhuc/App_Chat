
import 'package:chat_app/core/routes/router_app_name.dart';

import 'package:chat_app/features/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:chat_app/features/conversation/presentation/pages/home_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login/sign_in_page.dart';
import '../../features/chat/presentation/blocs/chat_bloc.dart';
import '../../features/chat/presentation/blocs/chat_state.dart';
import '../../features/chat/presentation/pages/chat_page/chat_page.dart';
import '../../features/conversation/presentation/pages/group_page/add_group_page.dart';
import '../utils/util.dart';


final sl = GetIt.instance;
class RouterApp{
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey:rootNavigatorKey ,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: AppRouteInfor.homePath,
        name: AppRouteInfor.homeName,
        builder: (_,_)=> HomeMainPage()
      ),
      GoRoute(
          path: AppRouteInfor.chatPath,
          name: AppRouteInfor.chatName,

          builder: (context,router){
            final id = int.parse(router.pathParameters['id']!);
            final name = router.uri.queryParameters['name']!;
            final isGroup = router.uri.queryParameters['isGroup']! == 'true';
            final avatar = router.uri.queryParameters['avatar'];
            final  member = router.uri.queryParameters['member'] != null ? int.parse(router.uri.queryParameters['member']!) : null;
            final replyTo = int.parse(router.uri.queryParameters['replyTo'] ?? '0');
            print('id $id name $name isGroup $isGroup $avatar');

            return BlocProvider(
              create: (context) => sl<ChatBloc>(),
              child:  ChatPage(conversationId: id,name: name,isGroup:isGroup,
                  avatar: avatar,member: member,replyTo: replyTo)

            );
          }
      ),
      GoRoute(
          path: AppRouteInfor.signUpPath,
          name: AppRouteInfor.signUpName,
          builder: (_,_)=> SignUpPage()
      ),
      GoRoute(
          path: AppRouteInfor.loginPath,
          name: AppRouteInfor.loginName,
          builder: (_,_)=> LoginPage()
      ),
      GoRoute(
          path: AppRouteInfor.addGroupPath,
          name: AppRouteInfor.addGroupName,
          builder: (_,_)=> const AddGroupPage()
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = Util.userId != 0 && Util.token.isNotEmpty;
      final isOnLoginPage = state.matchedLocation == AppRouteInfor.loginPath || state.matchedLocation == AppRouteInfor.signUpPath;

      print('path ${state.matchedLocation }');
      print('isLoggedIn $isLoggedIn isOnLoginPage $isOnLoginPage');

      if (!isLoggedIn && !isOnLoginPage) {
        return AppRouteInfor.loginPath;
      }

      if (isLoggedIn && isOnLoginPage) {
        return AppRouteInfor.homePath;
      }

      return null;
    },
  );

}