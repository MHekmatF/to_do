import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';
import 'package:to_do/tabs/tasks/default_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../auth/user_provider.dart';
import '../../theme.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen({super.key});

  static String routeName = '/edit';

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final dateFormat = DateFormat('dd/ MM /yyyy');
  late DateTime selctedDate;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    TaskModel task = ModalRoute.of(context)?.settings.arguments as TaskModel;
    if (first) {
      titleController.text = task.title;
      descriptionController.text = task.description;
      selctedDate = task.dateTime;
      first = false;
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 160.h,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: settingsProvider.themeMode == ThemeMode.dark
                          ? AppTheme.black
                          : AppTheme.white,
                    ),
                    Text(
                        AppLocalizations.of(context)!.todoList,
                      style: TextStyle(
                          color: settingsProvider.themeMode == ThemeMode.dark
                              ? AppTheme.black
                              : AppTheme.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    )
                  ],
                ),
                Expanded(
                  child: ListView(children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          vertical: 50.h, horizontal: 30.w),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                          color: settingsProvider.themeMode == ThemeMode.dark
                              ? AppTheme.black
                              : AppTheme.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Text(
                          AppLocalizations.of(context)!.editTask,
                            style: TextStyle(
                              color:
                                  settingsProvider.themeMode == ThemeMode.dark
                                      ? AppTheme.white
                                      : AppTheme.black,
                            ),
                          ),
                           SizedBox(
                            height: 30.h,
                          ),
                          DefaultTextFormField(  validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return AppLocalizations.of(context)!.titleVal;
                            }
                            return null;
                          },
                            controller: titleController,
                            hintText: AppLocalizations.of(context)!.title,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DefaultTextFormField(
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return AppLocalizations.of(context)!.descriptionVal;
                              }
                              return null;
                            },
                            controller: descriptionController,
                            hintText: AppLocalizations.of(context)!.description,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(AppLocalizations.of(context)!.date,
                                style: TextStyle(
                                  color:
                                      settingsProvider.themeMode == ThemeMode.dark
                                          ? AppTheme.white
                                          : AppTheme.black,
                                ),textAlign: TextAlign.end,),
                          ),
                          SizedBox(height: 15.h,),
                          InkWell(
                            child: Text(
                                // DateTime.now().toString().substring(0, 11),
                                dateFormat.format(
                                  selctedDate,
                                ),
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: settingsProvider.themeMode ==
                                          ThemeMode.dark
                                      ? AppTheme.white
                                      : AppTheme.black,
                                )),
                            onTap: () async {
                              final dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: selctedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly);
                              if (dateTime != null) {
                                selctedDate = dateTime;
                                setState(() {});
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 200.h,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              TaskModel newTask = TaskModel(
                                  id: task.id,
                                  isDone: task.isDone,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  dateTime: selctedDate);
                              FirebaseUtils.editTaskFirestore(
                                  newTask, userProvider.currentUser!.id);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            child:  Text(
                              AppLocalizations.of(context)!.save,
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
