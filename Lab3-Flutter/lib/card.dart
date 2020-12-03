import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFF303030);

class infoBox extends StatelessWidget {
  infoBox({
    this.title,
    this.repositoryURL,
    this.totalStarAmount,
    this.totalForkAmount,
    this.repoDisc,
    this.branchAmount,
    this.repoLicense,
    this.noOfCommits,
  });

  String title = "";
  String repositoryURL = "";
  int totalStarAmount = 0;
  int totalForkAmount = 0;
  String repoDisc = "";
  int noOfCommits = 0;
  int branchAmount = 0;
  String repoLicense = "";

  @override
  Widget build(BuildContext context) {

    String fHalf;
    String secHalf;

    String firstHalf;
    String secondHalf;

    if (repoDisc.length > 100) {
      fHalf = repoDisc.substring(0, 100);
      secHalf = repoDisc.substring(100, repoDisc.length);
    }else {
      fHalf = repoDisc;
      secHalf = "";
    }

    if (title.length > 35) {
      firstHalf = title.substring(0, 35);
      secondHalf = title.substring(35, title.length);
    }else {
      firstHalf = title;
      secondHalf = "";
    }

    //when container is clicked/tapped
    return InkWell(
      onTap: (){
        print("Container clicked");
        //navigate to second page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute(
            title: title,
            repoDisc: repoDisc,
            branchAmount: branchAmount,
            noOfCommits: noOfCommits,
            repoLicense: repoLicense,
          )),
        );
        },
        child: Container(

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white24),
          width:double.infinity,
          margin: EdgeInsets.only(right: 5, left:5, top:10,),
          //height:130,
          //color: Colors.white24,
          child:
          Column(

            children: [
              //Title
              Row(
                children:[
                  Container(
                    padding: EdgeInsets.all(5),
                    child:
                    secHalf.isEmpty
                        ? new Text(firstHalf, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                        : new Column(
                        children: [
                          new Text(firstHalf, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),), //: (firstHalf + secondHalf)),
                        ]
                    ),
                    //Text(title ?? "", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(
                children: [
                  // title
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 300,
                    child: Text(repositoryURL ?? "", style: TextStyle(color: Colors.white70,)),
                  ),
                ],),

              Row(
                children: [
                  // title
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 300,
                    child: secHalf.isEmpty
                        ? new Text(fHalf, style: TextStyle(color: Colors.white60, fontSize: 15, fontStyle: FontStyle.italic),)
                        : new Column(
                        children: [
                          new Text(fHalf + "...", style: TextStyle(color: Colors.white60, fontSize: 15, fontStyle: FontStyle.italic),), //: (firstHalf + secondHalf)),
                        ]
                    ),
                    //child: Text(repoDisc ?? "", style: TextStyle(color: Colors.white70,fontSize: 12,fontWeight: FontWeight.bold)),
                  ),
                ],),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.black38,
                    child: Text("Forks: $totalForkAmount"  , style: TextStyle(color: Colors.white)),

                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.amberAccent,
                    child: Text("Stars: $totalStarAmount", style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
            ],),
        )
    );
  }
}

//second page
class SecondRoute extends StatefulWidget {
  SecondRoute({
    this.title,
    this.repoDisc,
    this.branchAmount,
    this.repoLicense,
    this.noOfCommits,
  });

  String title = "";
  String repoDisc = "";
  int branchAmount = 0;
  int noOfCommits = 0;
  String repoLicense = "";

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  
  @override
  Widget build(BuildContext context) {

    String firstHalf;
    String secondHalf;

    if (widget.repoDisc.length > 300) {
      firstHalf = widget.repoDisc.substring(0, 300);
      secondHalf = widget.repoDisc.substring(300, widget.repoDisc.length);
    }else {
      firstHalf = widget.repoDisc;
      secondHalf = "";
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text(widget.title),
      ),

      body: Center(
        child: Container(
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(5),
              color: Colors.white24),
          width:double.infinity,
         // margin: EdgeInsets.only(top: 150, bottom: 150),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:20),

                //Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(5),
                      child:
                      Text(
                          widget.title ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),

                //description
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      width: 350,
                      child: secondHalf.isEmpty
                        ? new Text(firstHalf, style: TextStyle(color: Colors.white60, fontSize: 15, fontStyle: FontStyle.italic),)
                        : new Column(
                          children: [
                            new Text(firstHalf + "...", style: TextStyle(color: Colors.white60, fontSize: 15, fontStyle: FontStyle.italic),), //: (firstHalf + secondHalf)),
                      ]
                    ),
                    )],
                ),
                SizedBox(height:20),

                //license
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: 350,
                      child:
                      Text(
                          "License: ${widget.repoLicense}",
                          style: TextStyle(color: Colors.white60, fontSize: 20),
                          textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(height:8),

                //number of commits
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: 350,
                      child:
                      Text(
                          "Commits: ${widget.noOfCommits}",
                          style: TextStyle(color: Colors.white60, fontSize: 20),
                          textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(height:8),

                //number of branches
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: 350,
                      child:
                      Text(
                          "Branches: ${widget.branchAmount}",
                          style: TextStyle(color: Colors.white60, fontSize: 20),
                          textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),

                //Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white54
                      ),
                      width: 200,
                      height: 50,

                      child: InkWell(
                        onTap: () {
                          //go back to first page
                          Navigator.pop(context);
                        },

                        child: Center(
                          child: Text(
                            'GO BACK',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],),
              ],),
        ),
      ),
    );
  }
}


