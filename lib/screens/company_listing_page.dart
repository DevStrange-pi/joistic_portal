import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_portal/services/storage_service.dart';
import 'dart:math' as math;

import '../controllers/auth_controller.dart';
import '../controllers/company_controller.dart';
import '../models/company.dart';

class CompanyListingPage extends StatelessWidget {
  final CompanyController _companyController = Get.find<CompanyController>();
  final GlobalKey<ScaffoldState> scaffoldRiKey1 = GlobalKey<ScaffoldState>();
  final double generalPadding = 22.0;
  final Color primaryBackground = const Color.fromARGB(255, 241, 239, 239);
  CompanyListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: _companyController.popDisableEnableLogic,
        onPopInvokedWithResult: (popAllowed, result) {
          if (!popAllowed) {
            _companyController.onBackPressed(popAllowed);
          }
          print("popAllowed: $popAllowed");
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: primaryBackground,
                key: scaffoldRiKey1,
                // appBar: AppBar(
                //   title: const Text(''),
                //   actions: [
                //     Material(
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.search,
                //           weight: 40,
                //           color: Colors.black,
                //         ),
                //         onPressed: () {
                //           // open the search textfield
                //           _companyController.toggleSearch();
                //         },
                //       ),
                //     )
                //   ],
                //   leading: Material(
                //     child: IconButton(
                //       icon: const Icon(Icons.menu),
                //       onPressed: () {
                //         _scaffoldKey.currentState?.openDrawer();
                //       },
                //     ),
                //   ),
                // ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Image.asset("assets/user.png"),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: () {
                          _companyController.userSignOut();
                        },
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(generalPadding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                              ),
                              onPressed: () {
                                scaffoldRiKey1.currentState?.openDrawer();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.search,
                                weight: 40,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // open the search textfield
                                _companyController.toggleSearch();
                              },
                            )
                          ],
                        ),
                        // Obx(() {
                        //   return
                        Visibility(
                          // maintainState: true,
                          // maintainAnimation: true,
                          replacement: const Padding(
                            padding: EdgeInsets.all(16),
                            child: const Text(
                              "Find your Dream Job today ",
                              style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          visible: _companyController.isSearchToggled.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              TextField(
                                decoration: const InputDecoration(
                                  filled: true,

                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(16),
                                  labelText: 'Search Companies',
                                  // prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                                ),
                                onChanged: (value) {
                                  _companyController.searchQuery.value = value;
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        // ;}),
                        Expanded(
                            child:
                                // Obx(() {
                                _companyController.isLoading.value
                                    ? const Center(child: CircularProgressIndicator())
                                    : _companyController.filteredCompanies.isEmpty
                                        ? const Center(child: Text('No companies found'))
                                        : ListView.separated(
                                            itemCount: _companyController.filteredCompanies.length,
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 20,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              Company company = _companyController.filteredCompanies[index];
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                                ),
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(horizontal: generalPadding, vertical: 14),
                                                  minVerticalPadding: 16,
                                                  leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(company.url),
                                                  ),
                                                  trailing: Tooltip(
                                                    // key: StorageService.tooltipRiKey2,
                                                    triggerMode: TooltipTriggerMode.tap,
                                                    showDuration: const Duration(seconds: 2),
                                                    message: company.isApplied ? 'Already Applied' : '',
                                                    textStyle: const TextStyle(color: Colors.white),
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.width / 3,
                                                        right: generalPadding),
                                                    child: CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor: company.isApplied
                                                          ? Colors.green
                                                          : Theme.of(context).primaryColor,
                                                      child: const Icon(
                                                        Icons.square,
                                                        color: Colors.white,
                                                        size: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  title: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      company.title,
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    company.desc,
                                                    maxLines: 1,
                                                  ),
                                                  onTap: () {
                                                    Get.bottomSheet(
                                                      CompanyDetailBottomSheet(company: company),
                                                      isScrollControlled: true,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          )

                            // }),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_companyController.isLoading.value)
                const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
              if (_companyController.isLoading.value)
                Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class CompanyDetailBottomSheet extends StatelessWidget {
  final Company company;
  final CompanyController _companyController = Get.find<CompanyController>();

  CompanyDetailBottomSheet({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = MediaQuery.of(context).size.width / 7;

    return Container(
      height: MediaQuery.of(context).size.height / 1.61,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 8,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width / 7,
              backgroundColor: Colors.white,
              // child: CircleAvatar(
              //   radius: MediaQuery.of(context).size.width / 7 - 15,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 8),
              //     child: Image.network(company.thumbnailUrl),
              //   ),
              // ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height / 1.61) - (MediaQuery.of(context).size.height / 1.8)),
            padding: EdgeInsets.fromLTRB(32, MediaQuery.of(context).size.width / 6, 32, 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            height: MediaQuery.of(context).size.height / 1.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Image.network(company.thumbnailUrl),
                // const SizedBox(height: 10),
                Text(
                  company.desc,
                ),
                const Spacer(),
                Center(
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
                      ),
                      onPressed: company.isApplied
                          ? null
                          : () {
                              _companyController.applyToCompany(company);
                            },
                      child: const Text('APPLY  NOW'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 8,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width / 7,
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 7 - 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 8),
                  child: Image.network(
                    company.url,
                    height: 150,
                    width: 100,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
