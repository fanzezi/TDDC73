import 'package:flutter/material.dart';


class carousel extends StatefulWidget {
  //Constructor grejjjs
  //widget.minvar
  @override
  _carouselState createState() => _carouselState();
}

class _carouselState extends State<carousel> {
  int photoIndex = 0;

  List<String> photos = [
    'assets/image1.jpeg',
    'assets/image2.jpeg',
    'assets/image3.jpeg'

  ];

  String getNextImageIndex() {
    String statement;
    if(photoIndex != photos.length -1){
      statement = photos[photoIndex +1];
    }else
      statement = photos[photoIndex];

    return statement;
  }

  String getPrevImageIndex() {
    String statement;
    if(photoIndex != 0){
      statement = photos[photoIndex - 1];
    }else
      statement = photos[photoIndex];

    return statement;
  }

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  // Previous image
                  photoIndex != 0 ?
                  Center(
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.5,
                          child: Container(

                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    image: AssetImage(getPrevImageIndex()),
                                    fit: BoxFit.cover
                                )),
                            height: 400.0,
                            width:50,
                          ),
                        ),
                      )
                  )

                      : Container(height: 400.0,
                    width:50,),

                  // Main image
                  Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: AssetImage(photos[photoIndex]),
                            fit: BoxFit.cover)),
                    height: 400.0, //400
                    width: 300.0, //300
                  ),


                  // Next page
                  //turn operator to not show last image
                  photoIndex != photos.length-1 ?
                  Center(
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.5,
                          child: Container(

                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage(getNextImageIndex()),
                              fit: BoxFit.cover
                            )),
                            height: 400.0,
                            width:50,
                          ),
                        ),
                      )
                  )

                   : Container(
                    height: 400.0,
                    width:50,
                  ),

                /*
                  Positioned(
                    top: 375.0,
                    left: 25.0,
                    right: 25.0,
                    child: SelectedPhoto(numberOfDots: photos.length, photoIndex: photoIndex),
                  ), */
                  /*Container(

                    height: 400,
                    width: 100,
                    child: GestureDetector(
                      onTap: _previousImage,
                    ),
                  ),
                  Container(

                    height: 400,
                    width: 100,
                    //margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: _nextImage,
                    ),
                  ),*/
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Prev'),
                  onPressed: _previousImage,
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(width: 10.0),
                RaisedButton(
                  child: Text('Next'),
                  onPressed: _nextImage,
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                ),
              ],
            )
          ],
        );
  }
}



class SelectedPhoto extends StatelessWidget {

  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(

        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0)
            ),
          ),
        )
    );
  }

  Widget _activePhoto() {
    return Container(

      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.0,
                    blurRadius: 2.0
                )
              ]
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for(int i = 0; i< numberOfDots; ++i) {
      dots.add(
          i == photoIndex ? _activePhoto(): _inactivePhoto()
      );
    }
    return dots;
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}