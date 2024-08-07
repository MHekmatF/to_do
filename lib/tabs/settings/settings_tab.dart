import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/tabs/settings/model/mood.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';

import '../../theme.dart';
import 'model/languages.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({super.key});

  final List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'العربية', code: 'ar'),
  ];
  final List<Mood> mood=[
    Mood(name: "Light", themeMode: ThemeMode.light),
    Mood(name: "Dark", themeMode: ThemeMode.dark),
  ];

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.h),
      child: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.language,

                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: settingsProvider
                      .themeMode == ThemeMode.dark ?AppTheme.white:AppTheme.black)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primary,width: 2.h),
                  color: settingsProvider.themeMode == ThemeMode.light
                      ? Colors.white
                      : AppTheme.black,
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<Languages>(
                        value: languages.firstWhere(
                              (lang) => lang.code == settingsProvider.languageCode,
                        ),
                        items: languages
                            .map(
                              (language) => DropdownMenuItem<Languages>(
                            value: language,
                            child: Text(language.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primary)),
                          ),
                        )
                            .toList(),
                        onChanged: (selectedLanguage) {
                          if (selectedLanguage != null) {
                            settingsProvider
                                .changeLanguage(selectedLanguage.code);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppTheme.primary,
                          size: 50,
                        ),
                        dropdownColor:
                        settingsProvider.themeMode == ThemeMode.dark
                            ? AppTheme.black
                            : AppTheme.white)),
              )
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.mood,

                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: settingsProvider
                      .themeMode == ThemeMode.dark ?AppTheme.white:AppTheme.black)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primary,width: 2.h),
                  color: settingsProvider.themeMode == ThemeMode.light
                      ? Colors.white
                      : AppTheme.black,
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<Mood>(
                        value: mood.firstWhere(
                              (mood) => mood.themeMode == settingsProvider.themeMode,
                        ),
                        items: mood
                            .map(
                              (mood) => DropdownMenuItem<Mood>(
                            value: mood,
                            child: Text(mood.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primary)),
                          ),
                        )
                            .toList(),
                        onChanged: (selectedMood) {
                          if (selectedMood != null) {
                            settingsProvider
                                .changeTheme(selectedMood.themeMode);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppTheme.primary,
                          size: 50,
                        ),
                        dropdownColor:
                        settingsProvider.themeMode == ThemeMode.dark
                            ? AppTheme.black
                            : AppTheme.white)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
