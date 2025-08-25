import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/event_details/screen/event_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/DialogUtils.dart';
import '../../../../../core/providers/UserProvider.dart';
import '../../../../../core/remote/network/FirestoreManager.dart';
import '../../../../../core/resources/ColorManager.dart';
import '../../../../../model/Event.dart';

class EventItem extends StatefulWidget {
  Event event;
  bool isLoveTab;
  EventItem(this.event,{this.isLoveTab = false,super.key});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    print(widget.event.id);
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(EventDetails.routeName,arguments: widget.event);
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(8),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage(getEventTypePath(widget.event.type!)),
              fit: BoxFit.fitHeight
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Text(widget.event.date!.toDate().day.toString(),style: Theme.of(context).textTheme.titleSmall,),
                  Text(DateFormat.MMM().format(widget.event.date!.toDate()),style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14
                  )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10
              ),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(widget.event.title!,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                 InkWell(
                   onTap: ()async{
                     if(widget.isLoveTab){
                       List<String> favorites = provider.user?.favorites??[];
                       await FirestoreManager.removeEventFavorite(FirebaseAuth.instance.currentUser!.uid, widget.event);
                       print(widget.event.id!);
                       favorites.remove(widget.event.id!);
                       await FirestoreManager.updateUserFavorites(FirebaseAuth.instance.currentUser!.uid, favorites);
                       print(provider.user?.favorites);

                     }else{
                       addOrRemoveFavorite(provider.user?.favorites??[]);
                     }
                   },
                   child: SvgPicture.asset(provider.user?.favorites?.contains(widget.event.id!)??false
                       ?"assets/images/heart_selected.svg"
                     :"assets/images/heart.svg",

                     colorFilter: ColorFilter.mode(
                       Theme.of(context).colorScheme.primary, BlendMode.srcIn),),
                 )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addOrRemoveFavorite(List<String> favorites)async{
    if(favorites.contains(widget.event.id)){
      // delete event from wishlist
      DialogUtils.showLoadingDialog(context);
      await FirestoreManager.removeEventFavorite(FirebaseAuth.instance.currentUser!.uid, widget.event);
      print(widget.event.id!);
      favorites.remove(widget.event.id!);
      await FirestoreManager.updateUserFavorites(FirebaseAuth.instance.currentUser!.uid, favorites);
      Navigator.pop(context);
      setState(() {
      });
    }else{
      // add event in wishlist
      DialogUtils.showLoadingDialog(context);
      await FirestoreManager.addEventFavorite(FirebaseAuth.instance.currentUser!.uid, widget.event);
      favorites.add(widget.event.id!);
      await FirestoreManager.updateUserFavorites(FirebaseAuth.instance.currentUser!.uid, favorites);
      Navigator.pop(context);
      setState(() {
      });
    }
    print(favorites);
  }

  String getEventTypePath(String type){
    if(type == "sport") {
      return "assets/images/sport.png";
    }else if(type=="birthday"){
      return "assets/images/birthday.png";
    }else{
      return "assets/images/Book Club.png";
    }
  }
}
