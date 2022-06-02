import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/functions.dart';
import '../colors.dart';
import '../widgets.dart';
import '/components/DefaultButton.dart';
import '/constants.dart';
import '/screens/event_details.dart';
import '/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../http_exception.dart';

class CreateEvent extends StatefulWidget {
  static String routeName = "/createEvent";
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _ = Get.put(CreateEventController());
  final controller = Get.find<CreateEventController>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              splashColor: primaryColor.withOpacity(.6),
              highlightColor: white,
              onTap: () => Get.back(),
              child:
                  Ink(child: Icon(Icons.arrow_back_ios, color: primaryColor))),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(children: [
              Text(
                'Create Event',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Color(0xff3F51B5),
                        fontSize: 38.0,
                        fontWeight: FontWeight.w800)),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 8),
                    child: Text("Event Name"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value.toString().trim().isEmpty) {
                          return 'Field is required';
                        }

                        return null;
                      },
                      autofocus: true,
                      controller: controller.eventName,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff243656),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        //  fillColor: Colors.grey,
                        //   filled: true,
                        hintText: 'Sarah\'s Wedding',
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff3F51B5)),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff3F51B5)),
                          gapPadding: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 8),
                    child: Text("Event Description"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value.toString().trim().isEmpty) {
                          return 'Field is required';
                        }

                        return null;
                      },
                      autofocus: true,
                      controller: controller.eventDescription,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff243656),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700)),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        //  fillColor: Colors.grey,
                        //   filled: true,
                        hintText: 'Honor to sarah family',
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff3F51B5)),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff3F51B5)),
                          gapPadding: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Container(
                width: Get.width,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Obx(() {
                    return DropdownButton<String>(
                      underline: Container(),
                      value: controller.dropdownValue.value,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        controller.dropdownValue.value = newValue!;
                      },
                      items: eventType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300)),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * .2),
                    child: ListTile(
                        title: Text('Make Public'),
                        trailing: Switch.adaptive(
                          activeColor: green,
                          // trackColor: MaterialStateProperty.resolveWith((states) => green),
                          inactiveTrackColor: red,
                          inactiveThumbColor: red,
                          onChanged: (bool value) =>
                              controller.isPrivate.value = value,
                          value: controller.isPrivate.value,
                        )),
                  )),
              Obx(() => controller.isPrivate.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Padding(
                          padding: EdgeInsets.only(left: 40, bottom: 8),
                          child: Text("Event Pass Code"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextFormField(
                            validator: (String? value) {
                              if (controller.isPrivate.value) {
                                if (value.toString().trim().isEmpty) {
                                  return 'Field is required';
                                }
                              }
                              return null;
                            },
                            autofocus: true,
                            controller: controller.eventPassCode,
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Color(0xff243656),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700)),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              //  fillColor: Colors.grey,
                              //   filled: true,
                              hintText: 'Pass code',
                              contentPadding: EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xff3F51B5)),
                                gapPadding: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xff3F51B5)),
                                gapPadding: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()),
              SizedBox(height: getProportionateScreenHeight(40)),
              Obx(() => controller.isLoading.value
                  ? loadingDash()
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      child: DefaultButton(
                          text: 'Create', press: controller.createNewEvent),
                    ))
            ]),
          ),
        ));
  }
}

class CreateEventController extends GetxController {
  TextEditingController eventName = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController eventCategory = TextEditingController();
  TextEditingController eventPassCode = TextEditingController();
  String createEventUrl = "https://spray-dev.herokuapp.com/api/events/";
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isPrivate = false.obs;

  RxString dropdownValue = 'Event Type'.obs;

  sendRequest(url) async {
    var body = {
      "name": eventName.text,
      'category': dropdownValue.value,
      'description': eventDescription.text,
    };
    var bodyWithPass = {
      "name": eventName.text,
      'category': dropdownValue.value,
      'description': eventDescription.text,
      "passcode": eventPassCode.text,
    };

    var headers = {
      "Content-Type": "application/json",
      "x-auth-token": userModel.token!
    };

    var response = await httpPost(
        url: url, body: isPrivate.value ? bodyWithPass : body, header: headers);
    print(response.toString() + 'response');
    return response;
  }

  void createNewEvent() async {
    if (formKey.currentState!.validate() &&
        dropdownValue.value != 'Event Type') {
      print("valideate");
      isLoading.value = true;
      print('checking');
      //CREATING EVENT NAME
      var response = await sendRequest(createEventUrl);
      //if Error occurred
      if (response['status'] != 201) {
        alert(
            title: "Couldn't create event. ${response['message']}",
            isSuccess: false);
        isLoading.value = false;
        return;
      }

      //CHANGING EVENT STATUS TO ACTIVE
      String eventActiveUrl =
          "https://spray-dev.herokuapp.com/api/events/status?event_code=${response['event_code']}&event_status=active";
      var activateEvent = await sendRequest(eventActiveUrl);
      print(response);
      //if Error occurred
      if (activateEvent['status'] != 200) {
        alert(
            title: "Couldn't Change event status. ${activateEvent['message']}",
            isSuccess: false);
        isLoading.value = false;
        return;
      }

      eventName.clear();
      eventDescription.clear();
      dropdownValue.value = 'Event Type';
      generalFunction.updateSettings(setting: {
        'hasEvent': true,
        'lastEventTime': DateTime.now().millisecondsSinceEpoch,
        'eventDetails': {
          'message': response['message'],
          'is_private': isPrivate.value,
          'event_code': response['event_code'],
          'event_pass_code': eventPassCode.text
        }
      });
      print('$response activateEvent -----------');
      alert(
          title: 'Event created successfully',
          isSuccess: true,
          btnText: 'View Event Details',
          btnFunction: () {
            Get.back();
            Get.off(() => EventDetails(), arguments: response);
          });
      isLoading.value = false;
      return;
    }

    kErrorMessage(
        title: 'All fields are required',
        message: 'Please complete the above fields and select a event type');
    isLoading.value = false;

    return;
  }
}
