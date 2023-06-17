class ChatMethods {
  String checkingId({required String user, required String currentUser}) {
    if (user[0].toLowerCase().codeUnits[0] > currentUser.toLowerCase().codeUnits[0]) {
      return "$user$currentUser";
    } else {
      return "$currentUser$user";
    }
  }
}
