# Card Matching Game

### Concept: Find the cards with the matching emoji. Match all cards to win. 

**Developer Notes** 
This is a fun, foundational project design to give a baseline understanding of developing apps in Xcode. Once you have a solid grip, this project can be updated to have more cards, leverage more features, use higher order functions, refine logic, and have better design. The sky is the limit! 


**Logic**
1. All cards start face side down.  —> All cards have the same starting color, no emoji
2. User taps card  to flip the card over. —> Change the card color (so it looks like it's flipped) and add emoji
3. User taps another card to flip it over. —> Change the card color (so it looks like it's flipped) and add emoji
4. Once two cards are flipped, check whether they have the same emoji.
        - Same emoji: remove cards from board, check whether the game should continue
        - Not same emoji: flip cards back over


**Key Requirements** 
1. We'll need to keep track of what cards are available on the board
2. We'll need to keep track of what cards are flipped


**Constraints**
The buttons on the storyboard are constrained accordingly:
1. Height and width
2. Top row of buttons: top and bottom
3. Bottom row of buttons: top and bottom
4. Left column of buttons: leading
5. Right column of buttons: trailing
6. Center column of buttons: horizontal to each other and horizontal to the container
7. 25 pts between the button and it's nearest neighbor
- Example: Bottom left button would be position 25 from the button to its top and its right. 
- Example: Top middle button would be positioned 25 from the button to its left, right and bottom
8. Top middle button positioned vertically to the container by -100 (we want it up from the center)


**Button States**
Change the state of the buttons in the storyboard to modify the background color and tint color for the button during that state.
- Example: Select button --> change to selected on the right --> change the tint color and background color --> Save/Run project and note the change when you select a button.

