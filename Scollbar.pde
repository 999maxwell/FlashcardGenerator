/**
 * An object holding the position, dimensions, appearance, and interactions of a button
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class Scrollbar {
  private int positionX, positionY;
  private int sizeWidth, sizeHeight;
  private int positionYBack;
  private int sizeHeightBack;
  private int hoverX, hoverY, hoverWidth, hoverHeight;
  private int itemAmt;
  private int maxItem;
  private int scrollCount;
  private color colorBack, colorScroll;

  /**
   * The constructor function for new scrollbars
   *
   * @param positionX The horizontal position of the scrollbar
   * @param positionYBack The vertical position of the scrollbar's background
   * @param sizeWidth The horizontal size of the scrollbar
   * @param sizeHeightBack The vertical position of the Scollar's background);
   * @param hoverX The horizontal position of the area that the scrollbar is responbible for
   * @param hoverY The vertical position of the area that the scrollbar is responbible for
   * @param hoverWidth The horizontal size of the area that the scrollbar is responbible for
   * @param hoverHeight The vertical size of the area that the scrollbar is responbible for
   * @param itemAmt The number of items on the menu
   * @param maxItem The maximum number of items that can fit on the screen
   *
   */
  Scrollbar(int positionX, int positionYBack, int sizeWidth, int sizeHeightBack, int hoverX, int hoverY, int hoverWidth, int hoverHeight, int itemAmt, int maxItem) {
    this.positionX = positionX;
    this.positionYBack = positionYBack;
    this.sizeWidth = sizeWidth;
    this.sizeHeightBack = sizeHeightBack;
    this.itemAmt = itemAmt;
    this.hoverX = hoverX;
    this.hoverY = hoverY;
    this.hoverWidth = hoverWidth;
    this.hoverHeight = hoverHeight;
    this.maxItem = maxItem;
    positionY = positionYBack;
    if (itemAmt <= maxItem) {
      sizeHeight = sizeHeightBack;
    } else {
      sizeHeight = int(sizeHeightBack / (itemAmt * 1f / maxItem));
    }
    colorBack = 200;
    colorScroll = 150;
    scrollCount = 0;
  }

  /**
   * Displays the scrollbar
   *
   */
  void display() {
    rectMode(CORNER);
    strokeWeight(2);
    stroke(0);
    fill(colorBack);
    rect(positionX, positionYBack, sizeWidth, sizeHeightBack);
    fill(colorScroll);
    rect(positionX, positionY + scrollCount * sizeHeightBack * 1f / itemAmt, sizeWidth, sizeHeight);
  }

  /**
   * Updates the scrollbars size given an updated number of items on the menu
   *
   * @param itemAmt The new number of items on the menu
   *
   */
  void updateSize(int itemAmt) {
    this.itemAmt = itemAmt;
    positionY = positionYBack;
    if (itemAmt <= maxItem) {
      sizeHeight = sizeHeightBack;
    } else {
      sizeHeight = int(sizeHeightBack / (itemAmt * 1f / maxItem));
    }
  }

  /**
   * Returns true if the user's cursor is hovering over the hover area
   *
   * @return True if the user's cursor is hovering over the hover area
   *
   */
  boolean hover() {
    if (mouseX >= hoverX - hoverWidth / 2 && mouseX <= hoverX + hoverWidth / 2 && mouseY >= hoverY - hoverHeight / 2 && mouseY <= hoverY + hoverHeight / 2) {
      return true;
    }
    return false;
  }

  /**
   * Returns the number of times the scrollbar has scrolled
   *
   * @return The number of times the scrollbar has scrolled
   *
   */
  int scrollCount() {
    return scrollCount;
  }
  
  /**
   * Updates the number of times the scrollbar has scrolled
   *
   * @param value The change in the number of times the scrollbar has scrolled
   *
   */
  void updateScrollCount(int value) {
    scrollCount += value;
    if (scrollCount < 0) scrollCount = 0;
    if (itemAmt < maxItem) {
      scrollCount = 0;
    } else if (scrollCount > itemAmt - maxItem) scrollCount = itemAmt - maxItem;
  }
}
