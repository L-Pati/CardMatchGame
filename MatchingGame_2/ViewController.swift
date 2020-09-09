//
//  ViewController.swift
//  MatchingGame_2
//
//  Created by Lauren Sickels on 9/7/20.
//  Copyright © 2020 Lauren Pati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardOne: UIButton!
    @IBOutlet weak var cardTwo: UIButton!
    @IBOutlet weak var cardThree: UIButton!
    @IBOutlet weak var cardFour: UIButton!
    @IBOutlet weak var cardFive: UIButton!
    @IBOutlet weak var cardSix: UIButton!
    
    private var availableCards: [UIButton] = []
    private var flippedCards: [UIButton] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCards()
    }

    private func setupCards() {
        var emojis = ["💐", "🥳", "🍕", "💐", "🥳", "🍕"]
        availableCards = [cardOne, cardTwo, cardThree, cardFour, cardFive, cardSix]
        
        for card in availableCards {
            //randomElement() returns optional value
            //getting the index also returns an optional value
            //we want to guarantee these exist
            guard
                let randomEmoji = emojis.randomElement(),
                let emojiIndex = emojis.firstIndex(of: randomEmoji)
            else {
                //if they don't exist let us, the developer, know
                //for a production app you may also want to notify the user
                assertionFailure("something went wrong!")
                return
            }
            
            card.setTitle(randomEmoji, for: .selected)
            card.addTarget(self, action: #selector(flipCard(_:)), for: .touchUpInside)
            card.isHidden = false
            card.isUserInteractionEnabled = true
            card.backgroundColor = .black
            
            emojis.remove(at: emojiIndex)
        }
    }
    
    @objc func flipCard(_ card: UIButton) {
        card.backgroundColor = .green
        card.isSelected = true
        //if a user "flips" a card, we don't want them to select the same one again
        //we temporarily disable them from interacting with the card
        card.isUserInteractionEnabled = false
        flippedCards.append(card)
        
        //add timer so checking for matches executes after 2 seconds
        //otherwise, checking logic would happen immediately after turning the second card
        //in that case, user would not be able to see what the second card emoji was
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            //In a completion, you need to call self on any methods within the class
            //If it's not a weak self, though, you can have a retain cycle/memory leak
            self?.checkForMatch()
        }
    }
    
    private func checkForMatch() {
        //if there's not more than 1 card, we don't want to do anything
        guard flippedCards.count > 1 else { return }
        
        let firstEmoji = flippedCards[0].title(for: .selected)
        let secondEmoji = flippedCards[1].title(for: .selected)
        
        if firstEmoji == secondEmoji {
            removeCards()
        } else {
            resetToUnflippedState()
        }
    }
    
    private func removeCards() {
        for card in flippedCards {
            //we'll need to remove the card from availableCards
            //however, the index of that card is optional, we need to guarantee it
            guard let cardIndex = availableCards.firstIndex(of: card) else {
                //in a production app, you may also want to notify the user
                assertionFailure("card not in array!")
                return
            }
            
            card.isHidden = true
            card.isSelected = false
            availableCards.remove(at: cardIndex)
        }
        
        flippedCards = []
        checkGameStatus()
    }
    
    private func checkGameStatus() {
        //if available cards isn't empty, we know the game isn't over
        guard !availableCards.isEmpty else {
            let alert = UIAlertController(title: "You won!", message: "You successfully matched all cards.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                //again, this completion calls a method within the class, so we must use self
                //it must be weak other wise we can have a retain cycle
                self?.setupCards()
            }
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
    }
    
   private func resetToUnflippedState() {
        for card in flippedCards {
            card.backgroundColor = .black
            card.isSelected = false
            //Since it's not a match, user is allowed to interact with the card again
            card.isUserInteractionEnabled = true
        }
        
        flippedCards = []
    }
}

