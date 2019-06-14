/**
 * An object holding a comparator for the fronts of flashcards
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class FrontCompare implements Comparator<Flashcard> {
  
  /**
   * Compares two flashcards in lexicographical order
   *
   * @param card1 The first card to be compared
   * @param card2 The second card to be compared
   *
   * @return The greatest card in lexicographical order
   *
   */
  public int compare(Flashcard card1, Flashcard card2) {
    return card1.front().toLowerCase().compareTo(card2.front().toLowerCase());
  }
}

/**
 * An object holding a comparator for the backs of flashcards
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class BackCompare implements Comparator<Flashcard> {
  
  /**
   * Compares two flashcards in lexicographical order
   *
   * @param card1 The first card to be compared
   * @param card2 The second card to be compared
   *
   * @return The greatest card in lexicographical order
   *
   */
  public int compare(Flashcard card1, Flashcard card2) {
    return card1.back().toLowerCase().compareTo(card2.back().toLowerCase());
  }
}
