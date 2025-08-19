import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_dropdown.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_snackbar.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/features/assignment/model/assignment.dart';
import 'package:project_1/features/assignment/providers/addAssignmentproviders.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';
import 'package:provider/provider.dart';


class AssignmentPage extends StatefulWidget {
  AssignmentPage({super.key, this.assignment});
  Assignment? assignment;

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider =
          Provider.of<AddAssignmentProvider>(context, listen: false);
           provider.clear();
      if (widget.assignment != null) {
        provider.setValue(widget.assignment!);
      }
    });
  }

  // @override
  // void dispose() {
  //   Provider.of<AddAssignmentProvider>(context, listen: false)
  //       .titleController
  //       .dispose();
  //   Provider.of<AddAssignmentProvider>(context, listen: false)
  //       .descriptionController
  //       .dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assignment Submission",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Consumer<AddAssignmentProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomDropDown(
                  labelText: "Subject Name",
                  items: provider.subjectList,
                  value: provider.selectedSubject,
                  validator: (val) => val == null ? subValidationStr : null,
                  onChanged: (val) => provider.setSelectedSubject(val),
                ),
                const SizedBox(height: 16),
                CustomDropDown(
                  labelText: "Semester",
                  items: provider.semesterList,
                  value: provider.selectedSemester,
                  validator: (val) => val == null ? semValidationStr : null,
                  onChanged: (val) => provider.setSelectedSemester(val),
                ),
                const SizedBox(height: 16),
                CustomDropDown(
                  labelText: "Faculty",
                  items: provider.facultyList,
                  value: provider.selectedFaculty,
                  validator: (val) => val == null ? facultyValidationStr : null,
                  onChanged: (val) => provider.setSelectedFaculty(val),
                ),
                const SizedBox(height: 16),
                CustomTextformfield(
                  labelText: titlestr,
                  controller: provider.titleController,
                  validator: (val) =>
                      val == null || val.isEmpty ? titleValidationStr : null,
                ),
                const SizedBox(height: 16),
                CustomTextformfield(
                  labelText: descriptionstr,
                  controller: provider.descriptionController,
                  validator: (val) =>
                      val == null || val.isEmpty ? desValidationStr : null,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (widget.assignment != null &&
                          widget.assignment?.id != null) {
                        await provider.updateAssignment();
                      } else {
                        await provider.submitAssignment();
                      }
                      if (provider.addAssignmentStatus == StatusUtils.success) {
                        RouteGenerator.navigateToPage(
                            context, Routes.getAssignmentRoute);
                        CustomSnackBar.show(
                          context,
                          message: "Successfully to submit assignment",
                          type: SnackBarType.error,
                        );
                      } else if (provider.addAssignmentStatus ==
                          StatusUtils.error) {
                        CustomSnackBar.show(
                          context,
                          message: "Failed to submit assignment",
                          type: SnackBarType.error,
                        );
                      }
                    }
                  },
                  backgroundColor: Colors.blue,
                  child: provider.addAssignmentStatus == StatusUtils.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.assignment?.id != null ? "Update" : "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
