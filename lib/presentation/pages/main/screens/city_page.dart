// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/button_widget.dart';

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
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(219, 165, 129, 123), Color(0xFF6C63FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Constants.borderRadiusCircular),
                bottomRight: Radius.circular(Constants.borderRadiusCircular),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    SizedBox(width: Gaps.medium),
                    Text(
                      text.txtChooseYourCity,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Gaps.large),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search city...',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.borderRadiusCircular,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Gaps.large,
                      horizontal: Gaps.large,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Gaps.large),
          Expanded(
            child: filteredCities.isEmpty
                ? Center(
                    child: Text(
                      text.txtNoCitiesFound,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: Gaps.large),
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;

                      return Container(
                        margin: EdgeInsets.only(bottom: Gaps.medium),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEAF2FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            Constants.borderRadiusCircular,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? const Color.fromARGB(255, 156, 172, 189)
                                : Colors.grey.shade200,
                            width: isSelected ? 1.4 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: Constants.borderRadiusCircular,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Gaps.large,
                            vertical: Gaps.medium,
                          ),
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: isSelected
                                ? Color.fromARGB(219, 165, 129, 123)
                                : Colors.grey.shade100,
                            child: Icon(
                              Icons.location_on_outlined,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                          ),
                          title: Text(
                            filteredCities[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4A90E2),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
          ),
          ButtonWidget(
            backgroundColor: Color.fromARGB(219, 167, 164, 169),
            title: text.btnNext,
            onPressed: () {
              if (selectedIndex != null) {
                final selectedCity = filteredCities[selectedIndex!];

                final authState = context.read<AuthCubit>().state;
                if (authState.user != null) {
                  final currentUser = authState.user;
                  final updatedUser = currentUser?.copyWith(
                    userCity: selectedCity,
                  );
                  context.read<AuthCubit>().updateUser(updatedUser!);
                }

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomePage()),
                // );
                context.push(RouteConstants.homePage);
              }
            },
          ),
        ],
      ),
    );
  }
}
