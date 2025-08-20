import 'package:flutter/material.dart';

import '../../../../../core/remote/network/FirestoreManager.dart';
import '../../../../../core/resources/ColorManager.dart';
import '../../../../../model/Event.dart';
import '../widgets/EventItem.dart';

class SportView extends StatefulWidget {
  const SportView({super.key});

  @override
  State<SportView> createState() => _SportViewState();
}

class _SportViewState extends State<SportView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreManager.getFilteredEventsRealTime("sport"),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          // loading
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          // error handling
          return Column(children: [
            Text(snapshot.error.toString(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: ColorManager.blackColor
            )),
            ElevatedButton(onPressed: (){
              setState(() {

              });
            }, child: Text("Refresh"))
          ],);
        }
        // handle success
        List<Event> events = snapshot.data??[];
        if(events.isEmpty){
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Events Found",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: ColorManager.blackColor
              ),),
              ElevatedButton(onPressed: (){
                setState(() {

                });
              }, child: Text("Refresh"))
            ],);
        }
        return ListView.separated(
            itemBuilder: (context, index) => EventItem(events[index]),
            separatorBuilder: (context, index) => SizedBox(height: 16,),
            itemCount: events.length);
      },
    );
  }
}
