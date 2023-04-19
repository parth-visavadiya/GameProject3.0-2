//
//  PlayViewController.swift
//  GameProject3.0
//
//  Created by parth visavadiya on 16/01/23.
//

import UIKit

class PlayViewController: UIViewController {
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var MediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func easyButtonTapped(_ sender: UIButton) {
        let navigate = storyboard?.instantiateViewController(withIdentifier: "LevelViewController") as! LevelViewController
        navigationController?.pushViewController(navigate, animated: true)
        navigate.frequency = 0.07
    }
    
    @IBAction func MediumButtonTapped(_ sender: UIButton) {
        
        let navigate = storyboard?.instantiateViewController(withIdentifier: "LevelViewController") as! LevelViewController
        navigationController?.pushViewController(navigate, animated: true)
        navigate.frequency = 0.05
        
    }
    
    @IBAction func hardButtonTapped(_ sender: UIButton) {
        
        let navigate = storyboard?.instantiateViewController(withIdentifier: "LevelViewController") as! LevelViewController
        navigationController?.pushViewController(navigate, animated: true)
        navigate.frequency = 0.03
    }
}
