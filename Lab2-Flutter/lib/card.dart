import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  CreditCard({
    this.cardNumber,
    this.cardHolder,
    this.cardMonth,
    this.cardYear,
    this.CVVNumber,
    this.isTurned = false
  });

  String cardNumber;
  String cardHolder;
  String cardMonth;
  String cardYear;
  String CVVNumber;

  bool isTurned ;

  @override
  Widget build(BuildContext context) {

    if(!isTurned) {
      return Container(
        width: 280,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          image: DecorationImage(
            image: AssetImage("assets/images/14.jpeg"),
          ),
        ),

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 20),
                    child:
                      Image.asset(
                        'assets/images/chip.png',
                        height: 40,
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.only(top: 20),
                    child:
                    Image.asset(
                      'assets/images/${_updateCardType(cardNumber)}',
                      height: 50,
                      width: 70,
                    ),
                  )
                ],
              ),
              Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 40),
                  child: Text(cardNumber,
                    style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20),
                      child: Text(cardHolder.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 13),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),

                      child: Row(children: [
                        Text("${cardYear.substring(cardYear.length - 2)}",
                            style: TextStyle(
                                color: Colors.white, fontSize: 15)),
                        Text("/", style: TextStyle(
                            color: Colors.white, fontSize: 15)),
                        Text("$cardMonth", style: TextStyle(
                            color: Colors.white, fontSize: 15)),

                      ],),
                    ),
                  ]),
            ]),
      );
    } else {
      return(
          Container(
            width:280,
            height:180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              image: DecorationImage(
                image: AssetImage("assets/images/14.jpeg"),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      width: 280,
                      height: 30,
                      margin: EdgeInsets.only(top:20),
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),

                  ]),
                  Row(children: <Widget>[
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.white,

                      margin: EdgeInsets.only(top:30, right:20, left:20),
                      padding: EdgeInsets.only(right:10),
                      child: Text(CVVNumber, textAlign: TextAlign.end,  style: TextStyle(color: Colors.black, fontSize: 20),),
                    ),
                  ])
                ]),
          ));
      }
    }

    //Card type
  String _updateCardType(String num) {
    if(new RegExp('^5[1-5]').hasMatch(num)){
        return 'mastercard.png';
      
    } else if (new RegExp('^4').hasMatch(num)) {
        return 'visa.png';
      
    } else if (new RegExp('^(34|37)').hasMatch(num)) {
         return 'amex.png';

    } else if (new RegExp('^6011').hasMatch(num)) {
         return 'discover.png';

    } else if (new RegExp(r'((30[0-5])|(3[89])|(36)|(3095))').hasMatch(num)) {
         return 'dinersclub.png';
     
    } else if (new RegExp('^35(2[89]|[3-8])').hasMatch(num)) {
        return 'jcb.png';

    } else if (new RegExp('^9792').hasMatch(num)) {
        return 'troy.png';

    } else if (new RegExp('^(62|88)').hasMatch(num)) {
        return 'unionpay.png';

    } else {
        return "visa.png";
    }
  }

  }

  class CreditCardWidget extends StatefulWidget{

    @override
    _CardWidgetState createState() => _CardWidgetState();
  }

  class _CardWidgetState extends State<CreditCardWidget> {

    @override
    Widget build(BuildContext context) {
      return Container();
  }
}

