
class BaseEntity<T>{

  int statusCode;
  String msg;
  T obj;
  
  BaseEntity(this.statusCode, this.msg, this.obj);
}