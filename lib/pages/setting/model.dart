import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/values/values.dart';

enum TemplateTypeWeb {
  donHang5880("donHang5880"),
  donHangA4A5("donHangA4A5"),
  donHangMobile("donHangMobile"),
  temFnb("temFnb"),
  temFnbMobile("temFnbMobile"),
  temBanle("temBanle"),
  datHang("datHang"),
  phieuThu("phieuThu"),
  phieuChi("phieuChi"),
  traHang("traHang"),
  nhapHang("nhapHang"),
  nhanHang("nhanHang"),
  traHangNCC("traHangNCC"),
  chuyenHang("chuyenHang"),
  inBaoCheBien("inBaoCheBien"),
  inBaoCheBienMobile("inBaoCheBienMobile");

  final String name;

  const TemplateTypeWeb(this.name);

  String get description {
    switch (this) {
      case donHang5880:
        return S.current.Don_hang5880;
      case donHangA4A5:
        return S.current.Don_hangA4A5;
      case donHangMobile:
        return S.current.Don_hang_mobile;
      case temFnb:
        return S.current.Tem_fnb;
      case temFnbMobile:
        return S.current.Tem_fnb_mobile;
      case temBanle:
        return S.current.Tem_ban_le;
      case datHang:
        return S.current.Dat_hang;
      case phieuThu:
        return S.current.Phieu_thu;
      case phieuChi:
        return S.current.Phieu_chi;
      case traHang:
        return S.current.Tra_hang;
      case nhapHang:
        return S.current.Nhap_hang;
      case nhanHang:
        return S.current.Nhan_hang;
      case traHangNCC:
        return S.current.Tra_hang_ncc;
      case chuyenHang:
        return S.current.Chuyen_hang;
      case inBaoCheBien:
        return S.current.In_bao_che_bien;
      case inBaoCheBienMobile:
        return S.current.In_bao_che_bien_mobile;
      default:
        return "";
    }
  }

  int get code {
    switch (this) {
      case donHang5880:
        return $orde5880;
      case donHangA4A5:
        return $orderA4A5;
      case donHangMobile:
        return $orderMobile;
      case temFnb:
        return $temFnbMobile;
      case temFnbMobile:
        return $temFnbMobile;
      case temBanle:
        return $temRetail;
      case datHang:
        return $onOrder;
      case phieuThu:
        return $receiptVoucher;
      case phieuChi:
        return $paymentVoucher;
      case traHang:
        return $return;
      case nhapHang:
        return $orderStock;
      case nhanHang:
        return $poConfirmation;
      case traHangNCC:
        return $returnToSuppliers;
      case chuyenHang:
        return $transfer;
      case inBaoCheBien:
        return $printToCook;
      case inBaoCheBienMobile:
        return $printToCookMobile;
      default:
        return 0;
    }
  }
}

class StoredPrintTemplate {
  late String html;
  final int type;

  StoredPrintTemplate({
    required this.html,
    required this.type,
  });
}
