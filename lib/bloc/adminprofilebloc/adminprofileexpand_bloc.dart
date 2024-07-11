import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adminprofileexpand_event.dart';
part 'adminprofileexpand_state.dart';

class AdminprofileexpandBloc extends Bloc<AdminprofileexpandEvent, AdminprofileexpandState> {
  AdminprofileexpandBloc() : super(AdminprofileexpandInitial()) {
    on<AdminprofileexpandEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
