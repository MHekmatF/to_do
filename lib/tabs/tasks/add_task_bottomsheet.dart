import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';

import '../../auth/user_provider.dart';
import '../../firebase_utils.dart';
import '../../models/task_model.dart';
import '../../theme.dart';
import 'default_elevated_button.dart';
import 'default_text_form_field.dart';
import 'tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selctedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final dateFormat = DateFormat('dd/ MM /yyyy');
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: settingsProvider.themeMode == ThemeMode.dark
          ? AppTheme.black
          : AppTheme.white,
      height: 450.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.addTask,
                style: textTheme.bodyMedium?.copyWith(
                  color: settingsProvider.themeMode == ThemeMode.dark
                      ? AppTheme.white
                      : Colors.black,
                ),
              ),
              DefaultTextFormField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return AppLocalizations.of(context)!.titleVal;
                    }
                    return null;
                  },
                  controller: titleController,
                  hintText: AppLocalizations.of(context)!.title),
              SizedBox(
                height: 16.h,
              ),
              DefaultTextFormField(
                  controller: descriptionController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return AppLocalizations.of(context)!.descriptionVal;
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.description,
                  maxLines: 5),
              SizedBox(
                height: 16.h,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                    AppLocalizations.of(context)!.date,
                  style: textTheme.bodyLarge!
                      .copyWith(color: AppTheme.white.withOpacity(0.5)),
                ),
              ),
              InkWell(
                child: Text(
                    // DateTime.now().toString().substring(0, 11),
                    dateFormat.format(selctedDate),
                    style: textTheme.bodySmall),
                onTap: () async {
                  final dateTime = await showDatePicker(
                      context: context,
                      initialDate: selctedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      initialEntryMode: DatePickerEntryMode.calendarOnly);
                  if (dateTime != null) {
                    selctedDate = dateTime;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              DefaultElevatedButton(
                onPress: addTask,
                child: Text(
                    AppLocalizations.of(context)!.add,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppTheme.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.addTaskToFirestore(
        TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          dateTime: selctedDate,
        ),
        userId,
      ).then(
        (_) {
          Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.of(context).pop();
        },
      ).catchError((_) {
        Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.of(context).pop();
      });
    }
  }
}
