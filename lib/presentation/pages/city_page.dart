import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/button_widget.dart';
import 'package:news_watch_app/presentation/pages/main/home_page.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final TextEditingController _searchController = TextEditingController();
  int? selectedIndex;

  final List<String> cities = [
    "Yerevan",
    "Gyumri",
    "Ijevan",
    "Vanadzor",
    "Jermuk",
    "Kapan",
    "Meghri",
    "Hrazdan",
    "Sisian",
    "Ararat",
  ];
  List<String> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = List.from(cities);
    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        filteredCities = cities
            .where((city) => city.toLowerCase().startsWith(query))
            .toList();
        selectedIndex = null;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search city...',
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, authState) {
          // TODO: implement listener
        },
        builder: (context, authState) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        color: selectedIndex == index
                            ? const Color.fromARGB(255, 207, 220, 230)
                            : Colors.white,
                        child: ListTile(
                          leading: const Icon(Icons.near_me_outlined),
                          title: Text(filteredCities[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonWidget(
                  title: 'Next',
                  onPressed: () {
                    if (selectedIndex != null) {
                      final selectedCity = filteredCities[selectedIndex!];

                      final authState = context.read<AuthCubit>().state;
                      if (authState is UserLoaded) {
                        final currentUser = authState.user;

                        final updatedUser = currentUser.copyWith(
                          userCity: selectedCity,
                        );
                        context.read<AuthCubit>().updateUser(updatedUser);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
