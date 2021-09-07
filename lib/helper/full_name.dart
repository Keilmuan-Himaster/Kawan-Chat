String fullName({String? firstName, String? lastName}) {
  if (firstName == null && lastName == null) {
    return "Pengguna";
  }
  return (firstName ?? '') + ' ' + (lastName ?? '');
}