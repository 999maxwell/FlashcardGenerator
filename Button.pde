/**
 * An object holding the position, dimensions, appearance, and interactions of a button
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class Button {
  private int positionX, positionY;
  private int sizeWidth, sizeHeight;
  private boolean visible;
  private String text, align;
  private color color1, color2;
  private PFont font;

  /**
   * The constructor function for new buttons
   *
   * @param positionX The horizontal position of the center of the button
   * @param positionY The vertical position of the center of the button
   * @param sizeWidth The horizontal size of the button
   * @param sizeHeight The vertical size of the button
   * @param visible Controls the visibility of the button on-screen
   * @param text The text on the button
   * @param align The alignment of the button
   * @param color1 The color of the button when hovered
   * @param color2 The color of the button when not hovered
   *
   */
  Button(int positionX, int positionY, int sizeWidth, int sizeHeight, boolean visible, String text, String align, color color1, color color2) {
    this.positionX = positionX;
    this.positionY = positionY; 
    this.sizeWidth = sizeWidth; 
    this.sizeHeight = sizeHeight;
    this.visible = visible;
    this.text = text;
    this.align = align;
    this.color1 = color1;
    this.color2 = color2;
    font = createFont("Arial", 1);
  }

  /**
   * Displays the button
   *
   */
  void display() {
    if (visible) {
      if (align.equals("CENTER")) {
        rectMode(CENTER);
        textAlign(CENTER, CENTER);
        strokeWeight(2);
        stroke(0);
        fill(hover() ? color1 : color2);
        rect(positionX, positionY, sizeWidth, sizeHeight);
        fill(0);
        textFont(font, 40);
        text(text, positionX, positionY - (textAscent() * 0.1));
      } else {
        rectMode(CORNER);
        textAlign(CENTER, CENTER);
        strokeWeight(2);
        stroke(0);
        fill(hover() ? color1 : color2);
        rect(positionX, positionY, sizeWidth, sizeHeight);
        fill(0);
        textFont(font, 40);
        text(text, (2 * positionX + sizeWidth) / 2, (2 * positionY + sizeHeight) / 2 - (textAscent() * 0.1));
      }
    }
  }

  /**
   * Returns true if the user's cursor is hovering over the button
   *
   * @return True if the user's cursor is hovering over the button
   *
   */
  boolean hover() {
    if (align.equals("CENTER")) {
      if (visible && mouseX >= positionX - sizeWidth / 2 && mouseX <= positionX + sizeWidth / 2 && mouseY >= positionY - sizeHeight / 2 && mouseY <= positionY + sizeHeight / 2) {
        return true;
      }
      return false;
    }
    if (visible && mouseX >= positionX && mouseX <= positionX + sizeWidth && mouseY >= positionY && mouseY <= positionY + sizeHeight) {
      return true;
    }
    return false;
  }

  /**
   * Toggles the visibility of the button
   *
   */
  void toggleVisibility() {
    visible = !visible;
  }
}
