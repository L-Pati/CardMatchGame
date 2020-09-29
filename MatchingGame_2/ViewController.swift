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
    
    private var availableCards: [UIButton] = []
    private var selectedCards: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCards()
    }
    
    private func setupCards() {
        var emojis = ["🍕", "🍫", "🍕", "🍫"]
        
        availableCards = [cardOne, cardTwo, cardThree, cardFour]
        availableCards.forEach { (card) in
            guard
                let randomEmoji = emojis.randomElement(),
                let emojiIndex = emojis.firstIndex(of: randomEmoji)
            else {
                assertionFailure("couldn't get emoji!")
                return
            }
            
            card.isHidden = false
            card.backgroundColor = .black
            card.isUserInteractionEnabled = true
            card.setTitle(randomEmoji, for: .selected)
            card.addTarget(self, action: #selector(selectCard(_:)), for: .touchUpInside)
            
            emojis.remove(at: emojiIndex)
        }
    }
    
    @objc private func selectCard(_ card: UIButton) {
        card.isSelected = true
        card.backgroundColor = .green
        card.isUserInteractionEnabled = false
        selectedCards.append(card)
        
        //check for match after 2 seconds
        //allows user to see card flipped over
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.checkForMatch()
        }
    }
    
    private func checkForMatch() {
        //should only check for match if more than one card selected
        guard selectedCards.count > 1 else { return }
        
        guard
            let firstTitle = selectedCards[0].titleLabel?.text,
            let secondTitle = selectedCards[1].titleLabel?.text
        else {
            assertionFailure("could not get text")
            return
        }
        
        firstTitle == secondTitle ? removeCardsFromBoard() : turnCardsOver()
        selectedCards = []
    }
    
    private func removeCardsFromBoard() {
        selectedCards.forEach { (card) in
            guard let cardIndex = availableCards.firstIndex(of: card) else {
                assertionFailure("unable to get card index")
                return
            }
            
            card.isHidden = true
            card.isSelected = false
            availableCards.remove(at: cardIndex)
        }
        
        checkGameStatus()
    }
    
    private func turnCardsOver() {
        selectedCards.forEach { (card) in
            card.isSelected = false
            card.backgroundColor = .black
            card.isUserInteractionEnabled = true
        }
    }
    
    private func checkGameStatus() {
        guard availableCards.count != 0 else {
            let title = "You won!"
            let message = "You won the game, tap ok to play again."
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.setupCards()
            }
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
    }
}
