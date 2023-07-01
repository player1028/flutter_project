import 'package:flutter_bloc/flutter_bloc.dart';


class MyHomePageBloc extends Bloc<MyHomePageEvent, MyHomePageState> {
  MyHomePageBloc() : super(MyHomePageInitial()) {
    on<MyHomePageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}