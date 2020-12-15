import 'package:flutter/material.dart';


class Carousel extends StatefulWidget {
  //Constructor for carousel class
  Carousel({this.inputPhotos, this.inputWidgets});

  final List<Widget> inputWidgets;
  final List<String> inputPhotos;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int photoIndex = 0;

  //Get the input widget
  Widget _getWidget() {
    int photoLen = widget.inputPhotos.length;

    // If user forget to add an image to a widget the next widget will not be displayed
    if( widget.inputWidgets[photoIndex] == null && (photoIndex > photoLen  || photoIndex < photoLen)){
      return Container();
    }
    else {
      // else return the current widget
      return widget.inputWidgets[photoIndex];
    }
  }

  //Get the next image
  String getNextImageIndex() {
    String statement;
    if(photoIndex != widget.inputPhotos.length -1){
      statement = widget.inputPhotos[photoIndex +1];
    }else
      statement = widget.inputPhotos[photoIndex];
    return statement;
  }

  //Get the previous image
  String getPrevImageIndex() {
    String statement;
    if(photoIndex != 0){
      statement = widget.inputPhotos[photoIndex - 1];
    }else
      statement = widget.inputPhotos[photoIndex];
    return statement;
  }

  void _previousImage() {
    //Set state to get previous photoindex when press the Prev button
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }


  void _nextImage() {
    //Set state to get next photoindex when press the Next button
    setState(() {
      photoIndex = photoIndex < widget.inputPhotos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  // Show previous image
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
                  // If first image, show no previous image (with turn operator)
                      : Container(height: 400.0,
                    width:50,),

                  // Main image
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: AssetImage(widget.inputPhotos[photoIndex]),
                            fit: BoxFit.cover
                          ),
                        ),
                    height: 450.0,
                    width: 300.0,
                    child: _getWidget(),
                  ),

                  // Show next image
                  photoIndex != widget.inputPhotos.length-1 ?
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

                  // If last image, show no next image (with turn operator)
                   : Container(
                    height: 400.0,
                    width:50,
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Prev', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  onPressed: _previousImage,
                  elevation: 5.0,
                  color: Color(0xff79a3b1),

                ),
                SizedBox(width: 10.0),
                RaisedButton(
                  child: Text('Next',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  onPressed: _nextImage,
                  elevation: 5.0,
                  color: Color(0xff79a3b1),
                ),
              ],
            )
          ],
        );
  }
}

