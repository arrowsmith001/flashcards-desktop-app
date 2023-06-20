
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class FlashcardDirectoryViewModel extends StatefulWidget {

  final FlashcardDirectory flashcardDirectory;
  late CheckboxChanged checkboxChanged = CheckboxChanged<FlashcardDirectory>(false, flashcardDirectory);

  FlashcardDirectoryViewModel(this.flashcardDirectory, {super.key});

  @override
  State<StatefulWidget> createState() {
    return FlashcardDirectoryViewModelState();
  }

  
  
}

class CheckboxChanged<T> extends Notification {
  CheckboxChanged(this.selected, this.source);
  bool selected;
  T source;
}

class FlashcardDirectoryViewModelState extends State<FlashcardDirectoryViewModel>{
  FlashcardDirectoryViewModelState(){
  }

  final Logger logger = Logger();

  FlashcardDirectory _flashcardDirectory() => widget.flashcardDirectory;

  @override
  Widget build(BuildContext context) {
return Container();
  
  }

}