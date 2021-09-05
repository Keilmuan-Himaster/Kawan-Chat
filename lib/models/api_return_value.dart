class ApiReturnValue<T> {
  final T? value;
  final bool? isSuccess;
  final String? message, result;

  ApiReturnValue({this.isSuccess, this.message, this.value, this.result});
}