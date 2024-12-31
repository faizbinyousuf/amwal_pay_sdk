import 'package:amwal_pay_sdk/core/apiview/api_view.dart';
import 'package:amwal_pay_sdk/core/resources/assets/app_assets_paths.dart';
import 'package:amwal_pay_sdk/core/resources/color/colors.dart';
import 'package:amwal_pay_sdk/core/ui/cardinfoform/card_type.dart';
import 'package:amwal_pay_sdk/features/card/cubit/sale_by_card_manual_cubit.dart';
import 'package:amwal_pay_sdk/localization/locale_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../inputfields/input_field_widget.dart';
import 'card_form_inputs_formatter.dart';
import 'card_utils.dart';

class CardInfoFormWidget extends StatefulApiView<SaleByCardManualCubit> {
  final String Function(String)? globalTranslator;
  final FocusNode cardFocusNode;
  final FocusNode expireMonthFocusNode;
  final FocusNode expireYearFocusNode;
  final FocusNode cvvFocusNode;
  const CardInfoFormWidget({
    Key? key,
    this.globalTranslator,
    required this.cardFocusNode,
    required this.expireMonthFocusNode,
    required this.expireYearFocusNode,
    required this.cvvFocusNode,
  }) : super(key: key);

  @override
  State<CardInfoFormWidget> createState() => _CardInfoFormWidgetState();
}

class _CardInfoFormWidgetState extends State<CardInfoFormWidget> {
  CardType cardType = CardType.others;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'card_number_label'.translate(
                context,
                globalTranslator: widget.globalTranslator,
              ),
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          key: const Key('cardNum'),
          focusNode: widget.cardFocusNode,
          textInputAction: TextInputAction.next,
          textDirection: TextDirection.ltr,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            setState(() => cardType = CardUtils.getCardTypeFrmNumber(value));
            widget.cubit.cardNo = value;
          },
          keyboardType: TextInputType.number,
          validator: (input) => CardUtils.validateCardNum(input, context),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(19),
            CardNumberInputFormatter(),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'enter_card_number_label'
                .translate(context, globalTranslator: widget.globalTranslator),
            focusColor: whiteColor,
            suffixIcon: CardUtils.getCardIcon(
              cardType,
            ),
            hintStyle: const TextStyle(
              color: lightGreyColor,
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InputFieldWidget(
          key: const Key('cardName'),
          widgetTitle: 'card_name_label'
              .translate(context, globalTranslator: widget.globalTranslator),
          widgetHint: 'enter_card_name_label'
              .translate(context, globalTranslator: widget.globalTranslator),
          isEnglish: true,
          hint: 'card_holder_hint',
          maxLength: 50,
          initialValue: widget.cubit.cardHolderName,
          onChange: (value) {
            widget.cubit.cardHolderName = value;
          },
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        // InputFieldWidget(
        //   key: const Key('email'),
        //   widgetTitle: 'email_label'
        //       .translate(context, globalTranslator: widget.globalTranslator),
        //   widgetHint: 'email_hint'
        //       .translate(context, globalTranslator: widget.globalTranslator),
        //   isAliasName: true,
        //   isRequired: false,
        //   maxLength: 40,
        //   initialValue: widget.cubit.email,
        //   onChange: (value) {
        //     widget.cubit.email = value;
        //   },
        // ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputFieldWidget(
                key: const Key('expMonth'),
                focusNode: widget.expireMonthFocusNode,
                widgetTitle: 'expiry_date'.translate(context,
                    globalTranslator: widget.globalTranslator),
                widgetHint: 'mm_date'.translate(context,
                    globalTranslator: widget.globalTranslator),
                maxLength: 2,
                minLength: 2,
                isNumber: true,
                isMonth: true,
                hint: 'expiry_month_hint',
                initialValue: widget.cubit.expirationDateMonth,
                onChange: (value) {
                  widget.cubit.expirationDateMonth = value;
                },
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            const Column(
              children: [
                SizedBox(height: 45),
                Text(
                  '/',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: InputFieldWidget(
                key: const Key('expYear'),
                focusNode: widget.expireYearFocusNode,
                widgetHint: 'yy_date'.translate(context,
                    globalTranslator: widget.globalTranslator),
                maxLength: 2,
                isNumber: true,
                isYear: true,
                hint: 'expiry_year_hint',
                initialValue: widget.cubit.expirationDateYear,
                onChange: (value) {
                  widget.cubit.expirationDateYear = value;
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InputFieldWidget(
                key: const Key('ccv'),
                focusNode: widget.cvvFocusNode,
                widgetTitle: 'cvv',
                widgetTitleIcon: AppAssets.cvvIcon,
                widgetHint: 'digits'.translate(context,
                    globalTranslator: widget.globalTranslator),
                maxLength: 3,
                minLength: 3,
                hint: 'cvv_hint',
                isNumber: true,
                initialValue: widget.cubit.cvV2,
                onChange: (value) {
                  widget.cubit.cvV2 = value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
