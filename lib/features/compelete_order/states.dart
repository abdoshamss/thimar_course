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
                    "شكرا لك لقد تم تنفيذ طلبك بنجاح",
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
                    "يمكنك متابعة حالة الطلب او الرجوع للرئيسية",
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
                          // navigateTo(  CartScreen());
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
                        child: const Center(
                          child: Text(
                            "طلباتي",
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
                            "الرئيسية",
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