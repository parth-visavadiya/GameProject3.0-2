//
//  ViewController.swift
//  GameProject3.0
//
//  Created by parth visavadiya on 16/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let playViewController: PlayViewController = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        self.navigationController?.pushViewController(playViewController, animated: true)
        
    }
    
}

