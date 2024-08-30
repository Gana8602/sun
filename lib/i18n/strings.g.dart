
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 310 (155.0 per locale)
 *
 * Built on 2022-04-15 at 19:31 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	ar, // 'ar'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		if (WidgetsBinding.instance != null) {
			// force rebuild if TranslationProvider is used
			_translationProviderKey.currentState?.setLocale(_currLocale);
		}

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _StringsEn _translationsEn = _StringsEn.build();
late _StringsAr _translationsAr = _StringsAr.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _translationsEn;
			case AppLocale.ar: return _translationsAr;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_StringsEn build() {
		switch (this) {
			case AppLocale.en: return _StringsEn.build();
			case AppLocale.ar: return _StringsAr.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.ar: return 'ar';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.ar: return const Locale.fromSubtags(languageCode: 'ar');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'ar': return AppLocale.ar;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _StringsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	// ignore: unused_field
	late final _StringsEn _root = this;

	// Translations
	String get appname => 'AudioBuzz';
	String get loadingapp => 'tuning in...';
	String get allitems => 'All Items';
	String get emptyplaylist => 'No Playlists Created';
	String get notsupported => 'Not Supported';
	String get cleanupresources => 'Cleaning up resources';
	String get grantstoragepermission => 'Please grant accessing storage permission to continue';
	String get sharefiletitle => 'Watch or Listen to ';
	String get sharefilebody => 'Via AudioBuzz App, Download now at ';
	String get sharetext => 'Enjoy unlimited Audio & Video streaming';
	String get sharetexthint => 'Download AudioBuzz, the music streaming platform that lets you listen to millions of music files from around the world. Download now at';
	String get home => 'Home';
	String get downloads => 'Search Downloads';
	String get albums => 'Albums';
	String get artists => 'Artists';
	String get radio => 'Radio Channels';
	String get hotandtrending => 'Trending';
	String get device => 'Device';
	String get audiotracks => 'Tracks';
	String get playlist => 'Playlists';
	String get bookmarks => 'Bookmarks';
	String get appinfo => 'App Info';
	String get genres => 'All Genres';
	String get genress => 'Genres';
	String get moods => 'Moods';
	String get settings => 'Settings';
	String get selectlanguage => 'Select Language';
	String get chooseapplanguage => 'Choose App Language';
	String get startsubscription => 'Unlock Premium Features';
	String get startsubscriptionhint => 'Unlock premium features to start your journey to a never-ending media streaming experience';
	String get suggestedforyou => 'Suggested for you';
	String get tracks => 'Tracks';
	String get livetvchannels => 'Live Channels';
	String get trendingvideos => 'Trending Videos';
	String get trendingaudios => 'Popular';
	String get trendingvideoshint => 'Popular Videos On AudioBuzz';
	String get trendingaudioshint => 'Popular Audios On AudioBuzz';
	String get newvideoshint => 'New Videos from all categories';
	String get newaudioshint => 'New Audios from all categories';
	String get bookmarksMedia => 'My Bookmarks';
	String get noitemstodisplay => 'No Items To Display';
	String get download => 'Download';
	String get addplaylist => 'Add to playlist';
	String get bookmark => 'Bookmark';
	String get unbookmark => 'UnBookmark';
	String get share => 'Share';
	String get deletemedia => 'Delete File';
	String get deletemediahint => 'Do you wish to delete this downloaded file? This action cannot be undone.';
	String get searchhint => 'Search Audios';
	String get performingsearch => 'Searching Audios';
	String get nosearchresult => 'No results Found';
	String get nosearchresulthint => 'Try input more general keyword';
	String get livetvPlaylists => 'Live Media Playlists';
	String get addtoplaylist => 'Add to playlist';
	String get newplaylist => 'New playlist';
	String get playlistitm => 'Playlist';
	String get mediaaddedtoplaylist => 'Media added to playlist.';
	String get mediaremovedfromplaylist => 'Media removed from playlist';
	String get clearplaylistmedias => 'Clear All Media';
	String get deletePlayList => 'Delete Playlist';
	String get clearplaylistmediashint => 'Go ahead and remove all media from this playlist?';
	String get deletePlayListhint => 'Go ahead and delete this playlist and clear all media?';
	String get comments => 'Comments';
	String get replies => 'Replies';
	String get reply => 'Reply';
	String get logintoaddcomment => 'Login to add a comment';
	String get logintoreply => 'Login to reply';
	String get writeamessage => 'Write a message...';
	String get nocomments => 'No Comments found \nclick to retry';
	String get errormakingcomments => 'Cannot process commenting at the moment..';
	String get errordeletingcomments => 'Cannot delete this comment at the moment..';
	String get erroreditingcomments => 'Cannot edit this comment at the moment..';
	String get errorloadingmorecomments => 'Cannot load more comments at the moment..';
	String get deletingcomment => 'Deleting comment';
	String get editingcomment => 'Editing comment';
	String get deletecommentalert => 'Delete Comment';
	String get editcommentalert => 'Edit Comment';
	String get deletecommentalerttext => 'Do you wish to delete this comment? This action cannot be undone';
	String get loadmore => 'load more';
	String get guestuser => 'Guest User';
	String get fullname => 'Full Name';
	String get emailaddress => 'Email Address';
	String get password => 'Password';
	String get repeatpassword => 'Repeat Password';
	String get register => 'Register';
	String get login => 'Login';
	String get logout => 'Logout';
	String get logoutfromapp => 'Logout from app?';
	String get logoutfromapphint => 'You wont be able to like or comment on articles and videos if you are not logged in.';
	String get gotologin => 'Go to Login';
	String get resetpassword => 'Reset Password';
	String get logintoaccount => 'Already have an account? Login';
	String get emptyfielderrorhint => 'You need to fill all the fields';
	String get invalidemailerrorhint => 'You need to enter a valid email address';
	String get passwordsdontmatch => 'Passwords dont match';
	String get processingpleasewait => 'Processing, Please wait...';
	String get createaccount => 'Create an account';
	String get forgotpassword => 'Forgot Password?';
	String get orloginwith => 'Or Login With';
	String get facebook => 'Facebook';
	String get google => 'Google';
	String get moreoptions => 'More Options';
	String get about => 'About Us';
	String get privacy => 'Privacy Policy';
	String get terms => 'App Terms';
	String get rate => 'Rate App';
	String get version => 'Version';
	String get pulluploadmore => 'pull up load';
	String get loadfailedretry => 'Load Failed!Click retry!';
	String get releaseloadmore => 'release to load more';
	String get nomoredata => 'No more Data';
	String get setupprefernces => 'Setup Your Preferences';
	String get receievepshnotifications => 'Recieve Notifications';
	String get nightmode => 'Night Mode';
	String get enablertl => 'Enable RTL';
	String get duration => 'Duration';
	String get ok => 'Ok';
	String get retry => 'RETRY';
	String get oops => 'Ooops!';
	String get save => 'Save';
	String get cancel => 'Cancel';
	String get error => 'Error';
	String get success => 'Success';
	String get skip => 'Skip';
	String get skiplogin => 'Skip Login';
	String get skipregister => 'Skip Registration';
	String get dataloaderror => 'Could not load requested data at the moment, check your data connection and click to retry.';
	String get errorReportingComment => 'Error Reporting Comment';
	String get reportingComment => 'Reporting Comment';
	String get reportcomment => 'Report Options';
	List<String> get reportCommentsList => [
		'Unwanted commercial content or spam',
		'Pornography or sexual explicit material',
		'Hate speech or graphic violence',
		'Harassment or bullying',
		'Disturbing Content',
	];
	String get loginrequired => 'Login Required';
	String get loginrequiredhint => 'To subscribe on this platform, you need to be logged in. Create a free account now or log in to your existing account.';
	String get subscriptions => 'App Subscriptions';
	String get subscribe => 'SUBSCRIBE';
	String get subscribehint => 'Subscription Required';
	String get playsubscriptionrequiredhint => 'You need to subscribe before you can listen to or watch this media.';
	String get previewsubscriptionrequiredhint => 'You have reached the allowed preview duration for this media. You need to subscribe to continue listening or watching this media.';
	String get next => 'NEXT';
	String get done => 'GET STARTED';
	List<String> get onboardertitle => [
		'AudioBuzz',
		'Music Discovery',
		'Albums & Artists',
		'Unlimited Playlists',
	];
	List<String> get onboarderhints => [
		'Music streaming platform that lets you listen to millions of music from around the world.',
		'With the world’s largest catalog of songs, we let you discover more music you’ll love to love.',
		'Listen to your collection of albums from your favorite music artists.',
		'Create playlists of your favorited songs and videos for a wonderful listening experience.',
	];
	String get quitapp => 'Quit App!';
	String get quitappwarning => 'Do you wish to close the app?';
	String get quitappaudiowarning => 'You are currently playing an audio, quitting the app will stop the audio playback. If you do not wish to stop playback, just minimize the app with the center button or click the Ok button to quit app now.';
}

// Path: <root>
class _StringsAr implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsAr.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	// ignore: unused_field
	@override late final _StringsAr _root = this;

	// Translations
	@override String get appname => 'AudioBuzz';
	@override String get loadingapp => 'ضبط في...';
	@override String get allitems => 'كل الاشياء';
	@override String get emptyplaylist => 'لا توجد قوائم تشغيل';
	@override String get notsupported => 'غير مدعوم';
	@override String get cleanupresources => 'تنظيف الموارد';
	@override String get grantstoragepermission => 'يرجى منح إذن الوصول إلى التخزين للمتابعة';
	@override String get sharefiletitle => 'شاهد أو استمع ';
	@override String get sharefilebody => 'عبر تطبيق AudioBuzz ، قم بالتنزيل الآن على ';
	@override String get sharetext => 'استمتع ببث غير محدود من الصوت والفيديو';
	@override String get sharetexthint => 'قم بتنزيل AudioBuzz ، منصة دفق الموسيقى التي تتيح لك الاستماع إلى ملايين ملفات الموسيقى من جميع أنحاء العالم. قم بالتنزيل الآن من';
	@override String get home => 'الصفحة الرئيسية';
	@override String get downloads => 'البحث في التنزيلات';
	@override String get albums => 'ألبومات';
	@override String get artists => 'الفنانين';
	@override String get radio => 'قنوات الراديو';
	@override String get hotandtrending => 'الشائع';
	@override String get device => 'جهاز';
	@override String get audiotracks => 'المسارات';
	@override String get playlist => 'قوائم التشغيل';
	@override String get bookmarks => 'إشارات مرجعية';
	@override String get appinfo => 'معلومات التطبيق';
	@override String get genres => 'جميع الأنواع';
	@override String get genress => 'الأنواع';
	@override String get moods => 'المزاج';
	@override String get settings => 'إعدادات';
	@override String get selectlanguage => 'اختار اللغة';
	@override String get chooseapplanguage => 'اختر لغة التطبيق';
	@override String get startsubscription => 'افتح الميزات المميزة';
	@override String get startsubscriptionhint => 'افتح الميزات المتميزة لبدء رحلتك إلى تجربة بث وسائط لا تنتهي أبدًا';
	@override String get suggestedforyou => 'اقترح لك';
	@override String get tracks => 'المسارات';
	@override String get livetvchannels => 'القنوات الحية';
	@override String get trendingvideos => 'مقاطع الفيديو الشائعة';
	@override String get trendingaudios => 'جمع';
	@override String get trendingvideoshint => 'فيديوهات شعبية على AudioBuzz';
	@override String get trendingaudioshint => 'صوتيات شعبية على AudioBuzz';
	@override String get newvideoshint => 'مقاطع فيديو جديدة من جميع الفئات';
	@override String get newaudioshint => 'صوتيات جديدة من جميع الفئات';
	@override String get bookmarksMedia => 'متجر كتبي';
	@override String get noitemstodisplay => 'لا توجد عناصر لعرضها';
	@override String get download => 'تحميل';
	@override String get addplaylist => 'أضف إلى قائمة التشغيل';
	@override String get bookmark => 'المرجعية';
	@override String get unbookmark => 'غير مرجعية';
	@override String get share => 'يشارك';
	@override String get deletemedia => 'حذف ملف';
	@override String get deletemediahint => 'هل ترغب في حذف هذا الملف الذي تم تنزيله؟ لا يمكن التراجع عن هذا الإجراء';
	@override String get searchhint => 'البحث في الصوتيات';
	@override String get performingsearch => 'البحث في الصوتيات';
	@override String get nosearchresult => 'لم يتم العثور على نتائج';
	@override String get nosearchresulthint => 'حاول إدخال كلمة رئيسية أكثر عمومية';
	@override String get livetvPlaylists => 'قوائم تشغيل الوسائط الحية';
	@override String get addtoplaylist => 'أضف إلى قائمة التشغيل';
	@override String get newplaylist => 'قائمة تشغيل جديدة';
	@override String get playlistitm => 'قائمة التشغيل';
	@override String get mediaaddedtoplaylist => 'تمت إضافة الوسائط إلى قائمة التشغيل.';
	@override String get mediaremovedfromplaylist => 'تمت إزالة الوسائط من قائمة التشغيل';
	@override String get clearplaylistmedias => 'مسح كافة الوسائط';
	@override String get deletePlayList => 'حذف قائمة التشغيل';
	@override String get clearplaylistmediashint => 'انطلق وقم بإزالة جميع الوسائط من قائمة التشغيل هذه';
	@override String get deletePlayListhint => 'هل تريد المضي قدمًا وحذف قائمة التشغيل هذه ومسح جميع الوسائط؟';
	@override String get comments => 'تعليقات';
	@override String get replies => 'الردود';
	@override String get reply => 'رد';
	@override String get logintoaddcomment => 'تسجيل الدخول لإضافة تعليق';
	@override String get logintoreply => 'تسجيل الدخول إلى إجابة';
	@override String get writeamessage => 'اكتب رسالة...';
	@override String get nocomments => 'لا توجد تعليقات انقر لإعادة المحاولة';
	@override String get errormakingcomments => 'لا يمكن معالجة التعليق في الوقت الحالي..';
	@override String get errordeletingcomments => 'لا يمكن حذف هذا التعليق في الوقت الحالي..';
	@override String get erroreditingcomments => 'لا يمكن تعديل هذا التعليق في الوقت الحالي..';
	@override String get errorloadingmorecomments => 'لا يمكن تحميل المزيد من التعليقات في الوقت الحالي..';
	@override String get deletingcomment => 'حذف التعليق';
	@override String get editingcomment => 'تحرير التعليق';
	@override String get deletecommentalert => 'حذف تعليق';
	@override String get editcommentalert => 'تعديل التعليق';
	@override String get deletecommentalerttext => 'هل ترغب في حذف هذا التعليق؟ لا يمكن التراجع عن هذا الإجراء';
	@override String get loadmore => 'تحميل المزيد';
	@override String get guestuser => 'حساب زائر';
	@override String get fullname => 'الاسم الكامل';
	@override String get emailaddress => 'عنوان بريد الكتروني';
	@override String get password => 'كلمة المرور';
	@override String get repeatpassword => 'اعد كلمة السر';
	@override String get register => 'يسجل';
	@override String get login => 'تسجيل الدخول';
	@override String get logout => 'تسجيل خروج';
	@override String get logoutfromapp => 'هل تريد الخروج من التطبيق؟';
	@override String get logoutfromapphint => 'لن تتمكن من إبداء الإعجاب بالمقالات ومقاطع الفيديو أو التعليق عليها إذا لم تقم بتسجيل الدخول.';
	@override String get gotologin => 'اذهب إلى تسجيل الدخول';
	@override String get resetpassword => 'إعادة تعيين كلمة المرور';
	@override String get logintoaccount => 'هل لديك حساب؟ تسجيل الدخول';
	@override String get emptyfielderrorhint => 'أنت بحاجة لملء جميع الحقول';
	@override String get invalidemailerrorhint => 'تحتاج إلى إدخال عنوان بريد إلكتروني صالح';
	@override String get passwordsdontmatch => 'كلمات السر لا تتطابق';
	@override String get processingpleasewait => 'Processing, Please wait...';
	@override String get createaccount => 'انشئ حساب';
	@override String get forgotpassword => 'هل نسيت كلمة السر؟';
	@override String get orloginwith => 'أو تسجيل الدخول باستخدام';
	@override String get facebook => 'Facebook';
	@override String get google => 'Google';
	@override String get moreoptions => 'المزيد من الخيارات';
	@override String get about => 'معلومات عنا';
	@override String get privacy => 'سياسة خاصة';
	@override String get terms => 'شروط التطبيق';
	@override String get rate => 'قيم التطبيق';
	@override String get version => 'الإصدار';
	@override String get pulluploadmore => 'سحب ما يصل الحمل';
	@override String get loadfailedretry => 'فشل التحميل! انقر فوق إعادة المحاولة!';
	@override String get releaseloadmore => 'الافراج لتحميل المزيد';
	@override String get nomoredata => 'لا مزيد من البيانات';
	@override String get setupprefernces => 'قم بإعداد التفضيلات الخاصة بك';
	@override String get receievepshnotifications => 'تلقي الإخطارات';
	@override String get nightmode => 'الوضع الليلي';
	@override String get enablertl => 'تفعيل RTL';
	@override String get duration => 'مدة';
	@override String get ok => 'موافق';
	@override String get retry => 'أعد المحاولة';
	@override String get oops => 'اوووه!';
	@override String get save => 'يحفظ';
	@override String get cancel => 'يلغي';
	@override String get error => 'خطأ';
	@override String get success => 'نجاح';
	@override String get skip => 'تخطى';
	@override String get skiplogin => 'تخطي تسجيل الدخول';
	@override String get skipregister => 'تخطي تسجيل';
	@override String get dataloaderror => 'تعذر تحميل البيانات المطلوبة في الوقت الحالي ، تحقق من اتصال البيانات وانقر لإعادة المحاولة.';
	@override String get errorReportingComment => 'الإبلاغ عن خطأ التعليق';
	@override String get reportingComment => 'الإبلاغ عن التعليق';
	@override String get reportcomment => 'خيارات التقرير';
	@override List<String> get reportCommentsList => [
		'المحتوى التجاري غير المرغوب فيه أو البريد العشوائي',
		'مواد إباحية أو مواد جنسية صريحة',
		'كلام يحض على الكراهية أو عنف تصويري',
		'المضايقة أو التنمر',
		'محتوى مزعج',
	];
	@override String get loginrequired => 'تسجيل الدخول مطلوب';
	@override String get loginrequiredhint => 'للاشتراك في هذه المنصة ، يجب أن تقوم بتسجيل الدخول. قم بإنشاء حساب مجاني الآن أو قم بتسجيل الدخول إلى حسابك الحالي.';
	@override String get subscriptions => 'اشتراكات التطبيق';
	@override String get subscribe => 'الإشتراك';
	@override String get subscribehint => 'الاشتراك المطلوبة';
	@override String get playsubscriptionrequiredhint => 'تحتاج إلى الاشتراك قبل أن تتمكن من الاستماع إلى هذه الوسائط أو مشاهدتها.';
	@override String get previewsubscriptionrequiredhint => 'لقد وصلت إلى مدة المعاينة المسموح بها لهذه الوسائط. تحتاج إلى الاشتراك لمواصلة الاستماع أو مشاهدة هذه الوسائط.';
	@override String get next => 'التالي';
	@override String get done => 'البدء';
	@override List<String> get onboardertitle => [
		'AudioBuzz',
		'Music Discovery',
		'Albums & Artists',
		'Unlimited Playlists',
	];
	@override List<String> get onboarderhints => [
		'Music streaming platform that lets you listen to millions of music from around the world.',
		'With the world’s largest catalog of songs, we let you discover more music you’ll love to love.',
		'Listen to your collection of albums from your favorite music artists.',
		'Create playlists of your favorited songs and videos for a wonderful listening experience.',
	];
	@override String get quitapp => 'قم بإنهاء التطبيق!';
	@override String get quitappwarning => 'هل ترغب في إغلاق التطبيق؟';
	@override String get quitappaudiowarning => 'أنت تقوم حاليًا بتشغيل مقطع صوتي ، وسيؤدي إنهاء التطبيق إلى إيقاف تشغيل الصوت. إذا كنت لا ترغب في إيقاف التشغيل ، فما عليك سوى تصغير التطبيق باستخدام الزر الأوسط أو النقر فوق الزر موافق لإنهاء التطبيق الآن';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'appname': 'AudioBuzz',
			'loadingapp': 'tuning in...',
			'allitems': 'All Items',
			'emptyplaylist': 'No Playlists Created',
			'notsupported': 'Not Supported',
			'cleanupresources': 'Cleaning up resources',
			'grantstoragepermission': 'Please grant accessing storage permission to continue',
			'sharefiletitle': 'Watch or Listen to ',
			'sharefilebody': 'Via AudioBuzz App, Download now at ',
			'sharetext': 'Enjoy unlimited Audio & Video streaming',
			'sharetexthint': 'Download AudioBuzz, the music streaming platform that lets you listen to millions of music files from around the world. Download now at',
			'home': 'Home',
			'downloads': 'Search Downloads',
			'albums': 'Albums',
			'artists': 'Artists',
			'radio': 'Radio Channels',
			'hotandtrending': 'Trending',
			'device': 'Device',
			'audiotracks': 'Tracks',
			'playlist': 'Playlists',
			'bookmarks': 'Bookmarks',
			'appinfo': 'App Info',
			'genres': 'All Genres',
			'genress': 'Genres',
			'moods': 'Moods',
			'settings': 'Settings',
			'selectlanguage': 'Select Language',
			'chooseapplanguage': 'Choose App Language',
			'startsubscription': 'Unlock Premium Features',
			'startsubscriptionhint': 'Unlock premium features to start your journey to a never-ending media streaming experience',
			'suggestedforyou': 'Suggested for you',
			'tracks': 'Tracks',
			'livetvchannels': 'Live Channels',
			'trendingvideos': 'Trending Videos',
			'trendingaudios': 'Popular',
			'trendingvideoshint': 'Popular Videos On AudioBuzz',
			'trendingaudioshint': 'Popular Audios On AudioBuzz',
			'newvideoshint': 'New Videos from all categories',
			'newaudioshint': 'New Audios from all categories',
			'bookmarksMedia': 'My Bookmarks',
			'noitemstodisplay': 'No Items To Display',
			'download': 'Download',
			'addplaylist': 'Add to playlist',
			'bookmark': 'Bookmark',
			'unbookmark': 'UnBookmark',
			'share': 'Share',
			'deletemedia': 'Delete File',
			'deletemediahint': 'Do you wish to delete this downloaded file? This action cannot be undone.',
			'searchhint': 'Search Audios',
			'performingsearch': 'Searching Audios',
			'nosearchresult': 'No results Found',
			'nosearchresulthint': 'Try input more general keyword',
			'livetvPlaylists': 'Live Media Playlists',
			'addtoplaylist': 'Add to playlist',
			'newplaylist': 'New playlist',
			'playlistitm': 'Playlist',
			'mediaaddedtoplaylist': 'Media added to playlist.',
			'mediaremovedfromplaylist': 'Media removed from playlist',
			'clearplaylistmedias': 'Clear All Media',
			'deletePlayList': 'Delete Playlist',
			'clearplaylistmediashint': 'Go ahead and remove all media from this playlist?',
			'deletePlayListhint': 'Go ahead and delete this playlist and clear all media?',
			'comments': 'Comments',
			'replies': 'Replies',
			'reply': 'Reply',
			'logintoaddcomment': 'Login to add a comment',
			'logintoreply': 'Login to reply',
			'writeamessage': 'Write a message...',
			'nocomments': 'No Comments found \nclick to retry',
			'errormakingcomments': 'Cannot process commenting at the moment..',
			'errordeletingcomments': 'Cannot delete this comment at the moment..',
			'erroreditingcomments': 'Cannot edit this comment at the moment..',
			'errorloadingmorecomments': 'Cannot load more comments at the moment..',
			'deletingcomment': 'Deleting comment',
			'editingcomment': 'Editing comment',
			'deletecommentalert': 'Delete Comment',
			'editcommentalert': 'Edit Comment',
			'deletecommentalerttext': 'Do you wish to delete this comment? This action cannot be undone',
			'loadmore': 'load more',
			'guestuser': 'Guest User',
			'fullname': 'Full Name',
			'emailaddress': 'Email Address',
			'password': 'Password',
			'repeatpassword': 'Repeat Password',
			'register': 'Register',
			'login': 'Login',
			'logout': 'Logout',
			'logoutfromapp': 'Logout from app?',
			'logoutfromapphint': 'You wont be able to like or comment on articles and videos if you are not logged in.',
			'gotologin': 'Go to Login',
			'resetpassword': 'Reset Password',
			'logintoaccount': 'Already have an account? Login',
			'emptyfielderrorhint': 'You need to fill all the fields',
			'invalidemailerrorhint': 'You need to enter a valid email address',
			'passwordsdontmatch': 'Passwords dont match',
			'processingpleasewait': 'Processing, Please wait...',
			'createaccount': 'Create an account',
			'forgotpassword': 'Forgot Password?',
			'orloginwith': 'Or Login With',
			'facebook': 'Facebook',
			'google': 'Google',
			'moreoptions': 'More Options',
			'about': 'About Us',
			'privacy': 'Privacy Policy',
			'terms': 'App Terms',
			'rate': 'Rate App',
			'version': 'Version',
			'pulluploadmore': 'pull up load',
			'loadfailedretry': 'Load Failed!Click retry!',
			'releaseloadmore': 'release to load more',
			'nomoredata': 'No more Data',
			'setupprefernces': 'Setup Your Preferences',
			'receievepshnotifications': 'Recieve Notifications',
			'nightmode': 'Night Mode',
			'enablertl': 'Enable RTL',
			'duration': 'Duration',
			'ok': 'Ok',
			'retry': 'RETRY',
			'oops': 'Ooops!',
			'save': 'Save',
			'cancel': 'Cancel',
			'error': 'Error',
			'success': 'Success',
			'skip': 'Skip',
			'skiplogin': 'Skip Login',
			'skipregister': 'Skip Registration',
			'dataloaderror': 'Could not load requested data at the moment, check your data connection and click to retry.',
			'errorReportingComment': 'Error Reporting Comment',
			'reportingComment': 'Reporting Comment',
			'reportcomment': 'Report Options',
			'reportCommentsList.0': 'Unwanted commercial content or spam',
			'reportCommentsList.1': 'Pornography or sexual explicit material',
			'reportCommentsList.2': 'Hate speech or graphic violence',
			'reportCommentsList.3': 'Harassment or bullying',
			'reportCommentsList.4': 'Disturbing Content',
			'loginrequired': 'Login Required',
			'loginrequiredhint': 'To subscribe on this platform, you need to be logged in. Create a free account now or log in to your existing account.',
			'subscriptions': 'App Subscriptions',
			'subscribe': 'SUBSCRIBE',
			'subscribehint': 'Subscription Required',
			'playsubscriptionrequiredhint': 'You need to subscribe before you can listen to or watch this media.',
			'previewsubscriptionrequiredhint': 'You have reached the allowed preview duration for this media. You need to subscribe to continue listening or watching this media.',
			'next': 'NEXT',
			'done': 'GET STARTED',
			'onboardertitle.0': 'AudioBuzz',
			'onboardertitle.1': 'Music Discovery',
			'onboardertitle.2': 'Albums & Artists',
			'onboardertitle.3': 'Unlimited Playlists',
			'onboarderhints.0': 'Music streaming platform that lets you listen to millions of music from around the world.',
			'onboarderhints.1': 'With the world’s largest catalog of songs, we let you discover more music you’ll love to love.',
			'onboarderhints.2': 'Listen to your collection of albums from your favorite music artists.',
			'onboarderhints.3': 'Create playlists of your favorited songs and videos for a wonderful listening experience.',
			'quitapp': 'Quit App!',
			'quitappwarning': 'Do you wish to close the app?',
			'quitappaudiowarning': 'You are currently playing an audio, quitting the app will stop the audio playback. If you do not wish to stop playback, just minimize the app with the center button or click the Ok button to quit app now.',
		};
	}
}

extension on _StringsAr {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'appname': 'AudioBuzz',
			'loadingapp': 'ضبط في...',
			'allitems': 'كل الاشياء',
			'emptyplaylist': 'لا توجد قوائم تشغيل',
			'notsupported': 'غير مدعوم',
			'cleanupresources': 'تنظيف الموارد',
			'grantstoragepermission': 'يرجى منح إذن الوصول إلى التخزين للمتابعة',
			'sharefiletitle': 'شاهد أو استمع ',
			'sharefilebody': 'عبر تطبيق AudioBuzz ، قم بالتنزيل الآن على ',
			'sharetext': 'استمتع ببث غير محدود من الصوت والفيديو',
			'sharetexthint': 'قم بتنزيل AudioBuzz ، منصة دفق الموسيقى التي تتيح لك الاستماع إلى ملايين ملفات الموسيقى من جميع أنحاء العالم. قم بالتنزيل الآن من',
			'home': 'الصفحة الرئيسية',
			'downloads': 'البحث في التنزيلات',
			'albums': 'ألبومات',
			'artists': 'الفنانين',
			'radio': 'قنوات الراديو',
			'hotandtrending': 'الشائع',
			'device': 'جهاز',
			'audiotracks': 'المسارات',
			'playlist': 'قوائم التشغيل',
			'bookmarks': 'إشارات مرجعية',
			'appinfo': 'معلومات التطبيق',
			'genres': 'جميع الأنواع',
			'genress': 'الأنواع',
			'moods': 'المزاج',
			'settings': 'إعدادات',
			'selectlanguage': 'اختار اللغة',
			'chooseapplanguage': 'اختر لغة التطبيق',
			'startsubscription': 'افتح الميزات المميزة',
			'startsubscriptionhint': 'افتح الميزات المتميزة لبدء رحلتك إلى تجربة بث وسائط لا تنتهي أبدًا',
			'suggestedforyou': 'اقترح لك',
			'tracks': 'المسارات',
			'livetvchannels': 'القنوات الحية',
			'trendingvideos': 'مقاطع الفيديو الشائعة',
			'trendingaudios': 'جمع',
			'trendingvideoshint': 'فيديوهات شعبية على AudioBuzz',
			'trendingaudioshint': 'صوتيات شعبية على AudioBuzz',
			'newvideoshint': 'مقاطع فيديو جديدة من جميع الفئات',
			'newaudioshint': 'صوتيات جديدة من جميع الفئات',
			'bookmarksMedia': 'متجر كتبي',
			'noitemstodisplay': 'لا توجد عناصر لعرضها',
			'download': 'تحميل',
			'addplaylist': 'أضف إلى قائمة التشغيل',
			'bookmark': 'المرجعية',
			'unbookmark': 'غير مرجعية',
			'share': 'يشارك',
			'deletemedia': 'حذف ملف',
			'deletemediahint': 'هل ترغب في حذف هذا الملف الذي تم تنزيله؟ لا يمكن التراجع عن هذا الإجراء',
			'searchhint': 'البحث في الصوتيات',
			'performingsearch': 'البحث في الصوتيات',
			'nosearchresult': 'لم يتم العثور على نتائج',
			'nosearchresulthint': 'حاول إدخال كلمة رئيسية أكثر عمومية',
			'livetvPlaylists': 'قوائم تشغيل الوسائط الحية',
			'addtoplaylist': 'أضف إلى قائمة التشغيل',
			'newplaylist': 'قائمة تشغيل جديدة',
			'playlistitm': 'قائمة التشغيل',
			'mediaaddedtoplaylist': 'تمت إضافة الوسائط إلى قائمة التشغيل.',
			'mediaremovedfromplaylist': 'تمت إزالة الوسائط من قائمة التشغيل',
			'clearplaylistmedias': 'مسح كافة الوسائط',
			'deletePlayList': 'حذف قائمة التشغيل',
			'clearplaylistmediashint': 'انطلق وقم بإزالة جميع الوسائط من قائمة التشغيل هذه',
			'deletePlayListhint': 'هل تريد المضي قدمًا وحذف قائمة التشغيل هذه ومسح جميع الوسائط؟',
			'comments': 'تعليقات',
			'replies': 'الردود',
			'reply': 'رد',
			'logintoaddcomment': 'تسجيل الدخول لإضافة تعليق',
			'logintoreply': 'تسجيل الدخول إلى إجابة',
			'writeamessage': 'اكتب رسالة...',
			'nocomments': 'لا توجد تعليقات انقر لإعادة المحاولة',
			'errormakingcomments': 'لا يمكن معالجة التعليق في الوقت الحالي..',
			'errordeletingcomments': 'لا يمكن حذف هذا التعليق في الوقت الحالي..',
			'erroreditingcomments': 'لا يمكن تعديل هذا التعليق في الوقت الحالي..',
			'errorloadingmorecomments': 'لا يمكن تحميل المزيد من التعليقات في الوقت الحالي..',
			'deletingcomment': 'حذف التعليق',
			'editingcomment': 'تحرير التعليق',
			'deletecommentalert': 'حذف تعليق',
			'editcommentalert': 'تعديل التعليق',
			'deletecommentalerttext': 'هل ترغب في حذف هذا التعليق؟ لا يمكن التراجع عن هذا الإجراء',
			'loadmore': 'تحميل المزيد',
			'guestuser': 'حساب زائر',
			'fullname': 'الاسم الكامل',
			'emailaddress': 'عنوان بريد الكتروني',
			'password': 'كلمة المرور',
			'repeatpassword': 'اعد كلمة السر',
			'register': 'يسجل',
			'login': 'تسجيل الدخول',
			'logout': 'تسجيل خروج',
			'logoutfromapp': 'هل تريد الخروج من التطبيق؟',
			'logoutfromapphint': 'لن تتمكن من إبداء الإعجاب بالمقالات ومقاطع الفيديو أو التعليق عليها إذا لم تقم بتسجيل الدخول.',
			'gotologin': 'اذهب إلى تسجيل الدخول',
			'resetpassword': 'إعادة تعيين كلمة المرور',
			'logintoaccount': 'هل لديك حساب؟ تسجيل الدخول',
			'emptyfielderrorhint': 'أنت بحاجة لملء جميع الحقول',
			'invalidemailerrorhint': 'تحتاج إلى إدخال عنوان بريد إلكتروني صالح',
			'passwordsdontmatch': 'كلمات السر لا تتطابق',
			'processingpleasewait': 'Processing, Please wait...',
			'createaccount': 'انشئ حساب',
			'forgotpassword': 'هل نسيت كلمة السر؟',
			'orloginwith': 'أو تسجيل الدخول باستخدام',
			'facebook': 'Facebook',
			'google': 'Google',
			'moreoptions': 'المزيد من الخيارات',
			'about': 'معلومات عنا',
			'privacy': 'سياسة خاصة',
			'terms': 'شروط التطبيق',
			'rate': 'قيم التطبيق',
			'version': 'الإصدار',
			'pulluploadmore': 'سحب ما يصل الحمل',
			'loadfailedretry': 'فشل التحميل! انقر فوق إعادة المحاولة!',
			'releaseloadmore': 'الافراج لتحميل المزيد',
			'nomoredata': 'لا مزيد من البيانات',
			'setupprefernces': 'قم بإعداد التفضيلات الخاصة بك',
			'receievepshnotifications': 'تلقي الإخطارات',
			'nightmode': 'الوضع الليلي',
			'enablertl': 'تفعيل RTL',
			'duration': 'مدة',
			'ok': 'موافق',
			'retry': 'أعد المحاولة',
			'oops': 'اوووه!',
			'save': 'يحفظ',
			'cancel': 'يلغي',
			'error': 'خطأ',
			'success': 'نجاح',
			'skip': 'تخطى',
			'skiplogin': 'تخطي تسجيل الدخول',
			'skipregister': 'تخطي تسجيل',
			'dataloaderror': 'تعذر تحميل البيانات المطلوبة في الوقت الحالي ، تحقق من اتصال البيانات وانقر لإعادة المحاولة.',
			'errorReportingComment': 'الإبلاغ عن خطأ التعليق',
			'reportingComment': 'الإبلاغ عن التعليق',
			'reportcomment': 'خيارات التقرير',
			'reportCommentsList.0': 'المحتوى التجاري غير المرغوب فيه أو البريد العشوائي',
			'reportCommentsList.1': 'مواد إباحية أو مواد جنسية صريحة',
			'reportCommentsList.2': 'كلام يحض على الكراهية أو عنف تصويري',
			'reportCommentsList.3': 'المضايقة أو التنمر',
			'reportCommentsList.4': 'محتوى مزعج',
			'loginrequired': 'تسجيل الدخول مطلوب',
			'loginrequiredhint': 'للاشتراك في هذه المنصة ، يجب أن تقوم بتسجيل الدخول. قم بإنشاء حساب مجاني الآن أو قم بتسجيل الدخول إلى حسابك الحالي.',
			'subscriptions': 'اشتراكات التطبيق',
			'subscribe': 'الإشتراك',
			'subscribehint': 'الاشتراك المطلوبة',
			'playsubscriptionrequiredhint': 'تحتاج إلى الاشتراك قبل أن تتمكن من الاستماع إلى هذه الوسائط أو مشاهدتها.',
			'previewsubscriptionrequiredhint': 'لقد وصلت إلى مدة المعاينة المسموح بها لهذه الوسائط. تحتاج إلى الاشتراك لمواصلة الاستماع أو مشاهدة هذه الوسائط.',
			'next': 'التالي',
			'done': 'البدء',
			'onboardertitle.0': 'AudioBuzz',
			'onboardertitle.1': 'Music Discovery',
			'onboardertitle.2': 'Albums & Artists',
			'onboardertitle.3': 'Unlimited Playlists',
			'onboarderhints.0': 'Music streaming platform that lets you listen to millions of music from around the world.',
			'onboarderhints.1': 'With the world’s largest catalog of songs, we let you discover more music you’ll love to love.',
			'onboarderhints.2': 'Listen to your collection of albums from your favorite music artists.',
			'onboarderhints.3': 'Create playlists of your favorited songs and videos for a wonderful listening experience.',
			'quitapp': 'قم بإنهاء التطبيق!',
			'quitappwarning': 'هل ترغب في إغلاق التطبيق؟',
			'quitappaudiowarning': 'أنت تقوم حاليًا بتشغيل مقطع صوتي ، وسيؤدي إنهاء التطبيق إلى إيقاف تشغيل الصوت. إذا كنت لا ترغب في إيقاف التشغيل ، فما عليك سوى تصغير التطبيق باستخدام الزر الأوسط أو النقر فوق الزر موافق لإنهاء التطبيق الآن',
		};
	}
}
