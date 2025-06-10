part of 'sales_dash_cubit.dart';

sealed class SalesDashState {}

final class SalesDashInitial extends SalesDashState {}

final class SalesDashSuccess extends SalesDashState {
  final int? totalIncome;
  final int? totalCustomers;
  final int? totalMovies;
  SalesDashSuccess({this.totalIncome, this.totalCustomers, this.totalMovies});
}

final class SalesDashLoading extends SalesDashState {}

final class SalesDashError extends SalesDashState {
  final String message;
  SalesDashError(this.message);
}
