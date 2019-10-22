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
        return "http://10.28.239.20:8080/jeecg";
      default:
        return "https://thmusic.pbsz.xyz/jeecg";
    }
  }
}