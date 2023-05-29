library the_quote_localization;

import 'package:easy_localization/easy_localization.dart';

export 'package:easy_localization/easy_localization.dart';

export './src/core/locale_keys.g.dart';
export './src/core/supported_locales.dart';
export './src/widgets/localization_wrapper.dart';

class TheQuoteLocalization {
  static Future<void> ensureInitialized() async {
    await EasyLocalization.ensureInitialized();
  }
}
