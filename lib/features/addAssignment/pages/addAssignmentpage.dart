import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/features/addAssignment/providers/addAssignmentproviders.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';
import 'package:project_1/custom_widgets/custom_dropdown.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/core/uitils/status_utils.dart';

class AddAssignmentPage extends StatelessWidget {
  const AddAssignmentPage({super.key});

  void handleSubmit(BuildContext context) async {
    final provider = Provider.of<AddAssignmentProvider>(context, listen: false);

    await provider.submitAssignment();

    if (provider.submitStatus == StatusUtils.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Assignment submitted successfully")),
      );
      // Navigate or clear form if needed
    } else if (provider.submitStatus == StatusUtils.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Submission failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            RouteGenerator.navigateToPageWithoutStack(
              context,
              Routes.dashboardRoute,
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: whiteColor),
        ),
        title: const Text("Add Assignment", style: TextStyle(color: whiteColor)),
        centerTitle: true,
      ),
      body: Consumer<AddAssignmentProvider>(
        builder: (context, provider, child) => 
       SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                CustomTextformfield(
                  labelText: subjectNameStr,
                  suffixIcon: const Icon(Icons.book),
                  controller: provider.subjectNameController,
                  validator: (value) =>
                      value == null || value.isEmpty ? SubjectValidatorStr : null,
                ),
                CustomDropdown(
                  dropDownItemList: provider.facultyOptions,
                  labelText: facultyStr,
                  suffixIcon: const Icon(Icons.school),
                  value: provider.selectedFaculty,
                  onChanged: (value) {
                    provider.selectedFaculty = value!;
                    provider.notifyListeners();
                  },
                  validator: (value) => value == null ? facultyvalidatorStr : null,
                ),
                CustomDropdown(
                  dropDownItemList: provider.semesterOptions,
                  labelText: SemesterStr,
                  suffixIcon: const Icon(Icons.calendar_today),
                  value: provider.selectedSemester,
                  onChanged: (value) {
                    provider.selectedSemester = value!;
                    provider.notifyListeners();
                  },
                  validator: (value) => value == null ? semestervalidatorStr : null,
                ),
                CustomTextformfield(
                  labelText: titleStr,
                  suffixIcon: const Icon(Icons.title),
                  controller: provider.titleController,
                  validator: (value) =>
                      value == null || value.isEmpty ? titlevalidatorStr : null,
                ),
                CustomTextformfield(
                  labelText: descriptionStr,
                  suffixIcon: const Icon(Icons.description),
                  controller: provider.descriptionController,
                  validator: (value) =>
                      value == null || value.isEmpty ? descriptionvalStr : null,
                ),
                const SizedBox(height: 20),
                provider.submitStatus == StatusUtils.loading
                    ? const CircularProgressIndicator()
                    : CustomElevatedbutton(
                        onPressed: () => handleSubmit(context),
                        child: const Text("Submit"),
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
