import 'package:abshia/resources/image_manager.dart';

class DummyUserModel{
  final String fullName;
  final String regDate;
  final String avatar;

  DummyUserModel({required this.fullName, required this.regDate, required this.avatar});
}

List<DummyUserModel> dummyUsers = [
  DummyUserModel(fullName: "Jude Damut", regDate: "May 12, 2022 | 8:00 am", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Smart Ray", regDate: "May 12, 2022 | 8:00 am", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Linda Mike", regDate: "May 12, 2022 | 8:00 am", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Felicia Kenneth", regDate: "May 12, 2022 | 9:00 am", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Palang Mangut", regDate: "May 12, 2022 | 10:00 am", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Ariel Granny", regDate: "May 12, 2022 | 11:00 am", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Star Sus", regDate: "May 12, 2022 | 12:00 pm", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Alice Sambo", regDate: "May 12, 2022 | 1:00 pm", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Asake Kayode", regDate: "May 12, 2022 | 2:00 pm", avatar: AppImages.dummyAvatar),
  DummyUserModel(fullName: "Phill Philips", regDate: "May 12, 2022 | 4:00 pm", avatar: AppImages.dummyAvatar),
];