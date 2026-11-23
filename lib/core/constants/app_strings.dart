/// ---------------------------------------------------------------------------
/// AppStrings - every user-facing string in the app (Arabic, RTL).
/// Code identifiers stay English; only these values are shown to users.
/// Change a sentence here and it changes everywhere in the app.
/// ---------------------------------------------------------------------------
class AppStrings {
  AppStrings._();

  // ---- App ----
  static const String appName = 'دليل';
  static const String tagline = 'بدّل اللي عندك باللي محتاجه';

  // Demo only. The real client configuration arrives in stage 06.
  static const String googleServerClientId = '';

  // ---- Onboarding ----
  static const String onboardingTitle1 = 'بدّل.. متشتريش';
  static const String onboardingBody1 =
      'تبادل الكتب والأدوات والأجهزة مع طلبة في حرمك الجامعي، من غير فلوس.';
  static const String onboardingTitle2 = 'اعرض اللي مش بتستخدمه';
  static const String onboardingBody2 =
      'صوّر حاجتك، اكتب وصفها، وقول عايز إيه في المقابل.';
  static const String onboardingTitle3 = 'اطلب، اتكلم، بدّل';
  static const String onboardingBody3 =
      'ابعت طلب تبديل، اتفق مع صاحب الحاجة في الشات، اتقابلوا، وقيّموا بعض.';
  static const String next = 'التالي';
  static const String getStarted = 'يلا نبدأ';
  static const String skip = 'تخطي';

  // ---- Auth ----
  static const String login = 'تسجيل الدخول';
  static const String loginSubtitle =
      'سجّل دخولك وابدأ التبديل مع الطلبة اللي حواليك';
  static const String signUp = 'إنشاء حساب';
  static const String createAccount = 'إنشاء الحساب';
  static const String createNewAccount = 'حساب جديد';
  static const String signUpSubtitle = 'انضم للطلبة اللي بيبدلوا بدل ما يشتروا';
  static const String fullName = 'الاسم بالكامل';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String confirmPassword = 'تأكيد كلمة المرور';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String forgotPasswordTitle = 'نسيت كلمة المرور؟';
  static const String forgotPasswordBody =
      'اكتب بريدك الإلكتروني وهنبعتلك لينك تعيد بيه تعيين كلمة المرور.';
  static const String sendResetLink = 'ابعت اللينك';
  static const String checkYourEmail = 'بص على بريدك';
  static const String resetEmailBody =
      'بعنالك لينك إعادة تعيين كلمة المرور على بريدك. اتبعه وبعدين سجّل دخولك بكلمة المرور الجديدة.';
  static const String backToLogin = 'رجوع لتسجيل الدخول';
  static const String orDivider = 'أو';
  static const String signInWithGoogle = 'الدخول بحساب جوجل';
  static const String noAccount = 'لسه ماعندكش حساب؟ ';
  static const String haveAccount = 'عندك حساب بالفعل؟ ';

  // ---- Validation messages ----
  static const String fieldRequired = 'الحقل ده مطلوب';
  static const String invalidEmail = 'اكتب بريد إلكتروني صحيح';
  static const String shortPassword = 'كلمة المرور لازم تكون 6 حروف على الأقل';
  static const String passwordsDontMatch = 'كلمتا المرور مش متطابقتين';

  // ---- Home ----
  static const String searchHint = 'دوّر على حاجة...';
  static const String categories = 'الأقسام';
  static const String viewAll = 'عرض الكل';
  static const String recommendedForYou = 'مقترح ليك';
  static const String recentlyAdded = 'ضافوه مؤخرًا';
  static const String promoTitle = 'وفّر فلوس دراستك';
  static const String promoBody =
      'بدّل الكتب والأدوات مع زمايلك في الجامعة من غير أي فلوس';
  static const String hiGreeting = 'أهلًا، ';

  // ---- Categories (campus-oriented, from the Figma IA) ----
  static const List<String> categoryList = [
    'كتب ومراجع',
    'أدوات مكتبية',
    'عدد وأدوات',
    'أدوات فنية وإبداعية',
    'لابتوبات وإكسسوارات',
    'أدوات رياضية',
    'أخرى',
  ];

  // ---- Conditions ----
  static const List<String> conditionList = ['جديد', 'كالجديد', 'جيد', 'مقبول'];

  // ---- Listings ----
  static const String addListing = 'اعرض حاجة';
  static const String editListing = 'تعديل الإعلان';
  static const String listingTitle = 'اسم الحاجة';
  static const String description = 'الوصف';
  static const String category = 'القسم';
  static const String condition = 'الحالة';
  static const String wantedInReturn = 'عايز إيه في المقابل؟';
  static const String wantedHint = 'مثال: آلة حاسبة، أي رواية، أدوات رسم...';
  static const String addPhotos = 'ضيف صور';
  static const String addPhotoFromCamera = 'الكاميرا';
  static const String addPhotoFromGallery = 'المعرض';
  static const String publishListing = 'انشر الإعلان';
  static const String saveChanges = 'حفظ التعديلات';
  static const String myListings = 'إعلاناتي';
  static const String availableForSwap = 'متاح للتبديل دلوقتي';
  static const String forSwap = 'للتبديل';
  static const String requestSwap = 'اطلب التبديل';
  static const String listingDetails = 'تفاصيل الحاجة';
  static const String ownerLabel = 'صاحب الحاجة';
  static const String deleteListing = 'حذف الإعلان';
  static const String wantsPrefix = 'عايز في المقابل: ';
  static const String addAtLeastOnePhoto = 'ضيف صورة واحدة على الأقل';

  // ---- Swap requests ----
  static const String swapRequests = 'طلبات التبديل';
  static const String incoming = 'واصلة ليك';
  static const String outgoing = 'انت باعثها';
  static const String sendRequest = 'ابعت الطلب';
  static const String sendSwapRequest = 'ابعت طلب تبديل';
  static const String offerOneOfYours = 'اعرض حاجة من عندك';
  static const String messageToOwner = 'رسالة لصاحب الحاجة (اختياري)';
  static const String accept = 'قبول';
  static const String decline = 'رفض';
  static const String markAsCompleted = 'التبديل تم';
  static const String cancelRequest = 'إلغاء الطلب';
  static const String requestSentTitle = 'طلب التبديل اتبعت';
  static const String requestSentBody =
      'صاحب الحاجة هياخد إشعار. تقدر تتابع حالة الطلب من صفحة الطلبات.';
  static const String viewMyRequests = 'شوف طلباتي';
  static const String backToHome = 'رجوع للرئيسية';
  static const String statusPending = 'مستني الرد';
  static const String statusAccepted = 'مقبول';
  static const String statusDeclined = 'مرفوض';
  static const String statusCompleted = 'تم التبديل';
  static const String statusCancelled = 'ملغي';

  // ---- Chat ----
  static const String chats = 'المحادثات';
  static const String typeMessage = 'اكتب رسالة...';
  static const String chatHintAccepted = 'الشات بيفتح لما طلب التبديل يتقبل.';

  // ---- Ratings ----
  static const String rateYourSwap = 'قيّم التبديل';
  static const String rateUserBody = 'إيه رأيك في التبديل مع الشخص ده؟';
  static const String submitRating = 'ابعت التقييم';
  static const String ratingsAndReviews = 'التقييمات والآراء';
  static const String writeCommentHint = 'اكتب تعليق قصير (اختياري)';

  // ---- Favorites / search / filters ----
  static const String favorites = 'المفضلة';
  static const String filter = 'فلترة';
  static const String noResultsTitle = 'مفيش نتايج';
  static const String noResultsBody =
      'جرب كلمات تانية أو شيل الفلاتر، ممكن تلاقي حاجة شبهها.';
  static const String browseCategories = 'اتفرج على الأقسام';

  // ---- Profile ----
  static const String profile = 'الحساب';
  static const String yourProfile = 'حسابك';
  static const String editProfile = 'تعديل الحساب';
  static const String phone = 'رقم الموبايل';
  static const String bio = 'نبذة';
  static const String changePhoto = 'تغيير الصورة';
  static const String photoUploadFailed = 'رفع الصورة فشل، حاول تاني';
  static const String logout = 'تسجيل الخروج';
  static const String notifications = 'الإشعارات';

  // ---- Bottom navigation ----
  static const String navHome = 'الرئيسية';
  static const String navRequests = 'الطلبات';
  static const String navFavorites = 'المفضلة';
  static const String navProfile = 'حسابي';

  // ---- Generic ----
  static const String save = 'حفظ';
  static const String cancel = 'إلغاء';
  static const String delete = 'حذف';
  static const String retry = 'حاول تاني';
  static const String chatWithOwner = 'مراسلة صاحب الإعلان';
  static const String darkMode = 'الوضع الليلي';
  static const String loading = 'جاري التحميل...';
  static const String somethingWentWrong = 'حصلت مشكلة. حاول تاني.';
  static const String emptyListings = 'مفيش حاجة هنا لسه';
  static const String emptyRequests = 'مفيش طلبات تبديل لسه';
  static const String emptyFavorites =
      'مفيش مفضلة لسه، دوس على القلب في أي حاجة';
  static const String emptyChats = 'مفيش محادثات لسه';
  static const String emptyNotifications = 'مفيش إشعارات لسه';

  // ---- Notifications (written by services) ----
  static const String notifNewRequestTitle = 'طلب تبديل جديد';
  static const String notifAcceptedTitle = 'طلبك اتقبل';
  static const String notifDeclinedTitle = 'طلبك اترفض';
  static const String notifCompletedTitle = 'التبديل تم';
  static const String notifCompletedBody = 'التبديل خلص. متنساش تقيّم!';
}
