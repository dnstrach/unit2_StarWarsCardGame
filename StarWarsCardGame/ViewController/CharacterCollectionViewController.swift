//
//  CharacterCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Dominique Strachan on 1/2/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class CharacterCollectionViewController: UICollectionViewController, FilterSelectionDelegate {
    
    private var displayedCharacters: [Character] = []
    private var targetCharacter: Character?
    private var selectedFaction = "jedi"

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCharacters(for: selectedFaction)

    }
    
    // MARK: Helper Method
    func shuffleCharacters(for faction: String) {
        selectedFaction = faction
        if faction == "jedi" {
            CharacterController.jedi.shuffle()
            let jediGroup = CharacterController.jedi.prefix(3)
            displayedCharacters = Array(jediGroup)
            targetCharacter = CharacterController.sith.randomElement()
        } else if faction == "sith" {
            CharacterController.sith.shuffle()
            let sithGroup = CharacterController.sith.prefix(3)
            displayedCharacters = Array(sithGroup)
            targetCharacter = CharacterController.jedi.randomElement()
        }
        updateViews()
    }
    
    func updateViews() {
        guard let character = targetCharacter else { return }
        displayedCharacters.append(character)
        displayedCharacters.shuffle()
        collectionView.reloadData()
        title = "Find \(character.name)"
    }
    
    func presentAlert(for character: Character) {
        let success = character == targetCharacter
        let alertController = UIAlertController(title: success ? "Good Job!" : "Better luck next time!", message: nil, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Shuffle!", style: .default) { _
            in self.shuffleCharacters(for: self.selectedFaction)
        }
        
        alertController.addAction(doneAction)
        
        if success {
            alertController.addAction(shuffleAction)
        }
        
        present(alertController, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterVC" {
            let vc = segue.destination as? FilterViewController
            vc?.delegate = self
        }
    }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayedCharacters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        let character = displayedCharacters[indexPath.row]
        
        cell.displayImage(for: character)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = displayedCharacters[indexPath.row]
        presentAlert(for: character)
    }

}
extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 15, height: width + 30)
    }
}

//extension CharacterCollectionViewController: FilterSelectionDelegate {
//    func selected(faction: String) {
//        selectedFaction = faction
//        shuffleCharacters(for:  selectedFaction)
//    }
//}
