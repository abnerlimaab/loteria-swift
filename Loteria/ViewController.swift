//
//  ViewController.swift
//  Loteria
//
//  Created by Abner Lima on 29/01/23.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe)) + 1)
        
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scGameType.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        showNumbers(for: .megasena)
    }
    
    func sortNumbers(for type: GameType) -> [Int] {
        switch type {
        case .megasena:
            return 6>-<60
        case .quina:
            return 5>-<80
        }
    }
    
    func showNumbers(for type: GameType) {
        lbGameType.text = type.rawValue
        
        balls.last?.isHidden = type == .quina
        
        let game: [Int] = sortNumbers(for: type)
        
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
    
}

