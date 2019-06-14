/**
 * An object holding a flashcard, as well as its interactions
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class Flashcard {
  private String front, back, type;
  private boolean answerDisplayed;
  private Button flipButton, repeatButton, nextButton;
  private Button deleteButton;
  private int positionX, positionY;
  private int sizeWidth, sizeHeight;
  private Textfield frontField, backField;
  private int index;
  private int margin, lineWeight, lineColor, color1, color2;
  private boolean selected;
  private PFont font;

  /**
   * The contructor function for new flashcards
   *
   * @param type The type of the flashcard (text or image)
   * @param front The front side of the flashcard
   * @param back The back side of the flashcard
   * @param index The index of the flashcard on a list
   *
   */
  Flashcard(String type, String front, String back, int index) {
    this.type = type;    
    this.front = front;
    this.back = back;
    this.index = index;
    color1 = 150;
    color2 = 200;
    flipButton = new Button(width / 2, height / 2, width / 16, height / 16, true, "Flip", "CENTER", color1, color2);
    repeatButton = new Button(width / 2 - width / 16, height / 2, width / 12, height / 16, false, "Repeat", "CENTER", color1, color2);
    nextButton = new Button(width / 2 + width / 16, height / 2, width / 12, height / 16, false, "Next", "CENTER", color1, color2);
    positionX = width / 5;
    positionY = height / 12 * (index + 1);
    sizeWidth = width - positionX;
    sizeHeight = height / 12;
    selected = false;
    margin = width / 64;
    lineWeight = 2;
    lineColor = 0;
    deleteButton = new Button(positionX + sizeWidth / 4 * 3, height / 2 + sizeHeight * 3, width / 12, height / 16, true, "Delete", "LEFT", darkColor, backgroundColor); 
    font = createFont("Arial", 1);
    this.frontField = new Textfield(positionX + margin, height / 2 + sizeHeight, sizeWidth / 3, height / 5 * 2, front);
    this.backField = new Textfield(positionX + margin + sizeWidth / 8 * 3, height / 2 + sizeHeight, sizeWidth / 3, height / 5 * 2, back);
  }

  /**
   * Displays the flashcard
   *
   */
  void displayCard() {
    textFont(font, 70);
    fill(0);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    text(front, width / 2, height / 4, width - 100, height / 2 - 100);
    if (answerDisplayed) {
      text(back, width / 2, height / 4 * 3, width - 100, height / 2 - 100);
    }
    drawLine(0, height / 2, width, lineWeight, lineColor);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    displayButtons();
  }

  /**
   * Displays the menu entry of the flashcard
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
    text(front, positionX + sizeWidth / 16 * 3 + margin / 2, ((index + 1.5) * sizeHeight - (textAscent() * 0.1)) - scrollCount * height / 12, (sizeWidth / 8 * 3) - (margin), sizeHeight / 2);
    text(back, positionX + sizeWidth / 16 * 9 + margin / 2, (index + 1.5) * sizeHeight - (textAscent() * 0.1) - scrollCount * height / 12, (sizeWidth / 8 * 3) - (margin), sizeHeight / 2);
    text(type, positionX + sizeWidth / 16 * 15 + margin / 2, (index + 1.5) * sizeHeight - (textAscent() * 0.1) - scrollCount * height / 12, (sizeWidth / 8 * 3) - (margin), sizeHeight / 2);

    rectMode(CORNER);
  }

  /**
   * Toggles the flashcard as selected or not selected on the menu
   *
   * @param selected Toggled true if the flashcard is being selected on the menu
   *
   */
  void setSelect(boolean selected) {
    this.selected = selected;
  }

  /**
   * Returns true if the user's cursor is hovering over the menu entry of the flashcard
   *
   * @return True if the user's cursor is hovering over the menu entry of the flashcard
   *
   */
  boolean hoverMenuEntry() {
    if (mouseX >= positionX && mouseX <= positionX + sizeWidth && mouseY >= positionY && mouseY <= positionY + sizeHeight && mouseY >= itemHeight && mouseY <= height / 2) {
      return true;
    }
    return false;
  }

  /**
   * Displays the flashcard's textfields
   *
   */
  void displayFields() {
    if (selected) {
      textAlign(LEFT, CENTER);
      fill(0);
      textFont(bold, 40);
      text("Front", positionX + margin, height / 2 + sizeHeight / 2 - (textAscent() * 0.1));
      text("Back", positionX + margin + sizeWidth / 8 * 3, height / 2 + sizeHeight / 2 - (textAscent() * 0.1));
      frontField.display();
      backField.display();
      displayMenuButtons();
    }
  }

  /**
   * Displays the menu buttons of the flashcard
   *
   */
  void displayMenuButtons() {
    deleteButton.display();
  }

  /**
   * Displays the buttons associated with the flashcard
   *
   */
  void displayButtons() {
    flipButton.display();
    repeatButton.display();
    nextButton.display();
  }

  /**
   * Adds a character to the front or back side of the flashcard
   * 
   * @param item The side of the flashcard that is to be changed
   * @param c The character that is to be added
   *
   */
  void editAdd(String item, char c) {
    if (item.equals("front")) {
      front += c;
      frontField.text = front;
    } else if (item.equals("back")) {
      back += c;
      backField.text = back;
    }
  }

  /**
   * Deletes the last character from the front or back side of the flashcard
   * 
   * @param item The side of the flashcard that is to be changed
   *
   */
  void editDelete(String item) {
    if (item.equals("front")) {
      if (front.length() > 0) {
        front = front.substring(0, front.length() - 1);
        frontField.text = front;
      }
    } else if (item.equals("back")) {
      if (back.length() > 0) {
        back = back.substring(0, back.length() - 1);
        backField.text = back;
      }
    }
  }

  /**
   * Toggles the visibility of the flashcard's back side
   *
   */
  void flip() {
    answerDisplayed = !answerDisplayed;
    flipButton.toggleVisibility();
    repeatButton.toggleVisibility();
    nextButton.toggleVisibility();
  }

  /**
   * Resets the flashcard to its original unflipped position
   *
   */
  void reset() {
    if (answerDisplayed) {
      answerDisplayed = false;
      flipButton.toggleVisibility();
      repeatButton.toggleVisibility();
      nextButton.toggleVisibility();
    }
  }

  /**
   * Changes the index of the flashcard on a list and repositions it on the menu
   *
   * @param index The new index of the flashcard
   */
  void changeIndex(int index) {
    this.index = index; 
    positionY = itemHeight * (index + 1);
  }

  /**
   * Indicates if the flashcard is selected on the menu
   *
   * @return True if the flashcard is selected on the menu
   *
   */
  boolean selected() {
    return selected;
  }

  /**
   * Returns the front text of the flashcard
   *
   * @return The front text of the flashcard as a string
   *
   */
  String front() {
    return front;
  }

  /**
   * Returns the back text of the flashcard
   *
   * @return The back text of the flashcard as a string
   *
   */
  String back() {
    return back;
  }

  /**
   * Formats the components of the flashcard into one string
   *
   * @param separator The symbol used to separate the components of the flashcard
   *
   * @return The components of the flashcard formatted into one string
   *
   */
  String save(char separator) {
    if (front.equals("")) front = " ";
    if (back.equals("")) back = " ";
    return type + separator + front + separator + back;
  }
}
