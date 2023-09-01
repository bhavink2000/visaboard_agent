// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../ui_helper.dart';

class IDDataShow extends StatelessWidget {
  var id;
  IDDataShow({Key? key,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: PaddingField,
        child: Text("$id" ?? "",
            style: FrontHeaderID)
    );
  }
}
class FnmLnmDataShow extends StatelessWidget {
  var firstName,lastName;
  FnmLnmDataShow({Key? key,this.firstName,this.lastName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: PaddingIDNM,
          child: Text("${firstName ?? ""} ${lastName ?? ""}",style: FrontHeaderNM)
      ),
    );
  }
}

class MobileNoDataShow extends StatelessWidget {
  var mobileNo;
  MobileNoDataShow({Key? key,this.mobileNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Mobile", style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$mobileNo",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}
class EmailDataShow extends StatelessWidget {
  var emailId;
  EmailDataShow({Key? key,this.emailId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Email", style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$emailId",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}

class ServiceTypeDataShow extends StatelessWidget {
  var serviceType;
  ServiceTypeDataShow({Key? key,this.serviceType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Service",
                style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$serviceType",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}
class LetterTypeDataShow extends StatelessWidget {
  var letterType;
  LetterTypeDataShow({Key? key,this.letterType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Letter",
                style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$letterType",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}

class AgentNameDataShow extends StatelessWidget {
  var agentName;
  AgentNameDataShow({Key? key,this.agentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
                "Agent Name",
                style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$agentName",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}
class AgentIdDataShow extends StatelessWidget {
  var agentId;
  AgentIdDataShow({Key? key,this.agentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
                "Agent Id",
                style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$agentId",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}

class CompanyNameDataShow extends StatelessWidget {
  var companyName;
  CompanyNameDataShow({Key? key,this.companyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Company Name",
                style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$companyName",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}
class CompanyAddressDataShow extends StatelessWidget {
  var companyAddress;
  CompanyAddressDataShow({Key? key,this.companyAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Company Address",
                style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$companyAddress",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}

class AdminNameDataShow extends StatelessWidget {
  var adminName;
  AdminNameDataShow({Key? key,this.adminName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Admin Name", style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$adminName",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}

class CreateAtDataShow extends StatelessWidget {
  var createAt;
  CreateAtDataShow({Key? key,this.createAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Created on", style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$createAt",
                  style: BackHeaderTopR)),
        )
      ],
    );
  }
}

class CountryDataShow extends StatelessWidget {
  var countryName;
  CountryDataShow({Key? key,this.countryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Country",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$countryName",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}
class StateDataShow extends StatelessWidget {
  var stateName;
  StateDataShow({Key? key,this.stateName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("State",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$stateName",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}
class CityDataShow extends StatelessWidget {
  var cityName;
  CityDataShow({Key? key,this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("City",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$cityName",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}

class UpDateOnDataShow extends StatelessWidget {
  var upDateOn;
  UpDateOnDataShow({Key? key,this.upDateOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("UpDate On",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$upDateOn",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}

class PriceDataShow extends StatelessWidget {
  var price;
  PriceDataShow({Key? key,this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Price",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$price",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}
class PaymentDataShow extends StatelessWidget {
  var paymentOn;
  PaymentDataShow({Key? key,this.paymentOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Payment On",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$paymentOn",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}
class CancelOnDataShow extends StatelessWidget {
  var cancelOn;
  CancelOnDataShow({Key? key,this.cancelOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Payment On",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$cancelOn",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}

class OrderPriceDataShow extends StatelessWidget {
  var orderPrice;
  OrderPriceDataShow({Key? key,this.orderPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("Order Price",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$orderPrice",style: BackHeaderTopR)
          ),
        )
      ],
    );
  }
}