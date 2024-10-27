import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedbook/pages/home/bloc/home_bloc.dart';
import 'package:tedbook/pages/home/widgets/orders.dart';
import 'package:tedbook/pages/login/bloc/login_bloc.dart';
import 'package:tedbook/pages/login/login_page.dart';
import 'package:tedbook/persistance/base_status.dart';
import 'package:tedbook/persistance/text_style_const.dart';
import 'package:tedbook/utils/color_utils.dart';
import 'package:tedbook/utils/navigator_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomeBloc bloc;
  late TabController _tabController;

  @override
  void initState() {
    bloc = context.read<HomeBloc>();
    bloc.add(InitEvent());
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    bloc.socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainUi,
    );
  }

  Widget get _mainUi => BlocListener<HomeBloc, HomeState>(
        listenWhen: (_, c) =>
            c.status.type == StatusType.logout ||
            c.status.type == StatusType.sent ||
            c.status.type == StatusType.updated ||
            c.status.type == StatusType.error,
        listener: (_, HomeState state) {
          if (state.status.type == StatusType.logout) {
            pushAndRemoveAllWithBloc(LoginPage(), LoginBloc());
          } else if (state.status.type == StatusType.sent) {
            bloc.commentControllers[state.sentOrderId].clear();
            bloc.commentFocuses[state.sentOrderId].unfocus();
          } else if (state.status.type == StatusType.updated) {
            pop();
          } else if (state.status.type == StatusType.error) {
            showToast(
              state.status.message?.text ?? "",
              context: context,
              animation: StyledToastAnimation.scale,
              backgroundColor: Colors.red,
              position: StyledToastPosition(align: Alignment.topCenter),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                _appBar,
                SizedBox(height: 22),
                _tabBarField,
                SizedBox(height: 22),
                _tabBarViewField,
              ],
            ),
          ),
        ),
      );

  Widget get _appBar => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset("assets/icons/person.svg", height: 30),
            SizedBox(width: 12),
            InkWell(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () => bloc.add(LogoutEvent()),
              child: Text(
                "Выйти",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      );

  Widget get _tabBarField => BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.selectedOrderType != current.selectedOrderType,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                _tabBarItem(
                  title: "Заявки",
                  isSelected: state.selectedOrderType == 0,
                  onTap: () {
                    _tabController.animateTo(0);
                    bloc.add(ChangeOrderTypeEvent(selectedTypeIndex: 0));
                  },
                ),
                SizedBox(width: 16),
                _tabBarItem(
                  title: "Архив",
                  isSelected: state.selectedOrderType == 1,
                  onTap: () {
                    _tabController.animateTo(1);
                    bloc.add(ChangeOrderTypeEvent(selectedTypeIndex: 1));
                  },
                ),
              ],
            ),
          );
        },
      );

  Widget get _tabBarViewField => Expanded(
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            OrdersWidget(isArchive: false),
            OrdersWidget(isArchive: true),
          ],
        ),
      );
}

Widget _tabBarItem({
  required String title,
  required bool isSelected,
  required Function onTap,
}) =>
    Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          onTap.call();
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? AppColor.blackColor : Colors.white,
          ),
          child: Text(
            title,
            style: TextStyleS.s16w600(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
    );
