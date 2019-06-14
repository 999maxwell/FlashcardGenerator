/**
 * An object holding the position, dimensions, appearance, and interactions of a textfield
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class Textfield {
  private int positionX, positionY;
  private int sizeWidth, sizeHeight;
  private String text;
  private boolean selected;
  private PFont font;

  /**
   * The constructor function for new textfields
   *
   * @param positionX The horizontal position of the top-left corner of the textfield
   * @param positionY The vertical position of the top-left corner of the textfield
   * @param sizeWidth The horizontal size of the textfield
   * @param sizeHeight The vertical size of the textfield
   * @param text The text that is displayed in the textfield
   *
   */
  Textfield (int positionX, int positionY, int sizeWidth, int sizeHeight, String text) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.sizeWidth = sizeWidth;
    this.sizeHeight = sizeHeight;
    this.text = text;
    selected = false;
    font = createFont("Arial", 1);
  }
  
  /**
   * Displays the textfield
   *
   */
  void display() {
    rectMode(CORNER);
    stroke(2);
    fill(255);
    rect(positionX, positionY, sizeWidth, sizeHeight);
    textFont(font, 20);
    fill(0);
    textAlign(LEFT, TOP);
    text(text, positionX + 10, positionY + 10, sizeWidth - 10, sizeHeight - 10);
    noStroke();
  }
  
  /**
   * Returns true if the user's cursor is hovering over the textfield
   *
   * @return True if the user's cursor is hovering over the textfield
   *
   */
  boolean hover() {
    if (mouseX >= positionX && mouseX <= positionX + sizeWidth && mouseY >= positionY && mouseY <= positionY + sizeHeight) {
      return true;
    }
    return false;
  }
  
  /**
   * Toggles the textfield as selected or not selected on the menu
   *
   * @param selected If the textfield is being selected
   *
   */
  void setSelect(boolean selected) {
    this.selected = selected;
  }
}
