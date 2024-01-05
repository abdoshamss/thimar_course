part of'bloc.dart';

class CompleteOrderStates {}

class CompleteOrderLoadingState extends CompleteOrderStates {}

class CompleteOrderSuccessState extends CompleteOrderStates {
  CompleteOrderSuccessState(){
    showModalBottomSheet(
        context: navigatorKey.currentContext!,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(38.r),
                topRight: Radius.circular(38.r))),
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.asset(
                        Assets.images.orderFinished.path,
                        width: 250.w,
                        height: 225.h,
                      )),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                     LocaleKeys.complete_order_thank_you.tr(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    LocaleKeys.complete_order_you_can_follow.tr(),
                    style: TextStyle(
                      color: const Color(0xffACACAC),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(  HomeNavScreen(currentPage: 1,));
                          FocusManager.instance.primaryFocus
                              ?.unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(165.w, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15.r),
                          ),
                        ),
                        child:   Center(
                          child: Text(
                           LocaleKeys.home_nav_my_orders.tr(),
                            style:const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(HomeNavScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(165.w, 60.h),
                          side: BorderSide(
                            color:
                            Theme.of(context).primaryColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.home_nav_main_page.tr(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CompleteOrderErrorState extends CompleteOrderStates {
  final int? statusCode;
  final String message;

  CompleteOrderErrorState({required this.statusCode, required this.message}){
    showMessage(message,messageType: MessageType.error);
  }

}