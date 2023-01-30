//
//  CharacterCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Dominique Strachan on 1/2/23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    func displayImage(for character: Character) {
        characterImageView.image = character.photo
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
    }
}
