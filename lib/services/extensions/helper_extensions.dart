extension RemoveDuplicates<T> on List<T> {
  List<T> removeDuplicates() {
    Set<T> set = Set<T>.from(this); // Convert list to set
    List<T> result = List<T>.from(set); // Convert set back to list
    return result;
  }
}
