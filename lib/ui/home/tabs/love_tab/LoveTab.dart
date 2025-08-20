import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/remote/network/FirestoreManager.dart';
import '../../../../core/resources/ColorManager.dart';
import '../../../../model/Event.dart';
import '../home_tab/widgets/EventItem.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreManager.getMyWishlist(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  // loading
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  // error handling
                  return Container(
                    width: double.infinity,
                    child: Column(children: [
                      Text(snapshot.error.toString(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorManager.blackColor
                      )),
                      ElevatedButton(onPressed: (){
                        setState(() {

                        });
                      }, child: Text("Refresh"))
                    ],),
                  );
                }
                // handle success
                List<Event> events = snapshot.data??[];
                if(events.isEmpty){
                  return  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Events Found",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: ColorManager.blackColor
                        ),),
                        ElevatedButton(onPressed: (){
                          setState(() {

                          });
                        }, child: Text("Refresh"))
                      ],),
                  );
                }
                return ListView.separated(
                    itemBuilder: (context, index) => EventItem(
                      events[index],
                      isLoveTab: true,
                      key: ValueKey(events[index].id),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 16,),
                    itemCount: events.length);
              },
            ),
          ),
        ],
      ),
    );
  }
}
