//
//  ViewController.swift
//  Try Chess
//
//  Created by Emeka Ezike on 7/27/18.
//  Copyright © 2018 Emeka Ezike. All rights reserved.
//

import UIKit

let reuseIdentifier = "CellIdentifer";

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.isHidden = true
        startButton.center = self.view.center
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        // function which is triggered when handleTap is called
        

    }
    
    
    
    var startButton =  UIButton(frame: CGRect(x: 150, y: 200, width: 100, height: 80))
    
    @IBAction func startButtonTapped(_ sender: Any) {
        turn = 0
        startButton.isHidden = true
        board.isHidden = false
        pieceSelected = false
        
        //white pawns placed
        for index in 0...7
        {
            let image = UIImage(named: "wPawn")
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 37.0+37.5*Double(index), y: 386, width: 37.5, height: 37.5)
            whitePieces.append(imageView)
            view.addSubview(imageView)
        }
        
        //black pawns placed
        for index in 0...7
        {
            let image = UIImage(named: "bPawn")
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 37.0+37.5*Double(index), y: 198.5, width: 37.5, height: 37.5)
            view.addSubview(imageView)
        }
    }
    
    //=========================================================================
    //Setting up the board
    @IBOutlet weak var board: UICollectionView!
    var column = 0
    var row = 0
    
    var squaresGrid = [[Square]()]
    var squares = [Square]()
    var oneRow = [Square]()
    var whitePieces = [UIImageView]()
    var turn = 0
    var pieceSelected = false

    let blue = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let brown = UIColor(red: 235/255, green: 226/255, blue: 194/255, alpha: 1.0)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Square
        
        if row % 2 == 0
        {
            if column % 2 == 0
            {
                cell.backgroundColor = brown
            }
            else
            {
                cell.backgroundColor = blue
            }
        }
        else
        {
            if column % 2 == 0
            {
                cell.backgroundColor = blue
            }
            else
            {
                cell.backgroundColor = brown
            }
        }
        
        cell.value = column+(row*10)
        squares.append(cell)
        oneRow.append(cell)
        
        if (column+1) % 8 == 0
        {
            squaresGrid.append(oneRow)
            oneRow.removeAll()
            row += 1
            column = -1
        }
        column += 1
        
        return cell
    }
    //=========================================================================
    
    //=========================================================================
    //Select a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        squares[indexPath.item].backgroundColor = .red
    }
    //=========================================================================
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

