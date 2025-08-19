import 'package:flutter/material.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';
import 'package:provider/provider.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Username"),
              subtitle: const Text("puza@example.com"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
               
                },
              ),
            ),
            const Divider(),

            const SizedBox(height: 24),

            const Text(
              "Assignments",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            CustomButton(
              child: Text("Add assignmet"),
              
              onPressed: () {
               RouteGenerator.navigateToPage(context, Routes.addAssignmentRoute);
              },

            ),
            

            const SizedBox(height: 24),
            const Divider(),

            const Text(
              "App Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

           

            
          ],
        ),
      ),
    );
  }
}
