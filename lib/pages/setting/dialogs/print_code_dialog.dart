import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/pages/pages.dart';

class PrintCodeDialog extends StatefulWidget {
  const PrintCodeDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<PrintCodeDialog> createState() => _PrintCodeDialogState();
}

class _PrintCodeDialogState extends State<PrintCodeDialog> {
  final SettingController controller = SettingController.to;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Expanded(
          flex: 10,
          child: Text(
            S.current.Sao_chep_ma_in,
            style: TextStyles.title1.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
          // ),
        ),
      ]),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Corners.xl))),
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Corners.custom25)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Corners.custom25),
                          borderSide: const BorderSide(color: Colors.blue))),
                  onChanged: controller.onSearchPrintTemplate,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.state.tempalteKeys.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                  text: controller
                                      .state.tempalteKeys[index].code),
                            );
                            Navigator.pop(context);
                          },
                          child: Column(children: [
                            Row(children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                    controller.state.tempalteKeys[index].code,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: TextStyles.body1),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    controller
                                        .state.tempalteKeys[index].description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: TextStyles.body1),
                              ),
                            ]),
                            const Divider(),
                          ]),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
