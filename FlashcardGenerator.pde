import java.util.*;
import java.io.*;
import java.text.*;

PFont font, bold;
LinkedList<Deck> deckList;
Button addTextButton, addImageButton, studyButton, newDeckButton, renameDeckButton, deleteDeckButton, exitButton;
int cardIndex; //card being displayed
int lineWeight;
char separator, deckTag;
color backgroundColor, lineColor, darkColor;
Flashcard currentCard;
int sidebarWidth, itemHeight, margin, editHeight;
int selectIndex; //card selected on menu
String selectFront, selectBack;
int screen;
String[] lines;
int deckIndex;
boolean deckRename;
Column frontColumn, backColumn;
Scrollbar cardScroll, deckScroll;

/**
 * Initializes variables, objects, and handles input
 *
 */
void setup() {
  fullScreen();
  font = createFont("Arial", 1);
  bold = createFont("Arial Bold", 1);
  screen = 0;
  separator = '~';
  deckTag = '@';
  cardIndex = 0;
  lineWeight = 2;
  backgroundColor = 200;
  lineColor = 0;
  darkColor = 150;
  sidebarWidth = width / 5; 
  itemHeight = height / 12;
  margin = width / 64;
  editHeight = height / 2;
  selectIndex = -1;
  selectFront = selectBack = "";
  deckIndex = 0;
  deckRename = false;
  frontColumn = new Column(sidebarWidth, 0, (width - sidebarWidth) / 8 * 3, itemHeight, darkColor, backgroundColor);
  backColumn = new Column(sidebarWidth + (width - sidebarWidth) / 8 * 3, 0, (width - sidebarWidth) / 8 * 3, itemHeight, darkColor, backgroundColor);
  addTextButton = new Button(sidebarWidth + (width - sidebarWidth) / 4 * 3, editHeight + itemHeight, width / 7, height / 16, true, "Add text card", "LEFT", darkColor, backgroundColor); 
  addImageButton = new Button(sidebarWidth + (width - sidebarWidth) / 4 * 3, editHeight + itemHeight * 2, width / 6, height / 16, true, "Add image card", "LEFT", darkColor, backgroundColor); 
  studyButton = new Button(margin, height / 5 * 4 + itemHeight / 7 * 5, width / 14, height / 18, true, "Study", "LEFT", darkColor, backgroundColor);
  newDeckButton = new Button(sidebarWidth / 2 + margin, height / 5 * 4 + itemHeight / 7 * 5, width / 18, height / 18, true, "New", "LEFT", darkColor, backgroundColor);
  renameDeckButton = new Button(margin, height / 5 * 4 + itemHeight / 2 * 3, width / 12, height / 18, true, "Rename", "LEFT", darkColor, backgroundColor);
  deleteDeckButton = new Button(sidebarWidth / 2 + margin, height / 5 * 4 + itemHeight / 2 * 3, width / 13, height / 18, true, "Delete", "LEFT", darkColor, backgroundColor);
  exitButton = new Button(margin, margin, width / 16, height / 18, true, "Menu", "LEFT", darkColor, backgroundColor);
  lines = loadStrings("flashcards.txt");
  deckList = new LinkedList<Deck>();
  int deckIndexTemp = -1;
  int cardIndexTemp = 0;
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].replace("\uFEFF", "");
    lines[i] = lines[i].replace("\uFFFF", "");
    if (lines[i].charAt(0) == deckTag) {
      deckIndexTemp++;
      cardIndexTemp = 0;
      deckList.add(new Deck(lines[i].substring(1), deckIndexTemp));
      continue;
    }
    String[] line = lines[i].split(separator + "");
    String type = line[0];
    switch (type) {
    case "Text":
      deckList.get(deckIndexTemp).addCard(new Flashcard(type, line[1], line[2], cardIndexTemp)); 
      break;
    case "Image":
      deckList.get(deckIndexTemp).addCard(new ImageFlashcard(type, line[1], line[2], line[3], line[4], cardIndexTemp));
      break;
    }
    cardIndexTemp++;
  }
  deckList.get(0).setSelect(true);
  cardScroll = new Scrollbar(width / 32 * 31, itemHeight, width / 32, editHeight - itemHeight, (sidebarWidth + width) / 2, 
    (itemHeight + editHeight) / 2, width - sidebarWidth, editHeight - itemHeight, deckList.get(deckIndex).size(), 5);
  deckScroll = new Scrollbar(sidebarWidth - width / 32, itemHeight, width / 32, height / 6 * 5 - itemHeight, sidebarWidth / 2, 
    (itemHeight + height / 5 * 4) / 2, sidebarWidth, height / 6 * 5 - itemHeight, deckList.size(), 9);
}

/**
 * The main loop of the program
 *
 */
void draw() {
  background(backgroundColor);
  switch (screen) {
  case 0:
    menu();
    break;
  case 1:
    currentCard.displayCard();
    exitButton.display();
    break;
  }
}

/**
 * Draws a horizontal or vertical line
 *
 * @param positionX The horizontal position of one end of the line
 * @param positionY The vertical position of one end of the line
 * @param sizeWidth The horizontal size of the line
 * @param sizeHeight The vertical size of the line
 * @param lineColor The color of the line
 *
 */
void drawLine(float positionX, float positionY, float sizeWidth, float sizeHeight, color lineColor) {
  noStroke();
  rectMode(CORNER);
  fill(lineColor);
  rect(positionX, positionY, sizeWidth, sizeHeight);
}

/**
 * Relabels the indices of all the cards in a deck
 *
 */
void reassignCardIndices() {
  for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
    deckList.get(deckIndex).getCard(i).changeIndex(i);
  }
}

/**
 * Reassigns the index of the selected card
 *
 */
void swapCardIndices() {
  reassignCardIndices();
  if (selectIndex != -1) {
    for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
      if (deckList.get(deckIndex).getCard(i).selected()) selectIndex = i;
    }
  }
}

/**
 * Handles clicks on textfields
 *
 */
void processTextFieldClick() {
  for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
    deckList.get(deckIndex).getCard(i).frontField.setSelect(false);
    deckList.get(deckIndex).getCard(i).backField.setSelect(false);
  }
  if (selectIndex != -1) {
    if (deckList.get(deckIndex).getCard(selectIndex).frontField.hover()) {
      deckList.get(deckIndex).getCard(selectIndex).frontField.setSelect(true);
    } else if (deckList.get(deckIndex).getCard(selectIndex).backField.hover()) {
      deckList.get(deckIndex).getCard(selectIndex).backField.setSelect(true);
    }
  }
}

/**
 * Handles clicks on card decks
 *
 */
void processDeckMenuClick() {
  for (int i = 0; i < deckList.size(); i++) {
    if (deckList.get(i).hoverMenuEntry()) {
      for (int j = 0; j < deckList.size(); j++) {
        deckList.get(j).setSelect(false);
      }
      for (int j = 0; j < deckList.get(deckIndex).size(); j++) { //when selecting a new deck, make all cards in the previous deck to selected=false
        deckList.get(deckIndex).getCard(j).setSelect(false);
      }
      selectIndex = -1;
      deckList.get(i).setSelect(true);
      deckIndex = i;
      cardScroll.updateSize(deckList.get(deckIndex).size());
      cardScroll.updateScrollCount(0);
    }
  }
}

/**
 * Handles click on cards
 *
 */
void processCardMenuClick() {
  for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
    if (deckList.get(deckIndex).getCard(i).hoverMenuEntry()) {
      for (int j = 0; j < deckList.get(deckIndex).size(); j++) {
        deckList.get(deckIndex).getCard(j).setSelect(false);
      }
      deckList.get(deckIndex).getCard(i).setSelect(true);
      selectIndex = i;
    }
  }
}

/**
 * Handles click on sorting columns
 *
 */
void processColumnClick() {
  if (frontColumn.hover()) {
    FrontCompare frontCompare = new FrontCompare();
    Collections.sort(deckList.get(deckIndex).list(), frontCompare);
    swapCardIndices();
  } else if (backColumn.hover()) {
    BackCompare backCompare = new BackCompare();
    Collections.sort(deckList.get(deckIndex).list(), backCompare);
    swapCardIndices();
  }
}

/**
 * Handles adding a text card to a deck
 *
 */
void processAddTextCard() {
  if (addTextButton.hover()) {
    deckList.get(deckIndex).addCard(new Flashcard("Text", "Sample front", "Sample back", deckList.get(deckIndex).size()));
    cardScroll.updateSize(deckList.get(deckIndex).size());
  }
}

/**
 * Handles adding an image card to a deck
 *
 */
void processAddImageCard() {
  if (addImageButton.hover()) {
    deckList.get(deckIndex).addCard(new ImageFlashcard("Image", "Sample front", "Sample back", " ", " ", deckList.get(deckIndex).size()));
    cardScroll.updateSize(deckList.get(deckIndex).size());
  }
}

/**
 * Handles deleting a card from a deck
 *
 */
void processDeleteCard() {
  if (selectIndex != -1) {
    if (deckList.get(deckIndex).size() > 1) {
      if (deckList.get(deckIndex).getCard(selectIndex).deleteButton.hover()) {
        deckList.get(deckIndex).removeCard(selectIndex);
        reassignCardIndices();
        selectIndex = -1;
        for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
          deckList.get(deckIndex).getCard(i).setSelect(false);
        }
        cardScroll.updateSize(deckList.get(deckIndex).size());
        cardScroll.updateScrollCount(0);
      }
    }
  }
}

/**
 * Handles taking images as input
 *
 */
void processUploadImage() {
  if (selectIndex != -1) {
    if (deckList.get(deckIndex).getCard(selectIndex) instanceof ImageFlashcard) {
      ImageFlashcard card = (ImageFlashcard) deckList.get(deckIndex).getCard(selectIndex);
      if (card.uploadButtonFront.hover() || card.uploadButtonBack.hover()) {
        selectInput("Select image", "fileSelected");
      }
    }
  }
}

/**
 * Handles the processing of uploaded images to image cards
 *
 * @param file The image being processed
 *
 */
void fileSelected(File file) {
  ImageFlashcard card = (ImageFlashcard) deckList.get(deckIndex).getCard(selectIndex);
  String path = file.getAbsolutePath().replace('\\', '/');
  if (path.substring(path.lastIndexOf('.') + 1).equals("png") || path.substring(path.lastIndexOf('.') + 1).equals("jpg")) {
    if (card.uploadButtonFront.hover()) {
      card.setImageFront(path);
    } else if (card.uploadButtonBack.hover()) {
      card.setImageBack(path);
    }
  } else {
    if (card.uploadButtonFront.hover()) {
      card.setImageFront(" ");
    } else if (card.uploadButtonBack.hover()) {
      card.setImageBack(" ");
    }
  }
  card.updateImages();
}

/**
 * Handles adding decks
 *
 */
void processAddDeck() {
  if (newDeckButton.hover()) {
    deckList.add(new Deck("New deck", deckList.size()));
    deckScroll.updateSize(deckList.size());
    deckList.get(deckList.size() - 1).addCard(new Flashcard("Text", "Sample front", "Sample back", 0));
    cardScroll.updateSize(deckList.get(deckList.size() - 1).size());
  }
}

/**
 * Handles deleting decks
 *
 */
void processDeleteDeck() {
  if (deckList.size() > 1) {
    if (deleteDeckButton.hover()) {
      deckList.remove(deckIndex);
      selectIndex = -1;
      for (int i = 0; i < deckList.size(); i++) {
        deckList.get(i).changeIndex(i);
        deckList.get(i).setSelect(false);
      }
      deckIndex = 0;
      deckList.get(deckIndex).setSelect(true);
      deckScroll.updateSize(deckList.size());
      deckScroll.updateScrollCount(0);
    }
  }
}

/**
 * Prepares for the renaming of decks
 *
 */
void processRenameDeck() {
  deckRename = false;
  if (renameDeckButton.hover()) {
    deckRename = true;
  }
}

/**
 * Prepares the flashcards for studying
 *
 */
void processStudyInitiation() {
  if (studyButton.hover()) {
    screen = 1;
    Collections.shuffle(deckList.get(deckIndex).list());
    currentCard = deckList.get(deckIndex).getCard(cardIndex);
  }
}

/**
 * Handles interactions with the cards during studying
 *
 */
void processStudy() {
  if (currentCard.flipButton.hover()) {
    currentCard.flip();
  } else if (currentCard.repeatButton.hover()) {
    currentCard.flip();
  } else if (currentCard.nextButton.hover()) {
    if (cardIndex == deckList.get(deckIndex).size() - 1) {
      cardIndex = 0;
      for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
        deckList.get(deckIndex).getCard(i).reset();
      }
      screen = 0;
    } else {
      currentCard = deckList.get(deckIndex).getCard(++cardIndex);
    }
  }
}

/**
 * Handles exiting from studying to the menu
 *
 */
void processExitToMenu() {
  if (exitButton.hover()) {
    cardIndex = 0;
    screen = 0;
    for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
      deckList.get(deckIndex).getCard(i).reset();
    }
  }
}

/**
 * Handles all events involving a mouse click
 *
 */
void mouseClicked() { 
  switch (screen) {
  case 0:
    processCardMenuClick();
    processDeckMenuClick();
    processTextFieldClick();
    processColumnClick();
    processAddTextCard();
    processAddImageCard();
    processDeleteCard();
    processUploadImage();
    processAddDeck();
    processDeleteDeck();
    processRenameDeck();
    processStudyInitiation();
    break;
  case 1:
    processStudy();
    processExitToMenu();
  }
}

/**
 * Handles editing textfields
 *
 */
void processTextFieldEdit() {
  if (selectIndex != -1) {
    if (deckList.get(deckIndex).getCard(selectIndex).frontField.selected) {
      if (keyCode == BACKSPACE) {
        deckList.get(deckIndex).getCard(selectIndex).editDelete("front");
      } else if (key != ESC && key != RETURN && key != ENTER && key != TAB && key != DELETE && key != CODED && key != separator) { 
        deckList.get(deckIndex).getCard(selectIndex).editAdd("front", key);
      }
    } else if (deckList.get(deckIndex).getCard(selectIndex).backField.selected) {
      if (keyCode == BACKSPACE) {
        deckList.get(deckIndex).getCard(selectIndex).editDelete("back");
      } else if (key != ESC && key != RETURN && key != ENTER && key != TAB && key != DELETE && key != CODED && key != separator) { 
        deckList.get(deckIndex).getCard(selectIndex).editAdd("back", key);
      }
    }
  }
}

/**
 * Saves and exports flashcard data to a textfile
 *
 */
void saveFlashcards() {
  //find total # of flashcards for array size
  int sum = 0;
  for (int i = 0; i < deckList.size(); i++) {
    sum++;
    for (int j = 0; j < deckList.get(i).size(); j++) {
      sum++;
    }
  }
  String[] lines = new String[sum];
  int saveIndex = 0;
  for (int i = 0; i < deckList.size(); i++) {
    lines[saveIndex] = deckList.get(i).save(deckTag);
    for (int j = 0; j < deckList.get(i).size(); j++) {

      saveIndex++;
      lines[saveIndex] = deckList.get(i).getCard(j).save(separator);
    }
    saveIndex++;
  }
  saveStrings("data/flashcards.txt", lines);
}

/**
 * Handles renaming decks
 *
 */
void processInputRenameDeck() {
  if (deckRename) {
    Deck deck = deckList.get(deckIndex);
    if (keyCode == BACKSPACE) {
      deck.editDelete();
    } else if (key != ESC && key != RETURN && key != ENTER && key != TAB && key != DELETE && key != CODED
      && key != separator && textWidth(deck.getName()) < sidebarWidth - width / 32 - margin * 2) { 
      deck.editAdd(key);
    }
  }
}

/**
 * Handles all events involving the keyboard
 *
 */
void keyPressed() {
  switch (screen) {
  case 0:
    processTextFieldEdit();
    processInputRenameDeck();
  }
  if (key == ESC) {
    saveFlashcards();
  }
}

/**
 * Handles all events involving the mousewheel
 *
 * @param event The action performed by the mousewheel 
 *
 */
void mouseWheel(MouseEvent event) {
  float scroll = event.getCount();
  if (cardScroll.hover()) {
    cardScroll.updateScrollCount(int(scroll));
  } else if (deckScroll.hover()) {
    deckScroll.updateScrollCount(int(scroll));
  }
}
