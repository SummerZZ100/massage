

import 'package:get/get.dart';
import 'package:massage/business/address/page/address_edit_page.dart';
import 'package:massage/business/address/page/address_list_page.dart';
import 'package:massage/business/all_projects/page/all_projects_page.dart';
import 'package:massage/business/all_service_users/page/all_service_users_page.dart';
import 'package:massage/business/care/page/care_page.dart';
import 'package:massage/business/comment/page/comment_edit_page.dart';
import 'package:massage/business/comment/page/comment_list_page.dart';
import 'package:massage/business/create_order/page/create_order_page.dart';
import 'package:massage/business/fans/page/fans_page.dart';
import 'package:massage/business/home/pages/search_page.dart';
import 'package:massage/business/info_edit/page/d_e_page.dart';
import 'package:massage/business/info_edit/page/info_edit_page.dart';
import 'package:massage/business/launcher/page/launch_page.dart';
import 'package:massage/business/login/page/user_login_page.dart';
import 'package:massage/business/message/page/chat_message_list_page.dart';
import 'package:massage/business/message/page/message_page.dart';
import 'package:massage/business/message/page/service_message_list_page.dart';
import 'package:massage/business/message/page/system_message_list_page.dart';
import 'package:massage/business/near_service_users/page/near_service_users_page.dart';
import 'package:massage/business/order/page/order_detail_page.dart';
import 'package:massage/business/order/page/order_list_page.dart';
import 'package:massage/business/project_detail/page/project_detail_page.dart';
import 'package:massage/business/select_report_content/page/select_report_content_page.dart';
import 'package:massage/business/select_service_user/page/select_service_user_page.dart';
import 'package:massage/business/setting/page/setting_page.dart';
import 'package:massage/business/special_projects/page/special_projects_page.dart';

import '../business/coupon/page/coupon_page.dart';
import '../business/create_order/page/pay_success_page.dart';
import '../business/main_tab/page/main_tab_page.dart';
import '../business/service_user_detail/page/service_user_detail_page.dart';


///路由管理者
class RouterManager{

  static final routes = [
    GetPage(name: Routers.main, page: () => const MainTabPage(),transition: null,transitionDuration: const Duration(microseconds: 0)),
    GetPage(name: Routers.launch_page, page: () => LaunchPage()),
    GetPage(name: Routers.login_page,page: () => const UserLoginPage(),fullscreenDialog: true),
    GetPage(name: Routers.special_projects, page: () => const SpecialProjectsPage()),
    GetPage(name: Routers.near_service_users, page: () => const NearServiceUsersPage()),
    GetPage(name: Routers.coupon_list, page: () => const CouponPage()),
    GetPage(name: Routers.message, page: () => const MessagePage()),
    GetPage(name: Routers.select_service_user, page: () => const SelectServiceUsersPage()),
    GetPage(name: Routers.report_content_list,page: () => const SelectReportContentPage(),fullscreenDialog: true),
    GetPage(name: Routers.all_service_users, page: () => const AllServiceUsersPage()),
    GetPage(name: Routers.all_projects, page: () => const AllProjectsPage()),
    GetPage(name: Routers.project_detail, page: () => const ProjectDetailPage()),
    GetPage(name: Routers.create_order, page: () => const CreateOrderPage()),
    GetPage(name: Routers.service_user_detail, page: () => const ServiceUserDetailPage()),
    GetPage(name: Routers.system_message_list, page: () => const SystemMessageListPage()),
    GetPage(name: Routers.service_message_list, page: () => const ServiceMessageListPage()),
    GetPage(name: Routers.chat_list, page: () => const ChatMessageListPage()),
    GetPage(name: Routers.info_edit, page: () => const InfoEditPage()),
    GetPage(name: Routers.fans, page: () => const FansPage()),
    GetPage(name: Routers.care, page: () => const CarePage()),
    GetPage(name: Routers.order_list, page: () => const OrderListPage()),
    GetPage(name: Routers.address_list, page: () => const AddressListPage()),
    GetPage(name: Routers.comment_list, page: () => const CommentListPage()),
    GetPage(name: Routers.setting, page: () => const SettingPage()),
    GetPage(name: Routers.address_edit, page: () => const AddressEditPage()),
    GetPage(name: Routers.order_detail, page: () => const OrderDetailPage()),
    GetPage(name: Routers.comment_edit, page: () => const CommentEditPage()),
    GetPage(name: Routers.de_page, page: () => const DEPage()),
    GetPage(name: Routers.search_page, page: () => const SearchPage()),
    GetPage(name: Routers.pay_success, page: () => const PaySuccessPage(),fullscreenDialog: true),
  ];

  static int webViewId = 0;//web页面id

}
///路由名称
class Routers{

  static const String main = '/main';
  static const String launch_page = '/launch_page';
  static const String login_page = '/login_page';
  static const String special_projects = '/special_projects';
  static const String near_service_users = '/near_service_users';
  static const String coupon_list = '/coupon_list';
  static const String message = '/message';
  static const String select_service_user = '/select_service_user';
  static const String report_content_list = '/report_content_list';
  static const String all_service_users = '/all_service_users';
  static const String all_projects = '/all_projects';
  static const String project_detail = '/project_detail';
  static const String create_order = '/create_order';
  static const String service_user_detail = '/service_user_detail';
  static const String system_message_list = '/system_message_list';
  static const String service_message_list = '/service_message_list';
  static const String chat_list = '/chat_list';
  static const String info_edit = '/info_edit';
  static const String fans = '/fans';
  static const String care = '/care';
  static const String order_list = '/order_list';
  static const String address_list = '/address_list';
  static const String comment_list = '/comment_list';
  static const String setting = '/setting';
  static const String address_edit = '/address_edit';
  static const String order_detail = '/order_detail';
  static const String comment_edit = '/comment_edit';
  static const String de_page = '/de_page';
  static const String search_page = '/search_page';
  static const String pay_success = '/pay_success';

}