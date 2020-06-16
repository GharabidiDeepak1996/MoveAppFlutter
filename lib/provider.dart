import 'package:flutter/cupertino.dart';

class NotifyChange extends ChangeNotifier{
var somthingSearch=' ';
bool isPress=false;
  void addNotifier(){
    notifyListeners();
  }

  void searchNotifier(String value){
   somthingSearch=value;
    notifyListeners();
  }

  void isPressSearchButton(bool value){
    print('------provider------>object$value');

    isPress=value;
    notifyListeners();
  }
}