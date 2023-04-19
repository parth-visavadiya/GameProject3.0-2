//
//  LevelViewController.swift
//  GameProject3.0
//
//  Created by parth visavadiya on 16/01/23.
//

import UIKit

class LevelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timeOutBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var numberOfItemInRow: Int = 3
    var interItemSpace: CGFloat = 16
    var selectedIndex: Int = 0
    var score = 0
    var highScore = 0
    var frequency = 0.1
    var images = [UIImage(named: "Lion"),UIImage(named: "Giraffe"),UIImage(named: "Tiger"),UIImage(named: "Gorilla"),UIImage(named: "Fox"),UIImage(named: "Kangaroo"),UIImage(named: "Squirrel"),UIImage(named: "Elephant"),UIImage(named: "Crocodile")]
    var randomImage = UIImage()
    var name = ["Lion", "Giraffe", "Tiger", "Gorilla", "Fox", "Kangaroo", "Squirrel", "Elephant", "Crocodile"]
    var randomName = ""
    var optionalName = "Cat"
    var optionalName2 = "Dog"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        scoreLabel.layer.borderColor = UIColor.black.cgColor
        scoreLabel.layer.borderWidth = 1
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 20
        timeOutBar.progress = 1.0
        time.invalidate()
        timeLine()
        images = images.shuffled()
        name = name.shuffled()
        //randomImage = images.randomElement()!
        scoring()
        randomName = name.randomElement()!
        configurCatagoryCollectionView()
    }
    
    var time = Timer()
    func timeLine()
    {
        var a : Float = 1.0
        time.invalidate()
        collectionView.reloadData()
        self.timeOutBar.progress = a
        time = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true, block: { (time) in
            
            a -= 0.01
            self.timeOutBar.progress = a
            if self.timeOutBar.progress == 0.0
            {
                self.time.invalidate()
                self.scoring()
                self.displayBox()
            }
        })
    }
    
    private func configurCatagoryCollectionView(){
        let nibFile: UINib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func displayBox()
    {
        scoring()
        let alert = UIAlertController(title: "GAME OVER", message: "Score = \(score)\n Highscore = \(highScore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.score = 0
            self.scoreLabel.text = "\(self.score)"
            self.timeLine()
            self.images = self.images.shuffled()
            self.name = self.name.shuffled()
            self.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Home", style: .default, handler: { _ in
            
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!,animated: false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if randomName == images[indexPath.row]?.animalName
        {
            cell.image.image = images[indexPath.row]
            cell.nameLabel.text = images[indexPath.row]?.animalName
        }
        else
        {
            if randomName == name[indexPath.row]
            {
                cell.image.image = images[indexPath.row]
                cell.nameLabel.text = optionalName
            }else if images[indexPath.row]?.animalName == name[indexPath.row]{
                cell.image.image = images[indexPath.row]
                cell.nameLabel.text = "\(optionalName2)"
            }else{
                cell.image.image = images[indexPath.row]
                cell.nameLabel.text = "\(name[indexPath.row])"
            }
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if images[indexPath.row]!.animalName == randomName
        //if name[indexPath.row] == images[indexPath.row]!.animalName
        //if name[indexPath.row] == randomName
        {
            //            print("randomname = ",randomName)
            //            print("imageName = ",images[indexPath.row]?.animalName)
            //            print("RightName = ",name[indexPath.row])
            timeLine()
            score+=1
            scoreLabel.text = "\(score)"
            images = images.shuffled()
            name = name.shuffled()
            collectionView.reloadData()
            randomName = name.randomElement()!
            
        }
        else
        {
            displayBox()
            self.time.invalidate()
        }
    }
    func scoring()
    {
        if highScore <= score
        {
            highScore = score
            //UserDefaults.standard.set(self.scoreLabel.text!, forKey: "highpoint")
            highScoreLabel.text = "\(highScore)"
        }
    }
}

extension LevelViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 140)
//        let spacing = CGFloat(numberOfItemInRow+1) * interItemSpace
//        let avilablWidth = collectionView.frame.width - spacing
//        let cellWidth = avilablWidth / CGFloat(numberOfItemInRow)
//        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 5, bottom: 8, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension UIImage
{
    var animalName : String
    {
        switch self
        {
        case UIImage(named: "Lion") : return "Lion"
        case UIImage(named: "Giraffe") : return "Giraffe"
        case UIImage(named: "Tiger") : return "Tiger"
        case UIImage(named: "Gorilla") : return "Gorilla"
        case UIImage(named: "Fox") : return "Fox"
        case UIImage(named: "Kangaroo") : return "Kangaroo"
        case UIImage(named: "Squirrel") : return "Squirrel"
        case UIImage(named: "Elephant") : return "Elephant"
        case UIImage(named: "Crocodile") : return "Crocodile"
        default :
            break
        }
        return ""
    }
}


