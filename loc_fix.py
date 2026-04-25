import re

path = 'lib/main.dart'
with open(path, 'r') as f:
    text = f.read()

# Dictionary of strings to translate. Note some are constants that might need to be dynamically wrapped 
# but the python regex will just replace 'Text('My String')' to 'Text(context.tr('My String'))'.
replacements = [
    "'Home'", "'Join'", "'Rank'", "'Friends'", "'Account'",
    "'Good evening,'", "'Zakaria'", "'17 day streak'",
    "'LIVE NOW'", "'students are studying right now'",
    "'+4.2K'", "'START STUDYING'", "'Choose your timer and get in the flow'",
    "'Join Live Sessions'", "'See all'", "'Morning Session'",
    "'Energy & Focus'", "'Evening Session'", "'Push Your Limits'",
    "'Night Session'", "'Deep Focus'", "'Today\\'s focus time'",
    "'Global total'", "'Your daily goal'", "'Your streak'",
    "'Keep it up! 🔥'", "'Leaderboard'", "'Coming soon'",
    "'Settings'", "'Arabic (RTL) / العربية'", "'Change language and direction'",
    "'12h 45m'", "'4h / 6h'", "'17 days'"
]

# Before we add tr, we need to inject the Tr class at the top of the file
tr_class = """
class AppTr {
  static final Map<String, Map<String, String>> _dict = {
    'ar': {
      'Home': 'الرئيسية',
      'Join': 'انضمام',
      'Rank': 'التصنيف',
      'Friends': 'الأصدقاء',
      'Account': 'الحساب',
      'Good evening,': 'مساء الخير،',
      'Zakaria': 'زكريا',
      '17 day streak': '17 يوم على التوالي',
      '17 days': '17 يوم',
      'LIVE NOW': 'مباشر الآن',
      'students are studying right now': 'طلاب يدرسون الآن',
      '+4.2K': '+4.2 ألف',
      'START STUDYING': 'ابدأ الدراسة',
      'Choose your timer and get in the flow': 'اختر المؤقت وادخل في جو الدراسة',
      'Join Live Sessions': 'انضم للجلسات المباشرة',
      'See all': 'عرض الكل',
      'Morning Session': 'الجلسة الصباحية',
      'Energy & Focus': 'طاقة وتركيز',
      'Evening Session': 'الجلسة المسائية',
      'Push Your Limits': 'تحدى قدراتك',
      'Night Session': 'الجلسة الليلية',
      'Deep Focus': 'تركيز عميق',
      'Today\\'s focus time': 'وقت التركيز اليوم',
      'Global total': 'المجموع الكلي',
      'Your daily goal': 'هدفك اليومي',
      'Your streak': 'أيامك المتتالية',
      'Keep it up! 🔥': 'استمر هكذا! 🔥',
      'Settings': 'الإعدادات',
      'Arabic (RTL) / العربية': 'Arabic (RTL) / العربية',
      'Change language and direction': 'تغيير اللغة والاتجاه',
      'Leaderboard': 'لوحة المتصدرين',
      'Join Live Sessions': 'انضم للجلسات المباشرة',
      'Coming soon': 'قريباً',
      '12h 45m': '12 س 45 د',
      '4h / 6h': '4 س / 6 س',
    }
  };

  static String tr(BuildContext context, String key) {
    if (AppLocale.notifier.value.languageCode == 'ar') {
      return _dict['ar']?[key] ?? key;
    }
    return key;
  }
}

extension TrExt on BuildContext {
  String tr(String key) => AppTr.tr(this, key);
}

class AppLocale {
  static final ValueNotifier<Locale> notifier = ValueNotifier(const Locale('en'));
}
"""

if 'class AppTr' not in text:
    # replace appLocaleNotifier with AppLocale.notifier globally
    text = text.replace('appLocaleNotifier', 'AppLocale.notifier')
    # add the TrExt
    text = text.replace("import 'package:flutter_localizations/flutter_localizations.dart';", 
                        "import 'package:flutter_localizations/flutter_localizations.dart';\n" + tr_class)
    # remove the old ValueNotifier
    text = text.replace("final ValueNotifier<Locale> AppLocale.notifier = ValueNotifier(const Locale('en'));\n", "")

# We need to replace all const constructors that are wrapping Text widgets we want to translate.
# easiest is to just remove const from those specific texts.
for k in replacements:
    # replace naked strings in Text widgets only
    text = text.replace(f"Text(\n                      {k}", f"Text(\n                      context.tr({k})")
    text = text.replace(f"Text({k}", f"Text(context.tr({k})")
    
# Remove 'const' before Text widgets we translated
# A naive but effective approach for formatting where 'const Text(context' exists
text = text.replace('const Text(context', 'Text(context')
text = text.replace('const Text(\n                      context', 'Text(\n                      context')

# For the BottomNav items
text = text.replace("item.label,", "context.tr(item.label),")

# For _StatItem, replace label, value, sublabel
text = text.replace("label,", "context.tr(label),")
text = text.replace("value,\n                      style:", "context.tr(value),\n                      style:")
text = text.replace("Text(\n                    sublabel,", "Text(\n                    context.tr(sublabel),")
text = text.replace("title: const Text(\n                        'Arabic", "title: Text(\n                        context.tr('Arabic")
text = text.replace("subtitle: Text(\n                        'Change language and direction',", "subtitle: Text(\n                        context.tr('Change language and direction'),")


with open(path, 'w') as f:
    f.write(text)

print("done")
