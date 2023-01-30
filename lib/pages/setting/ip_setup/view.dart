import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/models/models.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

import '../widgets/widgets.dart';
import 'controller.dart';

class IpSetupPage extends StatefulWidget {
  const IpSetupPage({
    Key? key,
    this.isShowDetail = false,
  }) : super(key: key);

  final bool isShowDetail;

  @override
  State<IpSetupPage> createState() => _IpSetupPageState();
}

class _IpSetupPageState extends State<IpSetupPage> {
  late final IPSetupController _controller;
  final _focus2 = FocusNode();
  final _focus3 = FocusNode();
  final _focus4 = FocusNode();
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put<IPSetupController>(IPSetupController());
    _controller.initData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeData();
    Get.delete<IPSetupController>();
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.med),
      child: Column(
        children: [
          SettingTitleWidget(
            title: S.current.Thong_tin_may.toUpperCase(),
            icon: Icons.flag,
            trailing: IconButton(
              icon: const Icon(
                Icons.refresh,
                color: AppColor.grey600,
              ),
              onPressed: _controller.reloadAll,
            ),
          ),
          Container(
            padding: EdgeInsets.all(Insets.med),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: Corners.medBorder,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${S.current.Dia_chi_ip_cua_may}:',
                  style: TextStyles.title1.copyWith(
                    height: 0,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey600,
                  ),
                ),
                VSpace.xs,
                Obx(
                  () => Text(
                    _controller.state.deviceInfo.ip,
                    style: TextStyles.title1.copyWith(
                      height: 0,
                      color: AppColor.black800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                VSpace.med,
                Text(
                  '${S.current.Thong_tin_may_hien_tai}:',
                  style: TextStyles.title1.copyWith(
                    height: 0,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey600,
                  ),
                ),
                VSpace.xs,
                Obx(
                  () => Text(
                    _controller.state.deviceInfo.deviceName,
                    style: TextStyles.title1.copyWith(
                      height: 0,
                      color: AppColor.black800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                VSpace.med,
                Text(
                  '${S.current.Dang_nhap_boi}:',
                  style: TextStyles.title1.copyWith(
                    height: 0,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey600,
                  ),
                ),
                VSpace.xs,
                Text(
                  ConfigStore.to.typeLogin?.name ?? S.current.Khong_xac_dinh,
                  style: TextStyles.title1.copyWith(
                    height: 0,
                    color: AppColor.black800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (ConfigStore.to.typeLogin == TypeLogin.cashiers && !isWeb) _serverInfoWidget(),
          if (ConfigStore.to.typeLogin == TypeLogin.cashiers && !isWeb)
            _allDeviceConnectionWidget(),
          if (!isWeb) _roleForOrderWidget(),
          VSpace.med,
        ],
      ),
    );
    if (widget.isShowDetail) return content;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black800),
          onPressed: () => context.popNavigator(),
        ),
        title: Text(
          S.current.Thiet_lap_ip,
          style: TextStyles.title1.copyWith(
            height: 0,
          ),
        ),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constrains) => Container(
          height: constrains.maxHeight,
          color: AppColor.grey300WithOpacity500,
          child: SingleChildScrollView(
            child: content,
          ),
        ),
      ),
    );
  }

  Widget _serverInfoWidget() {
    return Obx(
      () {
        final SocketServerInfo socketServerInfo = _controller.state.ssInfoServer;
        final bool serverIsRunning = socketServerInfo.serverIsRunning;
        return Column(
          children: <Widget>[
            SettingTitleWidget(
              title: S.current.Trang_thai_mang_noi_bo.toUpperCase(),
              icon: Icons.flag,
            ),
            _ipContentItemWidget(
              content1: serverIsRunning ? socketServerInfo.hostServer : S.current.Mang_noi_bo,
              color1: serverIsRunning ? AppColor.successColor : AppColor.errorColor,
              content2: serverIsRunning ? S.current.Dang_bat : S.current.Dang_tat,
              color2: serverIsRunning ? AppColor.successColor : AppColor.errorColor,
              content3: ConfigStore.to.typeLogin?.name ?? S.current.Khong_xac_dinh,
            ),
            VSpace.med,
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CustomButton.fullColor(
                    width: double.infinity,
                    onPressed: _controller.initServer,
                    text: S.current.Bat,
                    background: AppColor.successColor,
                  ),
                ),
                HSpace.med,
                Expanded(
                  flex: 1,
                  child: CustomButton.fullColor(
                    width: double.infinity,
                    onPressed: _controller.disposeServer,
                    text: S.current.Tat,
                    background: AppColor.errorColor,
                  ),
                ),
                HSpace.med,
                Expanded(
                  flex: 2,
                  child: CustomButton.fullColor(
                    width: double.infinity,
                    onPressed: _controller.reloadServer,
                    text: S.current.Khoi_dong_lai,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _allDeviceConnectionWidget() => Obx(
        () {
          final List<Widget> listContent = _controller.state.listSocketConnection
              .map<Widget>(
                (socketConnection) => Padding(
                  padding: EdgeInsets.only(bottom: Insets.med),
                  child: _ipContentItemWidget(
                    content1:
                        '${socketConnection.deviceInfo.ip}:${socketConnection.deviceInfo.sourcePort}',
                    title2: '${S.current.Thiet_bi}: ',
                    content2: socketConnection.deviceInfo.deviceName,
                    content3: socketConnection.deviceInfo.moreInfo ?? S.current.Khong_xac_dinh,
                  ),
                ),
              )
              .toList();
          if (listContent.isEmpty) return const SizedBox.shrink();
          return Column(
            children: <Widget>[
              SettingTitleWidget(
                title: S.current.Dang_nhan_ket_noi_tu.toUpperCase(),
                icon: Icons.connected_tv,
              ),
              ...listContent,
            ],
          );
        },
      );

  Widget _roleForOrderWidget() {
    return Obx(
      () {
        final bool isShowServerConnected = !_controller.state.ssInfoServer.serverIsRunning ||
            ConfigStore.to.typeLogin == TypeLogin.order;
        if (!isShowServerConnected) return const SizedBox.shrink();
        final SocketServerInfo socketServerInfo = _controller.state.ssInfoClient;
        final List<Widget> listServerIpCanConnect = _controller.state.serverIPs
            .map<Widget>(
              (ip) => CustomButton.outline(
                width: double.infinity,
                onPressed: () => _controller.connectToServer(ip),
                text: ip,
                borderColor: ip == _controller.state.currentConnectServerIP
                    ? AppColor.blueLight
                    : AppColor.grey300,
                textColor: ip == _controller.state.currentConnectServerIP
                    ? AppColor.blueLight
                    : AppColor.black800,
              ),
        )
            .toList();
        return Column(
          children: <Widget>[
            SettingTitleWidget(
              title: S.current.Dang_ket_noi_voi.toUpperCase(),
              icon: Icons.connect_without_contact,
              trailing: IconButton(
                icon: const Icon(
                  Icons.airplanemode_off,
                  color: AppColor.grey600,
                ),
                onPressed: _controller.disconnectToServer,
              ),
            ),
            socketServerInfo.isNotNone()
                ? _ipContentItemWidget(
              content1: socketServerInfo.hostServer,
                    color1: AppColor.successColor,
                    title2: '${S.current.Thiet_bi}: ',
                    content2: socketServerInfo.deviceServerName,
                    content3: socketServerInfo.moreInfo ?? S.current.Khong_xac_dinh,
                  )
                : const SizedBox.shrink(),
            SettingTitleWidget(
              title: S.current.Danh_sach_co_the_ket_noi.toUpperCase(),
              icon: Icons.list,
              trailing: IconButton(
                icon: const Icon(
                  Icons.settings_input_antenna,
                  color: AppColor.grey600,
                ),
                onPressed: _controller.discoverServerIP,
              ),
            ),
            ...listServerIpCanConnect,
            SettingTitleWidget(
              title: S.current.Nhap_ip_bang_tay.toUpperCase(),
              icon: Icons.back_hand,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _inputEnterIPWidget(
                  controller: _textController1,
                  onChanged: (value) {
                    if (value == null) return;
                    if (value.length == 3) FocusScope.of(context).requestFocus(_focus2);
                  },
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focus2),
                ),
                _spaceInputEnterIPWidget(),
                _inputEnterIPWidget(
                  controller: _textController2,
                  focusNode: _focus2,
                  onChanged: (value) {
                    if (value == null) return;
                    if (value.length == 3) FocusScope.of(context).requestFocus(_focus3);
                  },
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focus3),
                ),
                _spaceInputEnterIPWidget(),
                _inputEnterIPWidget(
                  controller: _textController3,
                  focusNode: _focus3,
                  onChanged: (value) {
                    if (value == null) return;
                    if (value.length == 3) FocusScope.of(context).requestFocus(_focus4);
                  },
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focus4),
                ),
                _spaceInputEnterIPWidget(),
                _inputEnterIPWidget(
                  controller: _textController4,
                  focusNode: _focus4,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    if (value == null) return;
                    if (value.length == 3) FocusScope.of(context).unfocus();
                  },
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
              ],
            ),
            VSpace.med,
            CustomButton.fullColor(
              width: double.infinity,
              onPressed: () => _controller.addIPManual(
                [
                  _textController1.text,
                  _textController2.text,
                  _textController3.text,
                  _textController4.text,
                ],
              ).then(
                (result) {
                  if (result) {
                    _textController1.clear();
                    _textController2.clear();
                    _textController3.clear();
                    _textController4.clear();
                  }
                },
              ),
              text: S.current.Tim_kiem,
            ),
          ],
        );
      },
    );
  }

  Widget _spaceInputEnterIPWidget() => Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.sm),
        child: Text(
          '.',
          style: TextStyles.h2.copyWith(height: 0.3),
        ),
      );

  Widget _inputEnterIPWidget({
    required TextEditingController controller,
    FocusNode? focusNode,
    required ValueChanged<String?> onChanged,
    required VoidCallback onEditingComplete,
    TextInputAction? textInputAction,
  }) =>
      Flexible(
        child: CustomInput.outline(
          controller: controller,
          padding: EdgeInsets.symmetric(horizontal: Insets.med),
          type: TextInputType.number,
          action: textInputAction,
          hintText: '192',
          focusNode: focusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(3),
          ],
          textAlign: TextAlign.center,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      );

  Widget _ipContentItemWidget({
    String? title1,
    required String content1,
    String? title2,
    required String content2,
    String? title3,
    required String content3,
    Color? color1,
    Color? color2,
    Color? color3,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Insets.med),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: Corners.medBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                title1 ?? 'IP: ',
                style: TextStyles.title1.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey600,
                ),
              ),
              Text(
                content1,
                style: TextStyles.title1.copyWith(
                  fontWeight: FontWeight.w500,
                  color: color1 ?? AppColor.black800,
                ),
              ),
            ],
          ),
          VSpace.xs,
          Row(
            children: <Widget>[
              Text(
                title2 ?? '${S.current.Trang_thai}: ',
                style: TextStyles.title1.copyWith(
                  color: AppColor.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                content2,
                style: TextStyles.title1.copyWith(
                  color: color2 ?? AppColor.black800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          VSpace.xs,
          Row(
            children: <Widget>[
              Text(
                title3 ?? '${S.current.Dang_nhap_boi}: ',
                style: TextStyles.title1.copyWith(
                  color: AppColor.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                content3,
                style: TextStyles.title1.copyWith(
                  color: color3 ?? AppColor.black800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
