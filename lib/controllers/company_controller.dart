import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/company.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class CompanyController extends GetxController {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  
  var companies = <Company>[].obs;
  var isLoading = true.obs;
  var isSearchToggled = false.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      List<Company> fetchedCompanies = await _apiService.fetchCompanies();
      List<int> appliedIds = await _storageService.getAppliedCompanies();
      for (var company in fetchedCompanies) {
        if (appliedIds.contains(company.id)) {
          company.isApplied = true;
        }
      }
      companies.assignAll(fetchedCompanies);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch companies');
    } finally {
      isLoading(false);
    }
  }

  void toggleSearch() {
    isSearchToggled.value = !isSearchToggled.value;
  }

  void onBackPressed(bool popAllowed) {
    if (isSearchToggled.value) {
      searchQuery.value = '';
      isSearchToggled.value = false;
    } else {
      Get.back();
    }
  }

  bool get popDisableEnableLogic {
    return !isSearchToggled.value;
  }

  List<Company> get filteredCompanies {
    if (searchQuery.value.isEmpty) {
      return companies;
    } else {
      return companies.where((c) => c.title.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }

  Future<void> applyToCompany(Company company) async {
    company.isApplied = true;
    companies.refresh();
    List<int> appliedIds = await _storageService.getAppliedCompanies();
    appliedIds.add(company.id);
    await _storageService.saveAppliedCompanies(appliedIds);
    Get.back();
    Get.snackbar('Success', 'Job Applied Successfully');
  }
}
