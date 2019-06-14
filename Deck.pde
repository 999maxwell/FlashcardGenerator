/**
 * An object holding a deck of cards, as well as its interactions
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class Deck {
  private LinkedList<Flashcard> cards;
  private String name;
  private int index;
  private int positionX, positionY;
  private int sizeWidth, sizeHeight;
  private boolean selected;
  private int margin, lineWeight, color1, color2;
  private PFont font;

  /**
   * The constructor function for new decks
   *
   * @param name The name of the deck
   * @param index The index of the deck on a list
   *
   */
  Deck(String name, int index) {
    this.name = name;
    this.index = index;
    cards = new LinkedList<Flashcard>();
    positionX = 0;
    positionY = height / 12 * (index + 1);
    sizeWidth = width / 5;
    sizeHeight = height / 12;
    selected = false;
    margin = width / 64;
    lineWeight = 2;
    lineColor = 0;
    color1 = 150;
    color2 = 200;
    font = createFont("Arial", 1);
  }

  /**
   * Displays the menu entry of the deck
   *
   * @param scrollCount The number of times that the menu has scrolled down
   *
   */
  void displayMenuEntry(int scrollCount) {
    rectMode(CORNER);
    fill(hoverMenuEntry() || selected ? color1 : color2);
    rect(positionX, positionY, sizeWidth, sizeHeight);
    drawLine(positionX, positionY, sizeWidth, lineWeight, color1);
    drawLine(positionX, positionY + sizeHeight, sizeWidth, lineWeight, color1);
    fill(0);
    rectMode(CENTER);
    textAlign(LEFT, CENTER);
    textFont(font, 40);
    positionY = height / 12 * (index + 1) - scrollCount * height / 12;
    text(name, positionX + sizeWidth / 2 + margin / 2, ((index + 1.5) * sizeHeight - (textAscent() * 0.1)) - scrollCount * height / 12, sizeWidth - (margin), sizeHeight / 2);
    rectMode(CORNER);
  }

  /**
   * Adds a card to the deck
   *
   * @param card The card to be added
   *
   */
  void addCard(Flashcard card) {
    cards.add(card);
  }

  /**
   * Removes a card to the deck
   *
   * @param index The index of the card to be removed
   *
   */
  void removeCard(int index) {
    cards.remove(index);
  }

  /**
   * Returns a card in the deck
   *
   * @param index The index of the card to be returned
   * 
   * @return The desired flashcard in the deck
   *
   */
  Flashcard getCard(int index) {
    return cards.get(index);
  }

  /**
   * Returns the size of the deck
   *
   * @return The size of the deck
   *
   */
  int size() {
    return cards.size();
  }

  /**
   * Returns the list of cards in the deck
   *
   * @return THe list of cards in the deck as a linked list
   *
   */
  LinkedList<Flashcard> list() {
    return cards;
  }

  /**
   * Returns true if the user's cursor is hovering over the menu entry of the deck
   *
   * @return True if the user's cursor is hovering over the menu entry of the deck
   *
   */
  boolean hoverMenuEntry() {
    if (mouseX >= positionX && mouseX <= positionX + sizeWidth && mouseY >= positionY && mouseY <= positionY + sizeHeight && mouseY >= itemHeight && mouseY <= height / 6 * 5) {
      return true;
    }
    return false;
  }

  /**
   * Returns the name of the deck
   *
   * @return The name of the deck as a string
   *
   */
  String getName() {
    return name;
  }

  /**
   * Toggles the deck as selected or not selected on the menu
   *
   * @param selected Toggled true if the deck is being selected on the menu
   *
   */
  void setSelect(boolean selected) {
    this.selected = selected;
  }

  /**
   * Changes the index of the deck on a list and repositions it on the menu
   *
   * @param index The new index of the deck
   *
   */
  void changeIndex(int index) {
    this.index = index; 
    positionY = itemHeight * (index + 1);
  }

  /**
   * Adds a character to the name of the deck
   * 
   * @param c The character that is to be added
   *
   */
  void editAdd(char c) {
    name += c;
  }

  /**
   * Deletes the last character from the name of the deck
   *
   */
  void editDelete() {
    if (name.length() > 0) {
      name = name.substring(0, name.length() - 1);
    }
  }

  /**
   * Formats the components of the deck into one string
   *
   * @param The symbol associated with the deck
   *
   * @return The components of the deck formatted into one string
   *
   */
  String save(char tag) {
    return tag + "" + name;
  }
}
