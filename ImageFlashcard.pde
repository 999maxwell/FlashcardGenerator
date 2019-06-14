/**
 * An object holding a flashcard with an image, as well as its interactions
 * 
 * @author Maxwell Jiang
 * @since Processing 3.5.3
 * @version 1.0
 *
 */
class ImageFlashcard extends Flashcard {
  private PImage frontImage, backImage;
  private String frontImagePath, backImagePath;
  private int frontImageWidth, backImageWidth, frontImageHeight, backImageHeight;
  private Button uploadButtonFront, uploadButtonBack;

  /**
   * The contructor function for new flashcards
   *
   * @param type The type of the flashcard (text or image)
   * @param front The caption of the front side of the flashcard
   * @param back The caption of the back side of the flashcard
   * @param frontImage The image on the front side of the flashcard
   * @param backImage The image on the back side of the flashcard
   * @param index The index of the flashcard on a list
   *
   */
  ImageFlashcard(String type, String front, String back, String frontImagePath, String backImagePath, int index) {
    super(type, front, back, index);
    this.frontImagePath = frontImagePath;
    this.backImagePath = backImagePath;
    this.frontImage = loadImage(frontImagePath);
    this.backImage = loadImage(backImagePath);
    frontImageHeight = frontImage == null ? 0 : frontImage.height;
    backImageHeight = backImage == null ? 0 : backImage.height;
    frontImageWidth = frontImage == null ? 0 : frontImage.width;
    backImageWidth = backImage == null ? 0 : backImage.width;
    uploadButtonFront = new Button(super.positionX + super.margin + width / 15, height / 2 + super.sizeHeight / 8, width / 12, height / 16, true, "Upload", "LEFT", darkColor, backgroundColor);
    uploadButtonBack = new Button(super.positionX + super.margin + super.sizeWidth / 8 * 3 + width / 15, height / 2 + super.sizeHeight / 8, width / 12, 
      height / 16, true, "Upload", "LEFT", darkColor, backgroundColor);
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
    imageMode(CENTER);
    if (frontImageHeight != 0) {
      displayImage(width / 4, height / 4, frontImageWidth, frontImageHeight, width / 2 - 100, height / 2 - 100, frontImage);
      text(super.front, width / 4 * 3, height / 4, width / 2 - 100, height / 2 - 100);
    } else {
      text(super.front, width / 2, height / 4, width - 100, height / 2 - 100);
    }
    if (super.answerDisplayed) {
      if (backImageHeight != 0) {
        displayImage(width / 4, height / 4 * 3, backImageWidth, backImageHeight, width / 2 - 100, height / 2 - 100, backImage);
        text(super.back, width / 4 * 3, height / 4 * 3, width - 100, height / 2 - 100);
      } else {
        text(super.back, width / 2, height / 4 * 3, width - 100, height / 2 - 100);
      }
    }
    drawLine(0, height / 2, width, lineWeight, lineColor);
    displayButtons();
  }

  /**
   * Resizes an image to size constraints and displays the image
   *
   * @param x The horizontal position of the center of the image
   * @param y The vertical position of the center of the image
   * @param imageWidth The horizontal size of the original image
   * @param imageHeight The vertical size of the original image
   * @param widthConstraint The maximum horizontal size of the displayed image
   * @param heightConstraint The maximum vertical size of the displayed image
   * @param image The image that is to be displayed
   *
   */
  void displayImage(int x, int y, int imageWidth, int imageHeight, int widthConstraint, int heightConstraint, PImage image) {
    if (imageHeight / heightConstraint > imageWidth / widthConstraint) {
      image.resize(0, heightConstraint);
    } else {
      image.resize(widthConstraint, 0);
    }
    image(image, x, y);
  }

  /**
   * Displays the menu buttons of the flashcard
   *
   */
  void displayMenuButtons() {
    super.deleteButton.display(); 
    uploadButtonFront.display();
    uploadButtonBack.display();
    rectMode(CORNER);
    textAlign(LEFT, CENTER);
    if (frontImage == null) {
      text("No image", super.positionX + super.margin + width / 6, height / 2 + super.sizeHeight / 2 - (textAscent() * 0.1));
    } else {
      text(frontImagePath.substring(frontImagePath.lastIndexOf('/') + 1), super.positionX + super.margin + width / 6, height / 2 + super.sizeHeight / 4 - (textAscent() * 0.1), 
        width / 12, super.sizeHeight / 2);
    }
    if (backImage == null) {
      text("No image", super.positionX + super.margin + super.sizeWidth / 8 * 3 + width / 6, height / 2 + super.sizeHeight / 2 - (textAscent() * 0.1));
    } else {
      text(backImagePath.substring(backImagePath.lastIndexOf('/') + 1), super.positionX + super.margin + super.sizeWidth / 8 * 3 + width / 6, height / 2 + super.sizeHeight / 4 - (textAscent() * 0.1), 
        width / 12, super.sizeHeight / 2);
    }
  }

  /**
   * Sets the path of the flashcard's front image
   *
   * @param path The path of the image
   *
   */
  void setImageFront(String path) {
    frontImagePath = path;
  }

  /**
   * Sets the path of the flashcard's back image
   *
   * @param path The path of the image
   *
   */
  void setImageBack(String path) {
    backImagePath = path;
  }

  /**
   * Updates the flashcard's images based on their paths
   *
   */
  void updateImages() {
    frontImage = loadImage(frontImagePath);
    backImage = loadImage(backImagePath);
    frontImageHeight = frontImage == null ? 0 : frontImage.height;
    backImageHeight = backImage == null ? 0 : backImage.height;
    frontImageWidth = frontImage == null ? 0 : frontImage.width;
    backImageWidth = backImage == null ? 0 : backImage.width;
  }

  /**
   * Formats the components of the flashcard into one string
   *
   * @param separator The symbol used to separate the components of the flashcard
   *
   * @return The components of the flashcard formatted into one string
   *
   */
  @Override
    String save(char separator) {
    if (super.front.equals("")) super.front = " ";
    if (super.back.equals("")) super.back = " ";
    return super.type + separator + super.front + separator + super.back + separator + frontImagePath + separator + backImagePath;
  }
}
