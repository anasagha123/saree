// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../network/remote/dio_helper.dart';
import '../screens/chose_service_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/login_screen.dart';
import '../screens/user_info_screen.dart';
import '../widgets/components/show_snack_bar.dart';

enum UserDataState {
  initial,
  loading,
  updatingUserPassword,
  deleteUser,
  done,
  error
}

class AuthProvider with ChangeNotifier {
  UserModel? user;
  UserDataState userDataState = UserDataState.initial;

  Future<void> login(
      BuildContext context, String phone, String password) async {
    Navigator.pushNamed(context, LoadingScreen.routeName);
    Map<String, dynamic> payload = {
      "phone": phone,
      "password": password,
    };

    try {
      await DioHelper.postData(
        path: EndPoints.log_in,
        data: payload,
      ).then((val) async {
        if (val.statusCode == 200 && val.data["status"] == "success") {
          DioHelper.setUserToken(val.data["token"]);
          await getUserInfo();
          Navigator.pushNamedAndRemoveUntil(
            context,
            ChoseServiceScreen.routeName,
                (route) => false,
          );
          showSnackBar(
            context: context,
            message: val.data["message"],
            state: SnackBarState.success,
          );
        } else {
          throw (val.data["message"] ?? "حدث خطأ الرجاء اعادة المحاولة");
        }
      });
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
        context: context,
        message: e.toString(),
        state: SnackBarState.error,
      );
    }
  }

  Future<void> signup(BuildContext context, String name, String phone,
      String password, String address) async {
    Navigator.pushNamed(context, LoadingScreen.routeName);

    Map<String, dynamic> payload = {
      "name": name,
      "phone": phone,
      "password": password,
      "address": address,
    };

    try {
      await DioHelper.postData(
        path: EndPoints.sign_up,
        data: payload,
      ).then((val) {
        if (val.statusCode == 200 && val.data["status"] == "success") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (route) => false,
          );
          showSnackBar(
            context: context,
            message: val.data["message"],
            state: SnackBarState.success,
          );
        } else {
          throw (val.data["message"] ?? "حدث خطأ الرجاء اعادة المحاولة");
        }
      });
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
        context: context,
        message: e.toString(),
        state: SnackBarState.error,
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    Navigator.pushNamed(context, LoadingScreen.routeName);
    try {
      await DioHelper.postData(
        path: EndPoints.log_out,
        headers: {"authorization": DioHelper.User_Token},
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            DioHelper.removeUserToken();
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
            showSnackBar(
              context: context,
              message: val.data["message"],
              state: SnackBarState.success,
            );
          } else {
            throw (val.data["message"] ?? "حدث خطأ الرجاء اعادة المحاولة");
          }
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
        context: context,
        message: e.toString(),
        state: SnackBarState.error,
      );
    }
  }

  Future<void> getUserInfo() async {
    userDataState = UserDataState.loading;
    notifyListeners();

    try {
      await DioHelper.getData(
        path: EndPoints.user_info,
        headers: {"authorization": DioHelper.User_Token},
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            user = UserModel.fromMap(val.data["user"]);
            userDataState = UserDataState.done;
            notifyListeners();
          } else {
            throw (val.data["message"] ?? "حدث خطأ الرجاء اعادة المحاولة");
          }
        },
      );
    } catch (e) {
      userDataState = UserDataState.error;
      notifyListeners();
    }
  }

  Future<void> deleteUser(BuildContext context) async {
    userDataState = UserDataState.deleteUser;
    notifyListeners();
    Navigator.pushNamed(context, LoadingScreen.routeName);
    try {
      await DioHelper.deleteData(
        path: EndPoints.delete_user,
        headers: {"authorization": DioHelper.User_Token},
      ).then(
        (val) async {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            userDataState = UserDataState.initial;
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
            showSnackBar(
                context: context,
                message: val.data["message"],
                state: SnackBarState.success);
          } else {
            throw (val.data["message"] ?? "حدث خطأ ما");
          }
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
          context: context, message: e.toString(), state: SnackBarState.error);
    }
  }

  Future<void> updatePassword(
      BuildContext context, String password, String new_password) async {
    if (password == new_password) {
      Navigator.pop(context);
      showSnackBar(
        context: context,
        message: "يجب ان تدخل كلمة مرور مختلفة عن كلمة مرورك الاصلية",
        state: SnackBarState.error,
      );
      return;
    }
    userDataState = UserDataState.updatingUserPassword;
    notifyListeners();
    Map<String, dynamic> payload = {
      "password": password,
      "new_password": new_password,
    };
    try {
      await DioHelper.postData(
        path: EndPoints.update_password,
        headers: {"authorization": DioHelper.User_Token},
        data: payload,
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            userDataState = UserDataState.done;
            notifyListeners();
            DioHelper.removeUserToken();
            Navigator.popUntil(
              context,
              (route) => route.settings.name == UserInfoScreen.routeName,
            );
            showSnackBar(
                context: context,
                message: val.data["message"],
                state: SnackBarState.success);
          } else {
            throw (val.data["message"] ?? "حدث خطأ الرجاء اعادة المحاولة");
          }
        },
      );
    } catch (e) {
      userDataState = UserDataState.error;
      notifyListeners();
      showSnackBar(
        context: context,
        message: e.toString(),
        state: SnackBarState.error,
      );
      Navigator.pop(context);
    }
  }

  Future<void> updateUser(
      BuildContext context, String name, String phone, String address) async {
    if (name == user?.name && phone == user?.phone && address == user?.location.address) {
      Navigator.of(context).pop();
      showSnackBar(
        context: context,
        message: "يجب ان تدخل معلومات جديدة من اجل تحديثها",
        state: SnackBarState.error,
      );
      return;
    }
    userDataState = UserDataState.updatingUserPassword;
    notifyListeners();
    Map<String, dynamic> payload = {
      "name": name,
      "phone": phone,
      "address": address,
    };
    try {
      await DioHelper.postData(
        path: EndPoints.update_user,
        headers: {"authorization": DioHelper.User_Token},
        data: payload,
      ).then(
        (val) {
          if (val.statusCode == 200 && val.data["status"] == "success") {
            user = UserModel(
              id: user!.id,
              name: name,
              phone: phone,
              role: user!.role,
              status: user!.status,
              location: UserLocationModel(
                id: user!.location.id,
                address: address,
                user_id: user!.location.user_id,
              ),
            );
            userDataState = UserDataState.done;
            notifyListeners();
            Navigator.popUntil(
              context,
                  (route) =>
              route.settings.name == UserInfoScreen.routeName,
            );
            showSnackBar(
              context: context,
              message: val.data["message"],
              state: SnackBarState.success,
            );
          } else {
            throw (val.data["message"] ?? "حدث خطأ ما");
          }
        },
      );
    } catch (e) {
      userDataState = UserDataState.error;
      notifyListeners();
      showSnackBar(
        context: context,
        message: e.toString(),
        state: SnackBarState.error,
      );
    }
  }
}