import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_snackbar.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/features/assignment/providers/addAssignmentproviders.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';
import 'package:provider/provider.dart';

class GetAssignmentPage extends StatefulWidget {
  const GetAssignmentPage({super.key});

  @override
  State<GetAssignmentPage> createState() => _GetAssignmentPageState();
}

class _GetAssignmentPageState extends State<GetAssignmentPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider =
          Provider.of<AddAssignmentProvider>(context, listen: false);
      provider.assignmentList = [];
      provider.getAssignment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AddAssignmentProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                CustomButton(
                  child: const Text("Add Assignment"),
                  onPressed: () {
                    RouteGenerator.navigateToPage(
                        context, Routes.addAssignmentRoute);
                  },
                ),

                
                const SizedBox(height: 10),

                 Padding(
                  padding:  EdgeInsets.all(12.0),
                  child: CustomTextformfield(
                    hintText: "Search",
                    onChanged: (value) {
                      provider.searchAssignments(value);
                    },
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                if (provider.getAssignmentStatus == StatusUtils.loading)
                  const Center(
                      child: CircularProgressIndicator(color: Colors.blue))
                else if (provider.getAssignmentStatus == StatusUtils.success &&
                    provider.assignmentList.isNotEmpty)
                  Expanded(
                  child: ListView.builder(
                      itemCount: provider.assignmentList.length,
                      itemBuilder: (context, index) {
                        final assignment = provider.assignmentList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Id: ${assignment.id}"),
                                      Text(
                                          "Subject Name: ${assignment.subjectName}"),
                                      Text("Semester: ${assignment.semester}"),
                                      Text("Faculty: ${assignment.faculty}"),
                                      Text("Title: ${assignment.title}"),
                                      Text(
                                        "Description: ${assignment.description}",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        print("pressed");
                                        RouteGenerator.navigateToPage(
                                            context, Routes.addAssignmentRoute,
                                            arguments: assignment);
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await provider.deleteAssignment(
                                            assignment.id ?? 0);

                                        final isSuccess =
                                            provider.deleteAssignmentStatus ==
                                                StatusUtils.success;

                                        CustomSnackBar.show(
                                          context,
                                          message: isSuccess
                                              ? "Assignment deleted successfully!"
                                              : "Deletion failed. Please try again.",
                                          type: isSuccess
                                              ? SnackBarType.success
                                              : SnackBarType.error,
                                        );

                                        if (isSuccess) {
                                          RouteGenerator
                                              .navigateToPageWithoutStack(
                                                  context,
                                                  Routes.getAssignmentRoute);
                                        }
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else if (provider.getAssignmentStatus == StatusUtils.success &&
                    provider.assignmentList.isEmpty)
                  const Expanded(
                      child: Center(child: Text("No assignments found")))
                else
                  const Expanded(
                      child: Center(child: Text("Failed to load data")))
              ],
            );
          },
        ),
      ),
    );
  }
}
