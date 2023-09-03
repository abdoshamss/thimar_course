import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/screens/home_nav/widgets/MainAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "https://assets-global.website-files.com/5f6cc9cd16d59d990c8fca33/64c97a533d276d58c28b32a4_list-of-fruits.jpg",
    "https://assets-global.website-files.com/5f6cc9cd16d59d990c8fca33/64c97a533d276d58c28b32a4_list-of-fruits.jpg",
    "https://assets-global.website-files.com/5f6cc9cd16d59d990c8fca33/64c97a533d276d58c28b32a4_list-of-fruits.jpg",
    "https://assets-global.website-files.com/5f6cc9cd16d59d990c8fca33/64c97a533d276d58c28b32a4_list-of-fruits.jpg",
  ];
  List<String> imagesOfCategoreies = [
    "https://domf5oio6qrcr.cloudfront.net/medialibrary/11499/3b360279-8b43-40f3-9b11-604749128187.jpg",
    "https://domf5oio6qrcr.cloudfront.net/medialibrary/11499/3b360279-8b43-40f3-9b11-604749128187.jpg",
    "https://domf5oio6qrcr.cloudfront.net/medialibrary/11499/3b360279-8b43-40f3-9b11-604749128187.jpg",
    "https://domf5oio6qrcr.cloudfront.net/medialibrary/11499/3b360279-8b43-40f3-9b11-604749128187.jpg",
    "https://domf5oio6qrcr.cloudfront.net/medialibrary/11499/3b360279-8b43-40f3-9b11-604749128187.jpg",

  ];
  List<String> namesOfCategories = [
    "الخضار",
    "الفاكهة",
    "اللحوم",
    "المانجا",
    "المانجا",
    ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Input(
              inputType: InputType.search,
              iconPath: "assets/icons/search.jpg",
              hintText: "ابحث عما تريد؟",
            ),
          ),
          // SizedBox( height: 165.h,
          //   child: PageView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 4,
          //     itemBuilder: (context, index) => Image.network(
          //       "https://assets-global.website-files.com/5f6cc9cd16d59d990c8fca33/64c97a533d276d58c28b32a4_list-of-fruits.jpg",
          //       width: 375.w,
          //
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),

          SizedBox(
            height: 165.h,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 164.0,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  currentIndex = index;
                  setState(() {});
                },
              ),
              items: List.generate(
                  images.length,
                  (index) => Image.network(
                        images[index],
                        height: 164.h,
                        fit: BoxFit.fill,
                      )),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                (index) => Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.w),
                      child: CircleAvatar(
                        radius: 3.5.w,
                        backgroundColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(currentIndex == index ? 1 : .38),
                      ),
                    )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الأقسام",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "عرض الكل",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 135.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: namesOfCategories.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffa12cff * (index + 20)),
                          borderRadius: BorderRadius.circular(10.r)),
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                        fit: BoxFit.fill,
                        imagesOfCategoreies[index],
                        width: 102,
                        height: 105.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    namesOfCategories[index],
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 16.w,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Text(
              "الأصناف",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 160 / 250,
              crossAxisSpacing: 16.h,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.02),
                    offset: const Offset(0, 2),
                    blurRadius: 11.r,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11.r),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg",
                            fit: BoxFit.fill,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(11.r)),
                            ),
                            child: Text(
                              "-45%",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Text(
                          "طماطم",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "السعر / ١كجم",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "45 ر.س",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: " 65 ر.س",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ]),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Btn(
                    text: "أضف للسلة",
                    onPress: () {},
                    isBig: false,
                    // type: BtnType.outline,
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
