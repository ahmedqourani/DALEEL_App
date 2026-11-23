import 'package:flutter/material.dart';
import '../../../core/widgets/dalil_logo.dart';

const petrol = Color(0xFF075E6B),
    lime = Color(0xFFC5E86C),
    pale = Color(0xFFDDECEF),
    ink = Color(0xFF142B34),
    muted = Color(0xFF5B737A);
Widget label(
  String text, {
  double size = 16,
  Color color = ink,
  FontWeight weight = FontWeight.w400,
}) => Text(
  text,
  textAlign: TextAlign.center,
  style: TextStyle(
    fontFamily: 'Zain',
    fontSize: size,
    height: 1.4,
    color: color,
    fontWeight: weight,
  ),
);
Widget pill(String text, {Color color = petrol, Color bg = pale}) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(30)),
  child: label(text, size: 14, color: color, weight: FontWeight.w700),
);
Widget button(String text, VoidCallback onPressed) => Semantics(
  button: true,
  child: InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: petrol,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          label(text, size: 19, color: Colors.white, weight: FontWeight.w700),
          const SizedBox(width: 12),
          const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
    ),
  ),
);
Widget itemCard(
  IconData icon,
  String title, {
  Color bg = Colors.white,
  Color color = petrol,
  double angle = 0,
}) => Transform.rotate(
  angle: angle,
  child: Container(
    width: 141,
    height: 178,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: petrol.withValues(alpha: .09)),
    ),
    child: Column(
      children: [
        Expanded(
          child: Center(child: Icon(icon, size: 68, color: color)),
        ),
        const SizedBox(height: 10),
        label(
          title,
          size: 15,
          color: bg == petrol ? Colors.white : ink,
          weight: FontWeight.w700,
        ),
      ],
    ),
  ),
);
Widget art(int i) => SizedBox(
  height: 320,
  width: 342,
  child: Stack(
    alignment: Alignment.center,
    children: [
      Positioned(
        top: 15,
        child: Container(
          width: 290,
          height: 290,
          decoration: BoxDecoration(
            color: pale,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      Positioned(
        top: 19,
        right: 20,
        child: Icon(
          Icons.auto_awesome_rounded,
          color: petrol.withValues(alpha: .25),
          size: 26,
        ),
      ),
      Positioned(
        bottom: 24,
        left: 24,
        child: Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(color: lime, shape: BoxShape.circle),
        ),
      ),
      if (i == 0) ...[
        Positioned(
          top: 53,
          right: 13,
          child: itemCard(Icons.menu_book_rounded, 'كتب خلّصتها', angle: .10),
        ),
        Positioned(
          top: 83,
          left: 13,
          child: itemCard(
            Icons.headphones_rounded,
            'حاجة محتاجها',
            bg: petrol,
            color: lime,
            angle: -.10,
          ),
        ),
        Positioned(
          top: 77,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: lime,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF3F7F8), width: 6),
            ),
            child: const Icon(
              Icons.swap_horiz_rounded,
              color: petrol,
              size: 32,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: pill('من غير بيع ولا شراء', bg: Colors.white),
        ),
      ] else if (i == 1) ...[
        Positioned(
          top: 32,
          child: Transform.rotate(
            angle: -.045,
            child: Container(
              width: 224,
              height: 254,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: pale),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 134,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF5E0),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Icon(
                      Icons.draw_rounded,
                      color: petrol,
                      size: 69,
                    ),
                  ),
                  const SizedBox(height: 12),
                  label('أدوات رسم', size: 20, weight: FontWeight.w700),
                  label('أبدّلها بكتاب', size: 15, color: muted),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 28,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: lime,
              borderRadius: BorderRadius.circular(21),
            ),
            child: const Icon(
              Icons.add_a_photo_outlined,
              color: petrol,
              size: 30,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 5,
          child: pill('صورة واضحة + وصف بسيط', bg: petrol, color: Colors.white),
        ),
      ] else ...[
        Positioned(
          top: 46,
          right: 4,
          child: Container(
            width: 237,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: pale,
                  child: Icon(Icons.person_outline_rounded, color: petrol),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: label(
                    'يناسبك نبدّل بكرة؟',
                    size: 18,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 133,
          left: 2,
          child: Container(
            width: 233,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            decoration: BoxDecoration(
              color: petrol,
              borderRadius: BorderRadius.circular(23),
            ),
            child: label(
              'تمام، نتقابل في مكان عام',
              size: 17,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 26,
          right: 34,
          child: Container(
            width: 66,
            height: 66,
            decoration: const BoxDecoration(
              color: lime,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.handshake_outlined,
              color: petrol,
              size: 33,
            ),
          ),
        ),
        Positioned(
          bottom: 34,
          left: 29,
          child: pill('اتفاق واضح للطرفين', bg: Colors.white),
        ),
      ],
    ],
  ),
);
Widget dalilSplashContent() => Scaffold(
  backgroundColor: const Color(0xFFF3F7F8),
  body: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      children: [
        const Spacer(flex: 5),
        const DalilLogo(size: 144),
        const SizedBox(height: 25),
        const Text(
          'دليل',
          style: TextStyle(
            fontFamily: 'Changa',
            fontSize: 54,
            fontWeight: FontWeight.w800,
            color: petrol,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        label('اللي عندك، ممكن ينفع غيرك', size: 21, color: muted),
        const Spacer(flex: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: i == 1 ? 25 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: i == 1 ? petrol : pale,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        label('تبادل أبسط. فايدة أكتر.', size: 15, color: muted),
        const SizedBox(height: 35),
      ],
    ),
  ),
);
Widget dalilOnboardingPage(
  int i, {
  required VoidCallback onNext,
  required VoidCallback onSkip,
}) {
  const headings = [
    'حاجتك ليها فرصة تانية',
    'صوّرها، وقول عايز إيه',
    'اتفقوا، وبدّلوا بسهولة',
  ];
  const bodies = [
    'كتب خلّصتها أو أدوات مش بتستخدمها؟\nبدّلها بحاجة تحتاجها من مجتمع الجامعة.',
    'ضيف صور واضحة، واكتب حالة حاجتك\nونفسك تبدّلها بإيه. إعلانك بقى جاهز.',
    'ابعت طلب تبديل واتكلموا في الشات.\nاختاروا معاد ومكان عام يناسبكم.',
  ];
  return Scaffold(
    backgroundColor: const Color(0xFFF3F7F8),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 25, 24, 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DalilLogo(size: 35),
                TextButton(
                  onPressed: onSkip,
                  child: label('تخطي', size: 16, color: muted),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    FittedBox(fit: BoxFit.scaleDown, child: art(i)),
                    const SizedBox(height: 23),
                    pill(
                      'الخطوة ${['١', '٢', '٣'][i]} من ٣',
                      bg: Colors.transparent,
                    ),
                    const SizedBox(height: 5),
                    label(headings[i], size: 30, weight: FontWeight.w700),
                    const SizedBox(height: 13),
                    label(bodies[i], size: 19, color: muted),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (j) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: j == i ? 25 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: j == i ? petrol : pale,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            button(i == 2 ? 'يلا نبدأ' : 'التالي', onNext),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: i == 2 ? onSkip : null,
              child: label(
                i == 2 ? 'عندك حساب؟ سجّل دخولك' : 'بدّل حاجاتك، مش فلوسك',
                size: 15,
                color: muted,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
