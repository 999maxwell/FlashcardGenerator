/**
 * An object holding the position, dimensions, appearance, and interactions of a column button
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class Column extends Button {

  /**
   * The constructor function for new column buttons
   *
   * @param positionX The horizontal position of the top-left corner of the column button
   * @param positionY The vertical position of the top-left corner of the column button
   * @param sizeWidth The horizontal size of the button
   * @param sizeHeight The vertical size of the button
   * @param color1 The color of the button when hovered
   * @param color2 The color of the button when not hovered
   *
   */
  Column(int positionX, int positionY, int sizeWidth, int sizeHeight, color color1, color color2) {
    super(positionX, positionY, sizeWidth, sizeHeight, true, "", "LEFT", color1, color2);
  }

  /**
   * Returns true if the user's cursor is hovering over the column button
   *
   * @return True if the user's cursor is hovering over the column button
   *
   */
  boolean hover() {
    noStroke();
    if (mouseX >= super.positionX && mouseX <= super.positionX + super.sizeWidth && mouseY >= super.positionY && mouseY <= super.positionY + super.sizeHeight) {
      return true;
    }
    return false;
  }
}
