// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class DataState<T> extends Equatable {
  final T? data;
  final DioException? error;
  const DataState({
    this.data,
    this.error,
  });

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({required T data}) : super(data: data);
  @override
  List<Object> get props => [data!];
}

class DataError<T> extends DataState<T> {
  const DataError({required DioException error}) : super(error: error);
  @override
  List<Object> get props => [error!];
}
