enum Env {
  LOCAL,
  TEST,
}

class Config {
  static Env env;

  static String get apiHost {
    switch (env) {
      case Env.LOCAL:
        return "http://49.232.168.124/jeecg";
      case Env.TEST:
        return "http://10.28.233.75:8080/jeecg";
      default:
        return "http://103.83.47.30:8080/phms3";
    }
  }
}