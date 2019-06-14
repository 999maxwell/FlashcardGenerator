//I hope I didn't have to document all this stuff.
/*
SORTING:
Sorting 8000 strings of length 7000

Bubble Sort:
Two for loops: One iterates (n - 1) times. The other iterates from (n - 1) times to 1 time, for an average of (n / 2) times. Therefore the total number of comparisons in the worst case is (n(n-1)/2).
With n = 8000, the number of comparisons in the worst case is 31996000.

31995369 comparisons
31996000 comparisons worst case
4120760 milliseconds = 68m 40s

Selection Sort:
Two for loops: One iterates (n - 1) times. The other iterates from (n - 1) times to 1 time, for an average of (n / 2) times. Same as Bubble Sort except there is no break so it is always worst case.
31996000 comparisons = worstcase
3809629 milliseconds = 63m 30s

sort():
93437 comparisons
12270 milliseconds = 12s
Likely n log(n) time

Difference in time can be attributed to computer.

void generateFlashcards(int number) {
  String[] testList = new String[number];
  String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String lower = upper.toLowerCase();
  String digits = "0123456789";
  int l = 40;
  for (int t = 0; t < number; t++) {
    String front = "";
    String back = "";
    for (int i = 0; i < l; i++) {
      int type = int(random(0, 3));
      char c = ' ';
      if (type == 0) {
        int index = int(random(0, 26));
        c = upper.charAt(index);
      } else if (type == 1) {
        int index = int(random(0, 26));
        c = lower.charAt(index);
      } else if (type == 2) {
        int index = int(random(0, 10));
        c = digits.charAt(index);
      }
      if (i < l/2) {
        front += c;
      } else {
        back += c;
      }
    }
    testList[t] = "0~"  + front + "~" + back;
  }
  saveStrings("data/test.txt", testList);
}


void bubblesort(String[] testdata) {
  int n = testdata.length;
  long worstcase = Long.valueOf(n) * Long.valueOf(n);
  int count = 0;
  for (int i = 0; i < n - 1; i++) {
    boolean swapped = false;
    for (int j = 0; j < n - i - 1; j++) {
      if (testdata[j].substring(2).toLowerCase().compareTo(testdata[j + 1].substring(2).toLowerCase()) > 0) {
        String temp = testdata[j];
        testdata[j] = testdata[j + 1];
        testdata[j + 1] = temp;
        swapped = true;
      }
      count++;
      System.out.println(count + " / " + (worstcase) + " = " + new DecimalFormat(".##").format(100.0 * ((double) count / worstcase)) + "  Time: " + millis());
    }
    if (!swapped) {
      break; 
    }
  }
  saveStrings("data/bubblesort.txt", testdata);
}


void selectionsort(String[] testdata) {
  int n = testdata.length;
  long worstcase = (Long.valueOf(n) * Long.valueOf(n) - Long.valueOf(n)) / 2;
  int count = 0;
  for (int i = 0; i < n - 1; i++) {
    int index = i;
    for (int j = i + 1; j < n; j++) {
      count++;
      System.out.println(count + " / " + (worstcase) + " = " + new DecimalFormat(".##").format(100.0 * ((double) count / worstcase)) + "  Time: " + millis());
      if (testdata[index].substring(2).toLowerCase().compareTo(testdata[j].substring(2).toLowerCase()) > 0) {
        index = j;        
      }
    }
    String temp = testdata[i];
    testdata[i] = testdata[index];
    testdata[index] = temp;
  }
  saveStrings("data/selectionsort.txt", testdata);
}
void realsort(String[] testdata) {
  SortCompare sortCompare = new SortCompare();
  Arrays.sort(testdata, sortCompare);
   saveStrings("data/sort.txt", testdata);
}
class SortCompare implements Comparator<String> {
  public int compare(String card1, String card2) {
    return card1.substring(2).toLowerCase().compareTo(card2.substring(2).toLowerCase());
  }
}
*/
/*
SEARCHING:
CODE DOES NOT WORK AS VARIABLES NAMES WERE CHANGED SINCE THE S&S ASSIGNMENT
Linear Search:
n = 1000
Goes through the entire array, so time complexity is linear. Therefore 1000 comparisons are always needed, though this can be fixed with a break once the key is found.
17 milliseconds to 27 milliseconds

Binary Search:
n = 1000
Each iteration of the while loop reduces the size by half, so time complexity should be log2(n). Substitute 1000 for n and approximately 10 comparisons are needed.
Trying this with 1000 flashcards will prove this to be true.
17 milliseconds to 22 milliseconds


LINEAR SEARCH:
void swapCardIndices(int timer) {
  int count = 0;
  reassignCardIndices();
  if (selectIndex != -1) {
    for (int i = 0; i < deckList.get(deckIndex).size(); i++) {
      count++;
      if (deckList.get(deckIndex).getCard(i).selected()) selectIndex = i;
    }
    println("Time: " + millis() + " - " + timer
    + " = " + (millis() - timer));
    println("Comparisons: " + count);
  }
}
BINARY SEARCH:
void swapIndicesFront(int timer) {
  int count = 0;
  for (int i = 0; i < flashcardList.size(); i++) {
    flashcardList.get(i).changeIndex(i);
  }
  if (selectIndex != -1) {
    int max = flashcardList.size();
    int min = 0;
    while (min < max) {
      count++;
      println("Comparison #: " + count);
      int mid = floor((max + min) / 2);
      println(min + " " + mid + " " + max);
      if (flashcardList.get(mid).front().toLowerCase().compareTo(selectFront.toLowerCase()) < 0) {
        min = mid + 1;
      } else {
        max = mid;
      }
    }
    selectIndex = min;
    println("Time: " + millis() + " - " + timer + " = " + (millis() - timer));
    println("Calculations: " + count);
  }
}
void swapIndicesBack() {
  for (int i = 0; i < flashcardList.size(); i++) {
    flashcardList.get(i).changeIndex(i);
  }
  if (selectIndex != -1) {
    int max = flashcardList.size();
    int min = 0;
    while (min < max) {
      int mid = floor((max + min) / 2);
      if (flashcardList.get(mid).back().toLowerCase().compareTo(selectBack.toLowerCase()) < 0) {
        min = mid + 1;
      } else {
        max = mid;
      }
    }
    selectIndex = min;
  }
}
*/
