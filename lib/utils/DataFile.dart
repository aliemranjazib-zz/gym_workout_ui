import 'package:flutter/cupertino.dart';
import 'package:healtho_app/model/HealthModel.dart';
import 'package:healtho_app/model/IntroModel.dart';
import 'package:healtho_app/model/NotificationModel.dart';
import 'package:healtho_app/model/WorkoutModel.dart';
import 'package:healtho_app/model/ServicesModel.dart';
import 'package:healtho_app/model/SliderModel.dart';

class DataFile {
  static String htmlData =
      r"<h5>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vestibulum sapien feugiat lorem tempor, id porta orci elementum. Fusce sed justo id arcu egestas congue. Fusce tincidunt lacus ipsum, in imperdiet felis ultricies eu. In ullamcorper risus felis, ac maximus dui bibendum vel. Integer ligula tortor, facilisis eu mauris ut, ultrices hendrerit ex. Donec scelerisque massa consequat, eleifend mauris eu, mollis dui. Donec placerat augue tortor, et tincidunt quam tempus non. Quisque sagittis enim nisi, eu condimentum lacus egestas ac. Nam facilisis luctus ipsum, at aliquam urna fermentum a. Quisque tortor dui, faucibus in ante eget, pellentesque mattis nibh. In augue dolor, euismod vitae eleifend nec, tempus vel urna. Donec vitae augue accumsan ligula fringilla ultrices et vel ex.</h5>";

  static List<NotificationModel> getNotificationList() {
    List<NotificationModel> subCatList = [];

    NotificationModel mainModel = new NotificationModel();
    mainModel.time = "08:30 PM";
    mainModel.title = "Lorem Ipsum";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    subCatList.add(mainModel);

    mainModel = new NotificationModel();
    mainModel.time = "08:30 PM";
    mainModel.title = "Lorem Ipsum";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    subCatList.add(mainModel);

    mainModel = new NotificationModel();
    mainModel.time = "08:30 PM";
    mainModel.title = "Lorem Ipsum";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    subCatList.add(mainModel);
    mainModel = new NotificationModel();
    mainModel.time = "08:30 PM";
    mainModel.title = "Lorem Ipsum";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    subCatList.add(mainModel);
    mainModel = new NotificationModel();
    mainModel.time = "08:30 PM";
    mainModel.title = "Lorem Ipsum";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<IntroModel> getIntroModel(BuildContext context) {
    List<IntroModel> introList = [];

    IntroModel mainModel = new IntroModel();
    mainModel.id = 1;
    mainModel.name = "Workout any where";
    mainModel.image = "assets/imgs/build_peaking_biceps.webp";
    // mainModel.image = "assets/imgs/intro_1.jpg";
    mainModel.desc =
        "Don't wait until you've reached your goal to be proud of yourself. Be proud of every step you take toward reaching that goal.";
    introList.add(mainModel);

    mainModel = new IntroModel();
    mainModel.id = 2;
    mainModel.name = "Stay Strong & healthy";
    mainModel.image = "assets/imgs/hips.png";
    mainModel.desc =
        "When you're at the gym feeling like you'll never be one of those people who look like they've been at it their entire lives, remember that they all started somewhere.";
    introList.add(mainModel);

    mainModel = new IntroModel();
    mainModel.id = 3;
    mainModel.name = "Customize workout plan";
    mainModel.image = "assets/imgs/triceps.png";
    mainModel.desc =
        "The same voice that says give up can also be trained to say keep going";
    introList.add(mainModel);

    return introList;
  }

  static getSliderDetail() {
    List<SliderModel> list = [];

    SliderModel sliderModel = new SliderModel();
    sliderModel.id = 1;
    sliderModel.image = "full_body_challenge.png";
    sliderModel.title = "Special Program";
    sliderModel.subTitle = "Super pump biceps workout";
    list.add(sliderModel);

    sliderModel = new SliderModel();
    sliderModel.id = 2;
    sliderModel.title = "Special Program";
    sliderModel.image = "special_program_1.png";

    sliderModel.subTitle = "Warm up and stretching";
    list.add(sliderModel);

    sliderModel = new SliderModel();
    sliderModel.id = 3;
    sliderModel.image = "special_program_2.png";
    sliderModel.title = "Special Program";
    sliderModel.subTitle = "Weight Loss";
    list.add(sliderModel);

    return list;
  }

  static getHealthList() {
    List<HealthModel> list = [];

    HealthModel healthModel = new HealthModel();
    healthModel.title = "Don't train everyday";
    healthModel.image = "healthy_5.jpg";
    // healthModel.image ="healthy_1.jpg";
    healthModel.time = "2 Months ago";
    healthModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    list.add(healthModel);

    healthModel = new HealthModel();
    healthModel.title = "Stick to free weights";
    healthModel.image = "healthy_2.jpg";
    healthModel.time = "5 Months ago";
    healthModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    list.add(healthModel);

    healthModel = new HealthModel();
    healthModel.title = "Do Compound movements";
    healthModel.image = "healthy_3.jpg";
    healthModel.time = "2 Months ago";
    healthModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    list.add(healthModel);

    healthModel = new HealthModel();
    healthModel.title = "Can we eat paneer";
    healthModel.image = "healthy_4.jpg";
    healthModel.time = "5 Months ago";
    healthModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    list.add(healthModel);

    healthModel = new HealthModel();
    healthModel.title = "Is broccoli the  best for fitness?";
    healthModel.image = "healthy_1.jpg";
    healthModel.time = "3 Months ago";
    healthModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    list.add(healthModel);

    healthModel = new HealthModel();
    healthModel.title = "Is broccoli the  best for fitness?";
    healthModel.image = "healthy_6.jpg";
    healthModel.time = "5 Months ago";
    healthModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    list.add(healthModel);

    return list;
  }

  static getContinueList() {
    List<ServicesModel> list = [];

    ServicesModel servicesModel = new ServicesModel();
    servicesModel.id = 1;
    servicesModel.image = "build_peaking_biceps.webp";
    servicesModel.title = "Warm up &";
    servicesModel.subTitle = "Stretching";
    list.add(servicesModel);

    servicesModel = new ServicesModel();
    servicesModel.id = 2;
    servicesModel.image = "sit_ups_challenge.webp";
    servicesModel.title = "Muscle";
    servicesModel.subTitle = "Building";
    list.add(servicesModel);

    servicesModel = new ServicesModel();
    servicesModel.id = 3;
    servicesModel.image = "workout_for_beginners.webp";
    servicesModel.title = "Fat";
    servicesModel.subTitle = "Loss";
    list.add(servicesModel);

    return list;
  }

  static getServiceList() {
    List<ServicesModel> list = [];

    ServicesModel servicesModel = new ServicesModel();
    servicesModel.id = 1;
    servicesModel.image = "hips.png";
    servicesModel.title = "Warm up &";
    servicesModel.subTitle = "Stretching";
    list.add(servicesModel);

    servicesModel = new ServicesModel();
    servicesModel.id = 2;
    servicesModel.image = "hips.png";
    servicesModel.title = "Muscle";
    servicesModel.subTitle = "Building";
    list.add(servicesModel);

    servicesModel = new ServicesModel();
    servicesModel.id = 3;
    servicesModel.image = "hips.png";
    servicesModel.title = "Fat";
    servicesModel.subTitle = "Loss";
    list.add(servicesModel);

    return list;
  }

  static getWorkoutModelList() {
    List<WorkoutModel> list = [];

    WorkoutModel workoutModel = new WorkoutModel();
    workoutModel.image = "run_5km_challenge.webp";
    workoutModel.title = "20 Min.Burn Fat-Intermediate";
    workoutModel.subTitle = "Fat Loss(No Equipment)";
    list.add(workoutModel);

    workoutModel = new WorkoutModel();
    workoutModel.image = "run_40_challenge.jpg";
    workoutModel.title = "20 Min.Burn Fat-Beginner";

    list.add(workoutModel);

    workoutModel = new WorkoutModel();
    workoutModel.image = "run_5km_challenge.webp";
    workoutModel.title = "20 Min.Fat Blast workout-Intermediate";
    workoutModel.subTitle = "Fat Loss(Minimum Equipment)";
    list.add(workoutModel);

    workoutModel = new WorkoutModel();
    workoutModel.image = "run_40_challenge.jpg";
    workoutModel.title = "20 Min.Fat Blast workout-Beginner";
    list.add(workoutModel);

    workoutModel = new WorkoutModel();
    workoutModel.image = "run_5km_challenge.webp";
    workoutModel.title = "20 Min.Fat Blast workout-Intermediate";
    list.add(workoutModel);

    workoutModel = new WorkoutModel();
    workoutModel.image = "run_40_challenge.jpg";
    workoutModel.title = "20 Min.Fat Blast workout-Beginner";
    list.add(workoutModel);

    return list;
  }
}
