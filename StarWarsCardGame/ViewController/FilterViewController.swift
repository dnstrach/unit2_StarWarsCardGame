//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Dominique Strachan on 1/2/23.
//

import UIKit

protocol FilterSelectionDelegate: AnyObject {
    func shuffleCharacters(for faction: String)
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterSelectionDelegate?


    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.shuffleCharacters(for: "sith")
        self.dismiss(animated: true)
    }
    
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.shuffleCharacters(for: "jedi")
        self.dismiss(animated: true)
    }
}
