import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _cardNumber = "";
  var _cardHolder = "";
  var _cardMonth = "01";
  var _cardYear = "2021";
  var _CVVNumber = "";

  bool _isTurned = false;

  List <String> _yearValue = [
    '2021', '2022', '2023', '2024',
    '2025', '2026', '2027', '2028',
    '2029', '2030', '2031'
  ];

  List <String> _monthValue = [
    '01', '02', '03', '04',
    '05', '06', '07', '08',
    '09', '10', '11', '12'
  ];


  void _setCardNumbers(String newValue, String type){
    _isTurned = false;
    switch(type){
      case "year": {
        setState(() {
          _cardYear = newValue;
        });
       }break;
      case "month": {
        setState(() {
          _cardMonth = newValue;
        });
      }break;
    }
  }

  void _setCardHolder(String name, String type) {
    switch (type) {
      case "cardHolder":
        {
          setState(() {
            _cardHolder = name;
          });
          _isTurned = false;
        }
        break;
      case "cardNumber":
        {
          setState(() {
            _cardNumber = name;
          });
          _isTurned = false;
        }break;
      case "cardCVV": {
        setState(() {
          _CVVNumber = name;
        });
      }break;
      }
    }

    String validateName(String value) {
      if(value.length <3)
        return 'Name must be more than 2 characters';
      else
        return null;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(

        title: Text("Lab 2"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      resizeToAvoidBottomPadding: false,
      body: Center(

        child: ListView(children: [

          Stack(
            alignment: Alignment(0.0, -0.9),

            children: <Widget>[

              Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 20, left: 20, top: 80),
                margin: EdgeInsets.only(right: 20, left: 20, top: 120),
                height: 390,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                ),


                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //card number-------------------------------------------
                      Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("Card Number")
                        ),
                      ]),

                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            _setCardHolder(value, "cardNumber");
                          },

                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new CardNumberInputFormatter(),
                            new LengthLimitingTextInputFormatter(22),
                          ],
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      //card holders ------------------------------------------
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('Card Holders'),
                      ),

                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: TextFormField(
                          validator: validateName,
                          onChanged: (text) {
                            _setCardHolder(text, "cardHolder");
                          },
                          maxLength: 18,
                          inputFormatters: [

                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                          ],

                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      //expiration date-------------------------------------------
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('Expiration Date'),
                          ),
                          Container(

                            margin: EdgeInsets.only(top:10, right: 70),
                            child: Text('CVV'),
                          ),
                        ]
                      ),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),

                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: Container(color: Colors.transparent),
                                value: _cardYear,
                                items: _yearValue.map<DropdownMenuItem<String>>((String valueY) {
                                  return DropdownMenuItem<String>(
                                      child: Text(valueY),
                                      value: valueY
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _setCardNumbers(value, "year");
                                },
                              ),),

                            Container(
                              width: 80,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),

                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(color: Colors.transparent),
                                value: _cardMonth,
                                items: _monthValue.map<DropdownMenuItem<String>>((String valueM) {
                                  return DropdownMenuItem<String>(
                                    value: valueM,
                                    child: Text(valueM),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _setCardNumbers(value, "month");
                                },
                              ),),

                            // ---- CVV ----- //_CVVNumber
                            Container(
                                width: 100,
                                // margin:EdgeInsets.only(top:5),
                                padding: EdgeInsets.only(right: 10, left:10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: TextFormField(
                                  onTap: () {
                                    setState(() {
                                      _isTurned = true;
                                    }); },

                                  onChanged: (value) { _setCardHolder(value, "cardCVV");},

                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(4),
                                  ],

                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black26),
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )

                            ),
                          ]),

                      ButtonTheme(
                        minWidth: double.infinity,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: () { },
                          child: Text("Submit", style: TextStyle(
                            color: Colors.white,

                          ),
                          ),
                        ),
                      ),

                    ]),
              ),

              CreditCard(
                cardNumber: _cardNumber,
                cardHolder: _cardHolder,
                cardMonth: _cardMonth,
                cardYear: _cardYear,
                CVVNumber: _CVVNumber,
                isTurned: _isTurned,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    //The offset at which the selection originates
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
  //StringBuffer - allows for the incremental building of a string to .write
    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      //nonzeroidex - Start counting from 1 instead of 0
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    //close StringBuffer .write with toString
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}


