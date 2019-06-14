/**
 * Displays the menu screen
 *
 */
void menu() {
  for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
    deckList.get(deckIndex).getCard(i).displayMenuEntry(cardScroll.scrollCount());
  }
  for (int i = 0; i < deckList.size(); i++) {
    deckList.get(i).displayMenuEntry(deckScroll.scrollCount());
  }
  drawLine(sidebarWidth + (width - sidebarWidth) / 8 * 3, itemHeight, lineWeight, editHeight - itemHeight, darkColor);
  drawLine(sidebarWidth + (width - sidebarWidth) / 4 * 3, itemHeight, lineWeight, editHeight - itemHeight, darkColor);
  fill(backgroundColor);
  rect(0, 0, sidebarWidth, itemHeight);
  rect(sidebarWidth, height / 2, width - sidebarWidth, height / 2);
  frontColumn.display();
  backColumn.display();
  rectMode(CORNER);
  fill(backgroundColor);
  noStroke();
  rect((width - sidebarWidth), 0, (width - sidebarWidth) / 8 * 3, itemHeight);
  for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
    deckList.get(deckIndex).getCard(i).displayFields();
  }
  textAlign(LEFT, CENTER);
  textFont(bold, 40);
  fill(0);
  text("Front", sidebarWidth + margin, itemHeight / 2 - (textAscent() * 0.1));
  text("Back", sidebarWidth + margin + (width - sidebarWidth) / 8 * 3, itemHeight / 2 - (textAscent() * 0.1));
  text("Type", sidebarWidth + margin + (width - sidebarWidth) / 4 * 3, (itemHeight / 2) - (textAscent() * 0.1));
  text("Decks", margin, (itemHeight / 2) - (textAscent() * 0.1));

  drawLine(sidebarWidth, 0, lineWeight, height, lineColor);
  drawLine(0, height / 6 * 5, sidebarWidth, lineWeight, lineColor);
  drawLine(sidebarWidth, editHeight, width - sidebarWidth, lineWeight, lineColor);
  drawLine(0, itemHeight, width, lineWeight, lineColor);

  addTextButton.display();
  addImageButton.display();
  
  cardScroll.display();
  deckScroll.display();
  fill(backgroundColor);
  rect(0, height / 6 * 5, sidebarWidth, height / 6);
  studyButton.display();
  newDeckButton.display();
  renameDeckButton.display();
  deleteDeckButton.display();
}
