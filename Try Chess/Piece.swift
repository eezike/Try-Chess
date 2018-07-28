//
//  Piece.swift
//  Try Chess
//
//  Created by Emeka Ezike on 7/27/18.
//  Copyright © 2018 Emeka Ezike. All rights reserved.
//

import UIKit

class Piece: UIImageView {

    var pieceType = ""
    var pieceColor = ""
    var pieceImage = UIImage()
    var pieceRow = 0
    var pieceColumn = 0
    var beenMoved = false
    
    init(type: String, color: String, rc: Array<Int>) {
        let image = UIImage(named: color+type)
        super.init(image: image)
        pieceType = type
        pieceColor = color
        beenMoved = false
        pieceImage = image!
        pieceRow = rc[0]
        pieceColumn = rc[1]
        frame = CGRect(origin: squaresGrid[pieceRow][pieceColumn].getPosition(), size: CGSize(width: 37.5, height: 37.5))
        squaresGrid[pieceRow][pieceColumn].isOccupied = true
    }
    
    func availMoves () -> Array<Any>
    {
        var moves = [[Int]()]
        if pieceColor == "w"
        {
            switch pieceType
            {
            case "Pawn":
                moves = pawnMoves(color: pieceColor)
            case "rook":
                moves.append([pieceRow, pieceColumn])

            default:
                break
            }
        }
        else
        {
            switch pieceType
            {
            case "Pawn":
                moves = pawnMoves(color: pieceColor)
            case "rook":
                moves.append([pieceRow, pieceColumn])
            default:
                break
            }
        }
        
        
        return moves
    }
    
    func move(to: Array<Int>)
    {
        if !squaresGrid[to[0]][to[1]].isOccupied
        {
            squaresGrid[pieceRow][pieceColumn].isOccupied = false
            pieceRow = to[0]
            pieceColumn = to[1]
            UIView.animate(withDuration: 1, animations: {self.frame.origin = squaresGrid[to[0]][to[1]].getPosition()}, completion: nil)
            beenMoved = true
        }
        
    }
    
    func getSquare() -> Square
    {
        return squaresGrid[pieceRow][pieceColumn]
    }
    
    
    func pawnMoves(color: String) -> [Array<Int>]
    {
        var pawnMoves = [[Int]()]
        
        if !squaresGrid[pieceRow-1][pieceColumn].isOccupied && squaresGrid[pieceRow-1][pieceColumn].isInBounds
        {
            pawnMoves.append([pieceRow-1, pieceColumn])
            
        }
        if squaresGrid[pieceRow-1][pieceColumn+1].isOccupied && squaresGrid[pieceRow-1][pieceColumn].isInBounds
        {
            pawnMoves.append([pieceRow-1, pieceColumn-1])
        }
        
        if !beenMoved && !squaresGrid[pieceRow-1][pieceColumn].isOccupied && !squaresGrid[pieceRow-2][pieceColumn].isOccupied
        {
            pawnMoves.append([pieceRow-2, pieceColumn])
        }
        
        return pawnMoves
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
