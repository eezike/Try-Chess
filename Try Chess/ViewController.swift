//
//  ViewController.swift
//  Try Chess
//
//  Created by Emeka Ezike on 7/27/18.
//  Copyright © 2018 Emeka Ezike. All rights reserved.
//

//squaresGrid[1][1].value is 11 at 00
import UIKit

var squaresGrid = [[Square]()]
var squares = [Square]()

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var whitePieces = [Piece]()
    var turn = 0
    var pieceSelected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        board.isHidden = true
        startButton.center = self.view.center
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(startButton)

    }
    
    
    
    var startButton =  UIButton(frame: CGRect(x: 150, y: 200, width: 100, height: 80))
    
    @IBAction func startButtonTapped(_ sender: Any) {
        squaresGrid.remove(at: 0) //not sure why index 0 is a blank array
        for index in 0...9
        {
            squaresGrid[0][index].backgroundColor = .white
            squaresGrid[9][index].backgroundColor = .white
            squaresGrid[index][0].backgroundColor = .white
            squaresGrid[index][9].backgroundColor = .white
            
            squaresGrid[0][index].isInBounds = false
            squaresGrid[9][index].isInBounds = false
            squaresGrid[index][0].isInBounds = false
            squaresGrid[index][9].isInBounds = false
        }
        turn = 0
        startButton.isHidden = true
        board.isHidden = false
        pieceSelected = false
        //white pawns placed
        for index in 1...8
        {
            let pawn = Piece(type: "Pawn", color: "w", rc: [7, index])
            // (x: 37.0+37.5*Double(index), y: 386, width: 37.5, height: 37.5)
            whitePieces.append(pawn)
            view.addSubview(pawn)
        }
        
        //black pawns placed
        for index in 1...8
        {
            let pawn = Piece(type: "Pawn", color: "b", rc: [2, index])
            // (x: 37.0+37.5*Double(index), y: 198.5, width: 37.5, height: 37.5)
            view.addSubview(pawn)
        }
    }
    
    //=========================================================================
    //Setting up the board
    @IBOutlet weak var board: UICollectionView!
    var column = 0
    var row = 0

    var imagesGrid = [[UIImageView]()]
    var oneRow = [Square]()
   
    let blue = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let brown = UIColor(red: 235/255, green: 226/255, blue: 194/255, alpha: 1.0)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifer", for: indexPath) as! Square
        
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
        
        if (column+1) % 10 == 0
        {
            squaresGrid.append(oneRow)
            oneRow.removeAll()
            row += 1
            column = 0
        }
        else{
            column += 1
        }
        
        return cell
    }
    //=========================================================================
    
    //=========================================================================
    //Select a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for piece in whitePieces
        {
            if piece.getSquare().value == squares[indexPath.item].value
            {
                print(piece.pieceColor+piece.pieceType)
                //piece.move(to: [0,0])
            }
        }
        //squares[indexPath.item].backgroundColor = .red
        //print(squares[indexPath.item].center)
        //print("\(squares[indexPath.item].value)\n")
    }
    //=========================================================================
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

