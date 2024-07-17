import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/currency.dart';
import 'package:flutter_application_1/repositories/currency_repository.dart';

// Events
abstract class CurrencyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCurrencies extends CurrencyEvent {}

// States
abstract class CurrencyState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> currencies;
  CurrencyLoaded(this.currencies);

  @override
  List<Object> get props => [currencies];
}

class CurrencyError extends CurrencyState {}

// Bloc
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;
  CurrencyBloc(this.repository) : super(CurrencyInitial()) {
    on<FetchCurrencies>((event, emit) async {
      emit(CurrencyLoading());
      try {
        final currencies = await repository.fetchCurrencies();
        emit(CurrencyLoaded(currencies));
      } catch (_) {
        emit(CurrencyError());
      }
    });
  }
}
