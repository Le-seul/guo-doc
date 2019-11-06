enum Env {
  LOCAL,
  TEST,
}

class Config {
  static Env env;

  static String get apiHost {
    switch (env) {
      case Env.LOCAL:
        return "http://10.128.246.120:8080/jeecg";
      case Env.TEST:
        return "http://10.28.135.182:8080/jeecg";
      default:
        return "https://www.aireading.club/jeecg";
    }
  }
}