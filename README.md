# Card Matching Game

### Concept: Find the cards with the matching emoji. Match all cards to win. 

**Developer Notes** 

This is a fun, foundational project design to give a baseline understanding of developing apps in Xcode. Once you have a solid grip, this project can be updated to have more cards, leverage more features, use higher order functions, refine logic, and have better UI design, etc. The sky is the limit! 

***Be sure to change the team and add your name to the bundle identifier by clicking the main project name in the top left file list. An AppleID is required to run and install on a device***


**Logic**

1. All cards start face side down.  —> All cards have the same starting color, no emoji
2. User taps card  to flip the card over. —> Change the card color (so it looks like it's flipped) and add emoji
3. User taps another card to flip it over. —> Change the card color (so it looks like it's flipped) and add emoji
4. Once two cards are flipped, check whether they have the same emoji.
- Same emoji = remove cards from board, check whether the game should continue
- Not same emoji = flip cards back over


**Key Requirements** 

1. We'll need to keep track of what cards are available on the board
2. We'll need to keep track of what cards are flipped


**User Interface**

Add a button to the screen, set background color to black, remove text, and resize to make it look like a card.
Copy and paste the button until you have desired number of buttons. 
Set constraints using the constraints and align tool.
Goal: UI that looks the same on all devices.

For the 4 cards used in the project, here's how they're constrained:
1. After you have 4 buttons, select all and set constraints to lock in a height of 91 and width of 119.
2. Add a horizontal stack view to the screen.
3. Resize the stack view so that is reaches just about to the edge of the screen (you should see a blue line guide when you pull it out to the edge)
4. Set constraints on the stack view's width (whatever dimension it has use that) and change the height to 119.
5. Drag and drop all buttons to the stack view. 
6. Select the stack view and change the distribution to equal spacing.
*Note if buttons are showing up squished or too tall in the stack view, change the button height and stack view height to be the same.


**Button States**

When a button is selected, you may notice that the emoji shows as white. You'll need to change the color for the selected state fore each button:
-  Select button --> change to selected on the right --> change the tint color and background color --> Save/Run project and note the change when you select a button.

