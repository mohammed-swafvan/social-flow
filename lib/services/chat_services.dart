class ChatServices{
  String chatId({required String chatingUserId, required String currentUserId}) {
    if (chatingUserId[0].toLowerCase().codeUnits[0] > currentUserId.toLowerCase().codeUnits[0]) {
      return "$chatingUserId$currentUserId";
    } else {
      return "$currentUserId$chatingUserId";
    }
  }
}