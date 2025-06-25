enum Status { loading, completed, error }

class BaseApiResponse<T> {
  final Status? status;
  final T? data;
  final String? message;

  BaseApiResponse.loading([this.message])
      : status = Status.loading,
        data = null;

  BaseApiResponse.completed(this.data)
      : status = Status.completed,
        message = null;

  BaseApiResponse.error(this.message)
      : status = Status.error,
        data = null;

  @override
  String toString() {
    return 'status : $status data $data error $message ';
  }
}