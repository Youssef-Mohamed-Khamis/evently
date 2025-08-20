import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/DialogUtils.dart';
import '../../../core/remote/network/FirestoreManager.dart';
import '../../../core/resources/ColorManager.dart';
import '../../../core/reusable_components/CustomButton.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../model/Event.dart';
import '../widgets/EventType.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "create_event";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> with TickerProviderStateMixin {
  late TabController tabController ;
  int selectedIndex = 0;
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length:3, vsync: this);
    tabController.addListener(() {
      if(tabController.index!=selectedIndex){
        setState(() {
          selectedIndex = tabController.index;
        });
      }

    });
    titleController = TextEditingController();
    descController = TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          color: ColorManager.primaryColor
        ),
        iconTheme: IconThemeData(
          color: ColorManager.primaryColor
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 203,
            child: TabBarView(

                controller: tabController,
                children: [
              EventType("assets/images/sport.png"),
              EventType("assets/images/birthday.png"),
              EventType("assets/images/Book Club.png"),
            ]),
          ),
          SizedBox(height: 16,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key:formKey ,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                  
                          controller: tabController,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: Colors.red,
                          labelColor: Colors.white,
                          unselectedLabelColor: ColorManager.primaryColor,
                          dividerHeight: 0,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(46),
                              border: Border.all(color: ColorManager.primaryColor),
                              color: ColorManager.primaryColor
                          ),
                          tabs: [
                            Tab(
                              height: 50,
                  
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12
                                ),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(46),
                                    border: Border.all(color: ColorManager.primaryColor)
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/images/bike.svg",height: 24,width: 24,
                                      colorFilter: ColorFilter.mode(selectedIndex==0
                                          ?Colors.white
                                          :Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 3,),
                                    Text("Sport")
                                  ],
                                ),
                              ),),
                            Tab(
                              height: 50,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12
                                ),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(46),
                                    border: Border.all(color: ColorManager.primaryColor)
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/images/cake.svg",height: 24,width: 24,
                                      colorFilter: ColorFilter.mode(selectedIndex==1
                                          ?Colors.white
                                          :Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 3,),
                                    Text("Birthday")
                                  ],
                                ),
                              ),),
                            Tab(
                              height: 50,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12
                                ),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(46),
                                    border: Border.all(color: ColorManager.primaryColor)
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/images/book-open.svg",height: 24,width: 24,
                                      colorFilter: ColorFilter.mode(selectedIndex==2
                                          ?Colors.white
                                          :Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 3,),
                                    Text("Book Club")
                                  ],
                                ),
                              ),),
                          ]
                      ),
                      SizedBox(height: 16,),
                      Text("Title",style: Theme.of(context).textTheme.bodySmall,),
                      SizedBox(height: 8,),
                      CustomField(
                          keyboard: TextInputType.text,
                          hint: "Event Title",
                          prefix: "assets/images/Note_Edit.svg",
                          controller: titleController,
                          validation: (value) {
                            if(value==null || value.isEmpty){
                              return "shouldEmpty".tr();
                            }
                            return null;
                          },
                      ),
                      SizedBox(height: 16,),
                      Text("Description",style: Theme.of(context).textTheme.bodySmall,),
                      SizedBox(height: 8,),
                      CustomField(
                        keyboard: TextInputType.text,
                        maxLines: 5,
                        hint: "Event Description",
                        controller: descController,
                        validation: (value) {
                          if(value==null || value.isEmpty){
                            return "shouldEmpty".tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16,),
                      Row(children: [
                        SvgPicture.asset("assets/images/Calendar_Days.svg",colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn
                        ),),
                        SizedBox(width: 10,),
                        Text("Event Date",style: Theme.of(context).textTheme.bodySmall,),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            selectEventDate();
                          },
                          child: Text(selectedDate==null
                              ?"Choose Date"
                              :DateFormat.yMd().format(selectedDate!),style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorManager.primaryColor
                          ),),
                        ),


                      ],),
                      SizedBox(height: 16,),
                      Row(children: [
                        SvgPicture.asset("assets/images/Clock.svg",colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn
                        ),),
                        SizedBox(width: 10,),
                        Text("Event Time",style: Theme.of(context).textTheme.bodySmall,),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            selectEventTime();
                          },
                          child: Text(selectedTime==null?"Choose Time"
                              :"${selectedTime!.hourOfPeriod}:${selectedTime!.minute}${selectedTime!.period.name}",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorManager.primaryColor
                          ),),
                        ),


                      ],),
                      SizedBox(height: 16,),
                      Text("Event Time",style: Theme.of(context).textTheme.bodySmall,),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Theme.of(context).colorScheme.primary)
                        ),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8)
                                ),

                                child: SvgPicture.asset("assets/images/location.svg")),
                            SizedBox(width: 8,),
                            Expanded(
                              child: Text("Choose Event Location",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorManager.primaryColor
                              ),),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                                )
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(title: "Add Event", onClick: () async {
                          if(formKey.currentState!.validate()){
                            // Create New Event
                            if(selectedDate == null || selectedTime ==null){
                              DialogUtils.showToast("Please choose event date and time");
                            }else{
                              DialogUtils.showLoadingDialog(context);
                              await FirestoreManager.createNewEvent(Event(
                                title: titleController.text,
                                description: descController.text,
                                date: Timestamp.fromDate(DateTime(
                                    selectedDate!.year,
                                    selectedDate!.month,
                                    selectedDate!.day,
                                    selectedTime!.hour,
                                    selectedTime!.minute
                                )),
                                type: checkEventType(selectedIndex),
                              ));
                              Navigator.pop(context);
                              DialogUtils.showToast("Event created successfully");

                            }
                          }
                        },),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  String checkEventType(int selectedIndex){
    if(selectedIndex==0){
      return "sport";
    }else if(selectedIndex==1){
      return "birthday";
    }else{
      return "book";
    }
  }
  DateTime? selectedDate;
  void selectEventDate() async{
    var date = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        initialDate: selectedDate
    );
    if(date!=null){
      setState(() {
        selectedDate = date;
      });
    }

  }
  TimeOfDay? selectedTime;
  void selectEventTime()async{
    var time = await showTimePicker(context: context,
        initialTime: selectedTime==null?TimeOfDay.now():selectedTime!,

    );
    if(time!=null){
      setState(() {
        selectedTime = time;
      });
    }
  }
}
