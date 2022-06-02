

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/functions.dart';
import 'package:giveawayui/models/all_event_model.dart';
import '../colors.dart';
import '../widgets.dart';
import '/components/CategoryTile.dart';
import '/components/EventTile.dart';
import '/size_config.dart';
import 'package:google_fonts/google_fonts.dart';


class AllEvents extends StatefulWidget {

  @override
  _AllEventsState createState() => _AllEventsState();
}


class _AllEventsState extends State<AllEvents> {

  @override
  void initState() {
    controller.getAllEvents();
    super.initState();
  }

  final _ = Get.put(EventController());
  final controller = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Color(0xFF3F51B5), onPressed: () => Get.back(),
                    ),

                    Container(
                      height: 40,
                      width: getProportionateScreenWidth(200),
                      child: TextFormField(
                        onChanged: (value){
                        },
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Color(0xff38A3A5),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xff38A3A5),),
                            fillColor: Color(0xFFEDF5F9),
                            filled: true,
                          hintText: 'Search...',
                          hintStyle: TextStyle(fontSize: 14.0, color: Color(0xff38A3A5)),
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                            gapPadding: 10,
                          ),
                        ),
                      ),
                    ),
                    Image.asset('assets/ex.png',
                      color: Color(0xFF3F51B5))
                  ],
                ),
        ),
              
      ),
      body:SafeArea(
        child: Container(
          // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(30.0),),
              Container(
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: Get.width * 0.05),
                          child: CategoryTile(category: 'Party', margin: 14.0,color:0xFFF4F2F2),
                        ),
                        CategoryTile(category: 'Wedding', margin: 14.0,color:0xFFE0E7CC),
                        CategoryTile(category: 'Concert', margin: 14.0,color: 0xFFF5F5F8),
                        CategoryTile(category: 'Birthday', margin: 14.0,color: 0xFFEDF5F9),
                        CategoryTile(category: 'Naming Celebration', margin: 14.0,color: 0xFFF5F5F8),
                        CategoryTile(category: 'Religious Event', margin: 14.0,color: 0xFFE0E7CC),
                        CategoryTile(category: 'Others', margin: 14.0,color: 0xFFEDF5F9),
                      ]
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30.0),),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.1),
                child: Text(
                  'Happening Now',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 22, 12, 12),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30.0),),
               Expanded(
                child: Obx(() {
                  return controller.isLoadingInit.value
                      ? loadingDash()
                      : !controller.dataIsLoaded.value
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Error loading transactions"),
                                ElevatedButton(
                                    onPressed: controller.getAllEvents,
                                    child: Text('Refresh'))
                              ],
                            ))
                          : Stack(
                              children: [
                                Column(
                                  children: [
                                    MediaQuery.removePadding(
                                      removeTop: true,
                                      context: context,
                                      child: Expanded(
                                        child: ListView.builder(
                                            controller: controller.scrollController,
                                            itemCount: controller.allEvents.length,
                                            itemBuilder: (context, index) {
                                              return EventTile( event: controller.allEvents[index] );
                  
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    bottom: 20,
                                    left: Get.width * .49,
                                    child: Obx(() => controller.isLoadedMore.value ? loadingDash() : Container() )
                          )],);
                }),
              ),
            ],
          ),
        ),
      )
    );
  }

  
}

class EventController extends GetxController {

  
  RxList allEvents = [].obs;
  RxBool isLoadingInit = false.obs;
  RxBool dataIsLoaded = false.obs;
  RxBool isLoadedMore = false.obs;
  final scrollController = ScrollController();

  Future<dynamic> getAllEvents({int page = 1, String? type, int limit = 10}) async {
    isLoadingInit.value = true;
    var response = await httpGet(url: 'https://spray-dev.herokuapp.com/api/events/?limit=$limit&page=$page');

    if(response['status'] != 200) {
      isLoadingInit.value = false;
      return;
    }

    if (response['status'] == 200) {
        AllEventModel? tEvent = new AllEventModel.fromJson(response);
        if (tEvent.data!.length > 0) {
          print(tEvent.data![0].name);
          allEvents.value = tEvent.data!;
          isLoadingInit.value = false;
          dataIsLoaded.value = true;
        }

        isLoadingInit.value = false;
        return null;
    }

    
    isLoadingInit.value = false;
  }    
}
