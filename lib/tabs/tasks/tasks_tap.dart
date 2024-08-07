import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';


import '../../auth/user_provider.dart';
import '../../theme.dart';
import 'task_item.dart';
import 'tasks_provider.dart';

class TasksTap extends StatelessWidget {
  const TasksTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).currentUser!.id;
    final tasksProvider = Provider.of<TasksProvider>(context)..getTasks(userId);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    // tasksProvider.getTasks();

    return Column(
      children: [
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            bottomSheetBackColor: settingsProvider.themeMode == ThemeMode.dark
                ? AppTheme.black
                : AppTheme.white,
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              compactMode: true,
              weekDaySelectedColor: Theme.of(context).primaryColor,
              selectedBackgroundColor: Theme.of(context).primaryColor,
              disableDaysBeforeNow: false),
          headerOptions: HeaderOptions(
            resetDateColor: settingsProvider.themeMode == ThemeMode.dark
                ? AppTheme.black
                : AppTheme.white,
            navigationColor: settingsProvider.themeMode == ThemeMode.dark
                ? AppTheme.black
                : AppTheme.white,
            calendarIconColor: settingsProvider.themeMode == ThemeMode.dark
                ? AppTheme.black
                : AppTheme.white,
            weekDayStringType: WeekDayStringTypes.SHORT,
            monthStringType: MonthStringTypes.FULL,
            backgroundColor: Theme.of(context).primaryColor,
            headerTextColor: settingsProvider.themeMode == ThemeMode.dark
                ? AppTheme.black
                : AppTheme.white,
          ),
          dateTime: CalendarDateTime(
              year: tasksProvider.selectedDate.year,
              month: tasksProvider.selectedDate.month,
              day: tasksProvider.selectedDate.day),
          onChangeDateTime: (calenderDatetime) {
            tasksProvider.changeSelctedDate(
                userId, calenderDatetime.toDateTime());
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return TaskItem(
                taskModel: tasksProvider.tasks[index],
              );
            }),
            itemCount: tasksProvider.tasks.length,
          ),
        )
      ],
    );
  }
}
