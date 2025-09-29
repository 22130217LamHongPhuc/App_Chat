import 'package:chat_app/features/conversation/domain/usecases/fetch_all_user_usecase.dart';
import 'package:chat_app/features/conversation/presentation/pages/home_page/home_page.dart';
import 'package:chat_app/features/friend/presentation/pages/friend_list_page.dart';
import 'package:flutter/material.dart';

import '../../data/data_sources/user_remote_data_source.dart';

import '../../domain/usecases/create_group_usecase.dart';
import '../../domain/usecases/fetch_avatar_usecase.dart';

import 'group_page/group_page.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  late final groupremoteDataSource;
  late final groupRepository;
  late final CreateGroupUseCase createGroupUseCase;
  late final FetchAllAvatarsUseCase fetchAllAvatarsUseCase;
  late final FetchAllUserUseCase fetchAllUsersUseCase;
  late final userRepository;
  late final UserRemoteDataSource userRemoteDataSource;

  int _currentIndex = 0;
  late final List<Widget> pages;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    pages = [
      HomePage(),
      GroupPage(),
      FriendListPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 👈 Cho hiệu ứng blur đẹp

      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0), // Khoảng cách dưới cùng
        child: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: const Color(0xFF18202D),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_sharp),
            label: 'Friends',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
