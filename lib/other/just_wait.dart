Future<void> justWait(int time) {
  return Future.delayed(Duration(milliseconds: time));
}