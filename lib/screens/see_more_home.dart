import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../core/design/widgets/icon_with_bg.dart';
import '../core/logic/helper_methods.dart';
import '../features/categories/bloc.dart';
import 'category_products.dart';

class SeeMoreHomeScreen extends StatefulWidget {
  const SeeMoreHomeScreen({Key? key}) : super(key: key);

  @override
  State<SeeMoreHomeScreen> createState() => _SeeMoreHomeStateScreen();
}

class _SeeMoreHomeStateScreen extends State<SeeMoreHomeScreen> {
  final bloc = KiwiContainer().resolve<CategoriesBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(GetCategoriesDataEvent());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(

        title: Text(
          "الأقسام",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
         centerTitle: true,leadingWidth: 70.w,
        leading: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 16,vertical: 4 ),
          child: IconWithBg(
            icon: Icons.arrow_back_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body:   BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (state is CategoriesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is CategoriesSuccessState) {
            return SizedBox(

              child:  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 16.w,

                ),
                scrollDirection: Axis.vertical,
                itemCount: state.list.data.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    navigateTo(CategoryProductsScreen(
                      title: state.list.data[index].name, id: state.list.data[index].id,
                    ));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.all(16),
                          child: Image.network(
                            state.list.data[index].media,
                            fit: BoxFit.fill,
                            width: 102,
                            height: 105.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        state.list.data[index].name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
