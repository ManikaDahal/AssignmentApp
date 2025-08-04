import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/features/getAssignment/providers/getAssignmentproviders.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAssignmentPage extends StatefulWidget {
  const GetAssignmentPage({super.key});

  @override
  State<GetAssignmentPage> createState() => _GetAssignmentPageState();
}

class _GetAssignmentPageState extends State<GetAssignmentPage> {
  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? "";

    if (token.isNotEmpty) {
      final provider = Provider.of<GetAssignmentProvider>(context, listen: false);
      await provider.getAssignments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            RouteGenerator.navigateToPageWithoutStack(context, Routes.dashboardRoute);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          color: whiteColor,
        ),
        title: const Text("Assignments", style: TextStyle(color: whiteColor)),
        backgroundColor: primaryColor,
      ),
      body: Consumer<GetAssignmentProvider>(
        builder: (context, provider, child) {
          // Handle loading state
          if (provider.getAssignmentStatus == StatusUtils.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (provider.getAssignmentStatus == StatusUtils.error) {
            return const Center(child: Text("Failed to load assignments."));
          }

          // Handle empty state
          if (provider.assignments.isEmpty) {
            return const Center(child: Text("No assignments found."));
          }

          // Display list if data is available
          return RefreshIndicator(
            onRefresh: _loadAssignments,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: provider.assignments.length,
              itemBuilder: (context, index) {
                final assignment = provider.assignments[index];
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(assignment['title'] ?? 'No Title'),
                    subtitle: Text(assignment['description'] ?? 'No Description'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(assignment['faculty'] ?? ''),
                        Text(assignment['semester'] ?? ''),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
