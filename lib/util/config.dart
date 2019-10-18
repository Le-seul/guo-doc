enum Env {
  LOCAL,
  TEST,
}

class Config {
  static Env env;

  static String get apiHost {
    switch (env) {
      case Env.LOCAL:
        return "http://10.128.252.164:8080/jeecg";
      case Env.TEST:
        return "http://10.28.246.165:8080/jeecg";
      default:
        return "http://47.94.90.238/jeecg";
    }
  }
}