import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/values/values.dart';

import 'model.dart';

var dataPrintTemplate = {
  S.current.Don_hang: StoredPrintTemplate(
    html: "",
    type: $printOrderTemplate,
  ),
  S.current.Bao_che_bien: StoredPrintTemplate(
    html: "",
    type: $printCookTemplate,
  ),
  S.current.Doi_tac: StoredPrintTemplate(
    html: "",
    type: $printPartnerTemplate,
  ),
  S.current.Phieu_khuyen_mai: StoredPrintTemplate(
    html: "",
    type: $printVoucherTemplate,
  )
};
