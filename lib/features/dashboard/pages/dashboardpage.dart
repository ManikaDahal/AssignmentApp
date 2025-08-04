import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/features/addAssignment/pages/addAssignmentpage.dart';
import 'package:project_1/features/getAssignment/pages/getAssignmentPage.dart'; // <-- Import GetAssignmentPage

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Assignment Dashboard",
          style: TextStyle(color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddAssignmentPage()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Assignment"),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GetAssignmentPage()),
                );
              },
              icon: const Icon(Icons.list),
              label: const Text("Get Assignments"),
            ),
          ],
        ),
      ),
    );
  }
}
