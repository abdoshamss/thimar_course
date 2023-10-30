part of 'bloc.dart';

class AddToCartStates {}

class AddToCartLoadingState extends AddToCartStates {}

class AddToCartSuccessState extends AddToCartStates {
  final String message;
  AddToCarData list;

  AddToCartSuccessState({required this.message, required this.list}) {
    //showMessage(message);
    showModalBottomSheet(
        context: navigatorKey.currentContext!,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(38.r),
                topRight: Radius.circular(38.r))),
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(Assets.icons.tickSquare.path),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "تم إضافة المنتج بنجاح",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Divider(
                      color: const Color(0xffEFEFEF),
                      height: .3.h,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70.w,
                        height: 65.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.r),
                            image: DecorationImage(
                                image: NetworkImage(list.data.image),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        children: [
                          Text(
                            list.data.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "الكمية : ${list.data.amount}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp,
                              color: const Color(0xff7E7E7E),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "${list.data.price}ر.س",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Divider(
                      color: const Color(0xffEFEFEF),
                      height: .3.h,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(  CartScreen());
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(160.w, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "التحويل إلى السلة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(160.w, 50.h),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "تصفح العروض",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class AddToCartErrorState extends AddToCartStates {
  final String message;
  final int statusCode;

  AddToCartErrorState({required this.message, required this.statusCode}) {
    showMessage(message, messageType: MessageType.error);
  }
}
