import 'package:amwal_pay_sdk/localization/locale_utils.dart';
import 'package:flutter/material.dart';

import 'card_type.dart';

class CardUtils {
  static String? validateCardNum(String? input, BuildContext context) {
    if (input == null || input.isEmpty) {
      return "card_number_hint".translate(context);
    }
    input = getCleanedNumber(input);

    if (input.length != 16 && input.length != 19) {
      return "invalid_card".translate(context);
    }

    int sum = 0;
    bool doubleDigit = false;

    // Iterate over each digit in reverse order
    for (int i = input.length - 1; i >= 0; i--) {
      int digit = int.parse(input[i]);

      if (doubleDigit) {
        digit *= 2;

        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      doubleDigit = !doubleDigit;
    }
    if (sum % 10 == 0) {
      return null;
    }
    return "invalid_card".translate(context);
  }

  static CardType getCardTypeFrmNumber(String input) {
    input = input.replaceAll(RegExp(r'[^0-9]'), '');
    CardType cardType;
    if (RegExp(
            r'^(419244|426371|426372|404747|43382962|43382963|43382964|43382999|46442605|48909105|48417205|43323605|40402905|46395255|4837913[0-9]|4837914[0-9]|4837915[0-9]|4228213[0-9]|4228215[0-9]|42282230|422820[3-5][0-9]|447168[3-5][0-9]|407545[2-5][0-9]|43663755|464156|464157|416370|48413[0-1]|4797102[2-3]|44747774|4474797[7-8]|43347833|43935700|43241[0-5]|433084|422610|473820|510723|515722|523672|53441[7-8]|539150|54918[1-4]|42136060|42147814|419291|4673620[0-1]|43909701|41329805|47429505|410469|536028|559753|4228233[0-4]|4228235[0-1]|4641753[0-1]|4641755[0-1]|601722|40277200)')
        .hasMatch(input)) {
      cardType = CardType.omanNetCard;
    } else if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.master;
    } else if (input.startsWith(RegExp(r'4'))) {
      cardType = CardType.visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.americanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.dinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.jcb;
    } else if (input.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    print(cardType);
    return cardType;
  }

  static Widget getCardIcon(CardType? cardType) {
    String img = "";
    switch (cardType) {
      case CardType.master:
        img = 'mastercard.png';
        break;
      case CardType.omanNetCard:
        img = 'oman_net_card.png';
        break;
      case CardType.visa:
        img = 'visa.png';
        break;
      case CardType.americanExpress:
        img = 'american_express.png';
        break;
      case CardType.others:
        img = 'default_card.png';
        break;
      default:
        img = 'error_card.png';
        break;
    }
    return Image.asset(
      'lib/assets/images/$img',
      package: 'amwal_pay_sdk',
      width: 24,
      height: 24,
    );
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }
    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}
