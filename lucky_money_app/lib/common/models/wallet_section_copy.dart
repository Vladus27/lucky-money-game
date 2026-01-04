import 'package:lucky_money_app/common/constant/wallet_strings.dart' as wallet;

enum WalletSection { start, step1, step2, step3, totalBalance, inGameBalance }

class WalletSectionCopy {
  String? helloLabel;
  String? username;

  String? stepLabel;
  String? stepDescription;

  String? stepNum;

  String? userAddressInputLabel;
  String? userAddressInputHint;

  String? faucetLabel;
  String? treasuryLabel;
  String? treasuryAddress;

  String? balancelabel;
  String? balance;
  WalletSectionCopy({
    this.helloLabel,
    this.username,
    this.stepLabel,
    this.stepDescription,
    this.stepNum,
    this.userAddressInputLabel,
    this.userAddressInputHint,
    this.faucetLabel,
    this.treasuryAddress,
    this.treasuryLabel,
    this.balancelabel,
    this.balance,
  });

  static WalletSectionCopy of(WalletSection section) {
    switch (section) {
      case WalletSection.start:
        return WalletSectionCopy.start();
      case WalletSection.step1:
        return WalletSectionCopy.step1();
      case WalletSection.step2:
        return WalletSectionCopy.step2();
      case WalletSection.step3:
        return WalletSectionCopy.step3();
      case WalletSection.totalBalance:
        return WalletSectionCopy.totalBalance();
      case WalletSection.inGameBalance:
        return WalletSectionCopy.balanceInGame();
    }
  }

  factory WalletSectionCopy.start() => WalletSectionCopy(
    helloLabel: wallet.walletHelloLabel,
    username: wallet.walletUsername,
  );

  factory WalletSectionCopy.step1() => WalletSectionCopy(
    stepLabel: wallet.stpeLabel1,
    stepDescription: wallet.stepDescription1,
    userAddressInputLabel: wallet.userAddressInputLabel,
    userAddressInputHint: wallet.userAddressInputHint,
  );
  factory WalletSectionCopy.step2() => WalletSectionCopy(
    stepLabel: wallet.stepLabel2,
    stepDescription: wallet.stepDescription2,
    stepNum: wallet.stepNum1,
    faucetLabel: wallet.faucetLabel,
  );

  factory WalletSectionCopy.step3() => WalletSectionCopy(
    stepLabel: wallet.stepLabel3,
    stepDescription: wallet.stepDescription3,
    stepNum: wallet.stepNum2,
    treasuryLabel: wallet.treasuryLabel,
    treasuryAddress: wallet.treasuryAddress,
  );

  factory WalletSectionCopy.totalBalance() => WalletSectionCopy(
    balancelabel: wallet.walletBalanceLabel,
    balance: wallet.walletBalance,
  );
  factory WalletSectionCopy.balanceInGame() => WalletSectionCopy(
    balancelabel: wallet.walletBallanceLabelInGame,
    balance: wallet.walletBalanceInGame,
  );
}
