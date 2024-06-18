# Week 6 Lab: To Do List Application

## Objective
Create a "To Do" list application that lets users add items to a list. The user can type into a TextField and click "Add" which should then make the item appear in the list.

## Branch Setup
Create a new branch in your lab project for Week6. It can be a branch splitting off from the main or any other week because you will be creating a whole new page from what was done previously.

## Requirements
For this week's lab, you will demonstrate to your lab professor your knowledge of ListViews:

1. Create a "To Do" list application that lets users add items to a list.
2. Each item should have the row number on the left side and the To Do item on the right.
3. Add a Long-Press gesture detector which will bring up a dialog box asking if the user wants to delete the item. If the user selects "Yes", then the item will be removed from the list. If the user selects "No", then nothing should change.
4. If the number of items is empty, then you should instead show a Text saying "There are no items in the list".

## Implementation Details
1. **Adding Items**:
    - Typing an item in the TextField and clicking the "Add" button makes the item appear in the list.
    - After inserting an item, the TextField is cleared so that the previous string is gone.

2. **Deleting Items**:
    - If the user long-presses an item in the list, an AlertDialog appears asking if they want to delete the item.
    - Selecting "Yes" from the AlertDialog removes the item from the list.
    - Selecting "No" from the AlertDialog does not remove the item from the list.

3. **Empty List Handling**:
    - If the number of items is empty, then show a Text saying "There are no items in the list".


