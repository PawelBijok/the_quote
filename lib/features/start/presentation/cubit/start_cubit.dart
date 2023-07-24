import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'start_cubit.freezed.dart';
part 'start_state.dart';

@injectable
class StartCubit extends Cubit<StartState> {
  StartCubit() : super(const StartState.initial());
}
