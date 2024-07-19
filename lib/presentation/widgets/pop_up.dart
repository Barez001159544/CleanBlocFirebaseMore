import "package:flutter/material.dart";

class PopUpWidget extends StatefulWidget {
  PopUpWidget({
    super.key,
    this.showPopup=false,
    required this.message,
    required this.closeButtonColor,
    required this.isConfirmShown,
    required this.onYes,
  });

  bool showPopup;
  final String message;
  final Color closeButtonColor;
  final bool isConfirmShown;
  final VoidCallback onYes;
  @override
  State<PopUpWidget> createState() => _PopUpWidgetState();
}

class _PopUpWidgetState extends State<PopUpWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showPopup,
      maintainState: false,
      child: SafeArea(
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      widget.isConfirmShown?widget.showPopup=false:null;
                    });
                    print("CLOSE");
                  },
                  child: Container(
                    color: widget.closeButtonColor,
                    width: 70,
                    height: 70,
                    child: Center(child: Icon(widget.isConfirmShown?Icons.close:Icons.error_outline,)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(widget.message,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                widget.isConfirmShown?
                GestureDetector(
                  onTap: (){
                    widget.onYes();
                    print("YES");
                    setState(() {
                      widget.showPopup=false;
                    });
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.white,
                    child: Center(
                      child: Text("Yes",
                        style: TextStyle(color: Colors.black, fontSize: 18),),
                    ),
                  ),
                ):SizedBox(width: 70, height: 70,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
