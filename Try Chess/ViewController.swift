//
//  ViewController.swift
//  Try Chess
//
//  Created by Emeka Ezike on 7/27/18.
//  Copyright © 2018 Emeka Ezike. All rights reserved.
//

//squaresGrid[1][1].value is 11 at 00
/*Streamlines:
 -isOccupied and occupied by should be the same
 */
import UIKit

//These are accessable to all classes
var squaresGrid = [[Square]()] //Holds a grid of the entire board plus the out-boundries
var whitePieces = [Piece]() //the white players pieces
var blackPieces = [Piece]() //the black players pieces


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var startButton =  UIButton(frame: CGRect(x: 150, y: 200, width: 100, height: 80)) //creates a start button
    
   
    var turn = 0 //when it is even, white goes; when it is odd, black goes
    var pieceSelected = [Piece]()//if either player has selected a piece
    var squares = [Square]() //Holds all the out and in squares from 0 to 99
    
    
    
    //===================================================
    // VIEW DID LOAD
    override func viewDidLoad()
    {
        super.viewDidLoad()
        board.isHidden = true //Hide board
        startButton.center = self.view.center //center the start button
        startButton.setTitle("Start", for: .normal) //give the start button the "start" title
        startButton.setTitleColor(.blue, for: .normal) //start button color is blue
        startButton.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside) //start button calls "startGame" action
        self.view.addSubview(startButton) //adds the start button to the view
        
    }
    //===================================================
    
    
    
    
    @IBAction func startGame(_ sender: Any) {
        squaresGrid.remove(at: 0) //not sure why index 0 is a blank array
        for index in 0...9
        {
            //out-of-bounds are white in color
            squaresGrid[0][index].backgroundColor = .white
            squaresGrid[9][index].backgroundColor = .white
            squaresGrid[index][0].backgroundColor = .white
            squaresGrid[index][9].backgroundColor = .white
            //out-of-buonds are not in bounds (property of custom Square class)
            squaresGrid[0][index].isInBounds = false
            squaresGrid[9][index].isInBounds = false
            squaresGrid[index][0].isInBounds = false
            squaresGrid[index][9].isInBounds = false
        }
        whitePieces.removeAll()
        blackPieces.removeAll()
        turn = 0 //white starts
        startButton.isHidden = true //start button goes away
        board.isHidden = false //board is shown
        pieceSelected.removeAll() //no pieces are shown
        setUpPieces()
        
    }
    
    //=========================================================================
    //Setting up the board
    @IBOutlet weak var board: UICollectionView!
    var column = 0
    var row = 0
    
    var oneRow = [Square]()//added to the squareGrid
    
    let blue = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0) //custom board colors
    let brown = UIColor(red: 235/255, green: 226/255, blue: 194/255, alpha: 1.0)// custom board colors
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
                cell.color = brown
            }
            else
            {
                cell.backgroundColor = blue
                cell.color = blue
            }
        }
        else
        {
            if column % 2 == 0
            {
                cell.backgroundColor = blue
                cell.color = blue
            }
            else
            {
                cell.backgroundColor = brown
                cell.color = brown
            }
        }
        
        cell.value = column+(row*10)
        cell.r = row
        cell.c = column
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if pieceSelected.isEmpty//if nothing is selected
        {
            if turn % 2 == 0 //if white turn
            {
                for piece in whitePieces
                {
                    if piece.getSquare() == squares[indexPath.item] //go to the square in all of whites pieces that is the same as the tapped square on the grid
                    {
                        print(piece.pieceColor+piece.pieceType)// for testing
                        squares[indexPath.item].backgroundColor = .red //shows that it is selected
                        pieceSelected.append(piece) //hold that piece
                    }
                }
            }
            else //same but for black pieces
            {
                for piece in blackPieces
                {
                    print(piece.pieceColor+piece.pieceType)
                    squares[indexPath.item].backgroundColor = .red
                    pieceSelected.append(piece)
                }
            }
        }
        else //if a piece has been selected
        {
            for move in pieceSelected[0].availMoves()
            {
                if move == squares[indexPath.item]
                {
                    pieceSelected[0].getSquare().backgroundColor = pieceSelected[0].getSquare().color
                    pieceSelected[0].move(to: squares[indexPath.item])
                    pieceSelected.removeAll()
                    //turn += 1
                }
            }
            if !pieceSelected.isEmpty
            {
                pieceSelected[0].getSquare().backgroundColor = pieceSelected[0].getSquare().color
                pieceSelected.removeAll()
            }
            
            
        }
        
        
        
        //squares[indexPath.item].backgroundColor = .red
        //print(squares[indexPath.item].center)
        //print("\(squares[indexPath.item].value)\n")
    }
    //=========================================================================
    
    func setUpPieces()
    {
        //white pawns placed
        for index in 1...8
        {
            let wPawn = Piece(type: "Pawn", color: "w", rc: [7, index])// "creates custom Piece image"
            // may need later -> (x: 37.0+37.5*Double(index), y: 386, width: 37.5, height: 37.5)
            whitePieces.append(wPawn)//adds Piece to the whitePieces array
            view.addSubview(wPawn)//adds the Piece to the view
            
            let bPawn = Piece(type: "Pawn", color: "b", rc: [2, index])
            //may need later -> (x: 37.0+37.5*Double(index), y: 198.5, width: 37.5, height: 37.5)
            blackPieces.append(bPawn)
            view.addSubview(bPawn)
        }
        
        var specialPieces = ["Rook", "Bishop", "Knight", "Queen", "King"]
        
        for index in 1...8
        {
            if index <= 5
            {
                let wSpecialPiece = Piece(type: specialPieces[index-1], color: "w", rc: [8, index])
                whitePieces.append(wSpecialPiece)
                view.addSubview(wSpecialPiece)
                
                //            let bSpecialPiece = Piece(type: specialPieces[index-1], color: "b", rc: [1, index])
                //            blackPieces.append(bSpecialPiece)
                //            view.addSubview(bSpecialPiece)
            }
            else
            {
                let wSpecialPiece = Piece(type: specialPieces[8-index], color: "w", rc: [8, index])
                whitePieces.append(wSpecialPiece)
                view.addSubview(wSpecialPiece)
                
                //            let bSpecialPiece = Piece(type: specialPieces[8-index], color: "b", rc: [1, index])
                //            blackPieces.append(bSpecialPiece)
                //            view.addSubview(bSpecialPiece)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

