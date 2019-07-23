
class BaseEntity<T>{

  int statusCode;
  String msg;
  T data;
  
  BaseEntity(this.statusCode, this.msg, this.data);
}