class Utils {
  static String fullName({String? firstName, String? lastName}) {
    if (firstName == null && lastName == null) {
      return "pengguna";
    }
    return (firstName ?? '') + ' ' + (lastName ?? '');
  }
}
