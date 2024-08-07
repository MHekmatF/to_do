import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';
import 'package:to_do/tabs/tasks/edit_item_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../auth/user_provider.dart';
import '../../firebase_utils.dart';
import '../../models/task_model.dart';
import '../../theme.dart';
import 'tasks_provider.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;

  /*to keep it statless*/
// late UserProvider userProvider;
  const TaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selctedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.6,
          children: [
            SlidableAction(
              onPressed: deleteTask,
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
              borderRadius:  BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r)),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditItemScreen.routeName,
                    arguments: widget.taskModel);
              },
              backgroundColor: AppTheme.green,
              foregroundColor: AppTheme.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Provider.of<SettingsProvider>(context).themeMode ==
                      ThemeMode.dark
                  ? AppTheme.black
                  : Colors.white,
              borderRadius: BorderRadius.circular(15.r)),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 50.h,
                color: widget.taskModel.isDone == true
                    ? AppTheme.green
                    : Theme.of(context).primaryColor,
                margin: const EdgeInsetsDirectional.only(end: 8),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskModel.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: widget.taskModel.isDone == true
                              ? AppTheme.green
                              : Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.taskModel.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {});
                  widget.taskModel.isDone = !widget.taskModel.isDone;
                  FirebaseUtils.editTaskFirestore(
                      widget.taskModel, userProvider.currentUser!.id);
                },
                child: Container(
                  height: 40,
                  width: 69,
                  decoration: BoxDecoration(
                    color: widget.taskModel.isDone == true
                        ? AppTheme.green
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.taskModel.isDone == true
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.done,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Image.asset("images/icon_check.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(BuildContext ctx) {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseUtils.deleteTaskFromFirestore(widget.taskModel.id, userId)
        .then((_) {
      Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
      Fluttertoast.showToast(
        msg: "Delete Success",
        toastLength: Toast.LENGTH_SHORT,
      );
    }).catchError((_) {
      Fluttertoast.showToast(
        msg: "Failed",
        toastLength: Toast.LENGTH_SHORT,
      );
    });
  }
}
