import 'InteractiveUsers.dart';

class InteractiveModel {

  InteractiveModel({
      this.interactiveUsers,});

  InteractiveModel.fromJson(dynamic json) {
    if (json['interactive_users'] != null) {
      interactiveUsers = [];
      json['interactive_users'].forEach((v) {
        interactiveUsers?.add(InteractiveUsers.fromJson(v));
      });
    }
  }

  List<InteractiveUsers>? interactiveUsers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (interactiveUsers != null) {
      map['interactive_users'] = interactiveUsers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}