import 'package:flutter/material.dart';
import 'package:thimar_course/models/notifications.dart';

class NotificationsPage extends StatelessWidget {
  List<NotificationsModel> list=[
    NotificationsModel(image: 'https://cdn-icons-png.flaticon.com/512/149/149071.png', title: 'نمشيمبسيمنتبمتب', description: "نمشيمبسيمنتبمتب نمشيمبسيمنتبمتب نمشيمبسيمنتبمتبنمشيمبسيمنتبمتب نمشيمبسيمنتبمتب", time: "منذ ساعتان"),
    NotificationsModel(image: 'https://cdn-icons-png.flaticon.com/512/149/149071.png', title: 'نمشيمبسيمنتبمتب', description: "نمشيمبسيمنتبمتب نمشيمبسيمنتبمتب نمشيمبسيمنتبمتبنمشيمبسيمنتبمتب نمشيمبسيمنتبمتب", time: "منذ ساعتان"),
    NotificationsModel(image: 'https://cdn-icons-png.flaticon.com/512/149/149071.png', title: 'نمشيمبسيمنتبمتب', description: "نمشيمبسيمنتبمتب نمشيمبسيمنتبمتب نمشيمبسيمنتبمتبنمشيمبسيمنتبمتب نمشيمبسيمنتبمتب", time: "منذ ساعتان"),
  ];
    NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text("الاشعارات"),

      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20,),
        itemBuilder: (context, index) =>   ItemNotifications(notificationsModel: list[index],),
      ),
    );
  }
}




class ItemNotifications extends StatelessWidget {
  final NotificationsModel notificationsModel;
  const  ItemNotifications({Key? key, required this.notificationsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   const EdgeInsetsDirectional.only(bottom: 6,start:10 ,end:10 ,top: 11, ),
      child: DecoratedBox(

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 5),
              color: Color(0x01000000),
            )
          ],
        ),
        child:   Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      DecoratedBox(

          decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.13),
        borderRadius: BorderRadius.circular(9)
      ),
      child: Image.network(notificationsModel.image,width: 19.5,height: 19.5,errorBuilder: (context,error,stackTrace)=>const Text("404"),)),
            const SizedBox(width: 10,),
              Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(notificationsModel.title,style: const TextStyle(
                    fontSize: 12,fontWeight: FontWeight.w400,

                  ),),const SizedBox(height: 4,),
                  Text(notificationsModel.description,style: const TextStyle(fontSize: 10,color: Color(0xff989898)),),const SizedBox(height: 6 ,),
                  Text(notificationsModel.time,style: const TextStyle(fontSize: 10),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
