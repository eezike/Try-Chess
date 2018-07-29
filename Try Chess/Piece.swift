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
        squaresGrid[pieceRow][pieceColumn].occupiedBy = pieceColor
    }
    
    func availMoves () -> Array<Square>
    {
        var moves = [Square]()
        
        switch pieceType
        {
        case "Pawn":
            moves = pawnMoves(color: pieceColor)
        case "Rook":
            moves = rookMoves(color: pieceColor)
        case "Knight":
            moves = pawnMoves(color: pieceColor)
        case "Bishop":
            moves = bishopMoves(color: pieceColor)
        case "Queen":
            moves = rookMoves(color: pieceColor) + bishopMoves(color: pieceColor)
        case "King":
            moves = pawnMoves(color: pieceColor)
        default:
            break
        }
        
        return moves
    }
    
    func move(to: Square)
    {
        squaresGrid[pieceRow][pieceColumn].isOccupied = false
        squaresGrid[pieceRow][pieceColumn].occupiedBy = ""
        
        UIView.animate(withDuration: 0.5, animations: {self.frame.origin = to.getPosition()}, completion:
            {
                finished in
                if to.isOccupied
                {
                    if self.pieceColor == "w"
                    {
                        for piece in blackPieces
                        {
                            if piece.getSquare() == to
                            {
                                piece.remove()
                            }
                        }
                    }
                    else
                    {
                        for piece in whitePieces
                        {
                            if piece.getSquare() == to
                            {
                                piece.remove()
                            }
                        }
                    }
                }
        })
        
        beenMoved = true
        pieceRow = to.r
        pieceColumn = to.c
        to.isOccupied = true
        to.occupiedBy = pieceColor
    }
    
    func getSquare() -> Square
    {
        return squaresGrid[pieceRow][pieceColumn]
    }
    
    
    func pawnMoves(color: String) -> Array<Square>
    {
        var pawnMoves = [Square]()
        
        if color == "w"
        {
            if !squaresGrid[pieceRow-1][pieceColumn].isOccupied && squaresGrid[pieceRow-1][pieceColumn].isInBounds
            {
                pawnMoves.append(squaresGrid[pieceRow-1][pieceColumn])
                
            }
            if squaresGrid[pieceRow-1][pieceColumn+1].isOccupied && squaresGrid[pieceRow-1][pieceColumn].isInBounds
            {
                pawnMoves.append(squaresGrid[pieceRow-1][pieceColumn-1])
            }
            
            if !beenMoved && !squaresGrid[pieceRow-1][pieceColumn].isOccupied && !squaresGrid[pieceRow-2][pieceColumn].isOccupied
            {
                pawnMoves.append(squaresGrid[pieceRow-2][pieceColumn])
            }
        }
        
        
        return pawnMoves
    }
    
    
    func rookMoves(color: String) -> Array<Square>
    {
        var up = true
        var down = true
        var left = true
        var right = true
        var rookMoves = [Square]()
        
        for index in 1...7
        {
            if up && squaresGrid[pieceRow-index][pieceColumn].isInBounds && !squaresGrid[pieceRow-index][pieceColumn].isOccupied
            {
                rookMoves.append(squaresGrid[pieceRow-index][pieceColumn])
            }
            else if up && squaresGrid[pieceRow-index][pieceColumn].occupiedBy == "b"
            {
                rookMoves.append(squaresGrid[pieceRow-index][pieceColumn])
                up = false
            }
            else
            {
                up = false
            }
            
            if down && squaresGrid[pieceRow+index][pieceColumn].isInBounds && !squaresGrid[pieceRow+index][pieceColumn].isOccupied
            {
                rookMoves.append(squaresGrid[pieceRow+index][pieceColumn])
            }
            else if down && squaresGrid[pieceRow+index][pieceColumn].occupiedBy == "b"
            {
                rookMoves.append(squaresGrid[pieceRow+index][pieceColumn])
                down = false
            }
            else
            {
                down = false
            }
            
            if right && squaresGrid[pieceRow][pieceColumn+index].isInBounds && !squaresGrid[pieceRow][pieceColumn+index].isOccupied
            {
                rookMoves.append(squaresGrid[pieceRow][pieceColumn+index])
            }
            else if right && squaresGrid[pieceRow][pieceColumn+index].occupiedBy == "b"
            {
                rookMoves.append(squaresGrid[pieceRow][pieceColumn+index])
                right = false
            }
            else
            {
                right = false
            }
            
            if left && squaresGrid[pieceRow][pieceColumn-index].isInBounds && !squaresGrid[pieceRow][pieceColumn-index].isOccupied
            {
                rookMoves.append(squaresGrid[pieceRow][pieceColumn-index])
            }
            else if left && squaresGrid[pieceRow][pieceColumn-index].occupiedBy == "b"
            {
                rookMoves.append(squaresGrid[pieceRow][pieceColumn-index])
                left = false
            }
            else
            {
                left = false
            }
            
        }
        
        return rookMoves
    }
    
    func bishopMoves(color: String) -> Array<Square>
    {
        var upR = true
        var downR = true
        var upL = true
        var downL = true
        var bishopMoves = [Square]()
        
        if color == "w"
        {
            for index in 1...7
            {
                if upR && squaresGrid[pieceRow-index][pieceColumn+index].isInBounds && !squaresGrid[pieceRow-index][pieceColumn+index].isOccupied
                {
                    bishopMoves.append(squaresGrid[pieceRow-index][pieceColumn+index])
                    
                }
                else if upR && squaresGrid[pieceRow-index][pieceColumn+index].occupiedBy == "b"
                {
                    bishopMoves.append(squaresGrid[pieceRow-index][pieceColumn+index])
                    upR = false
                }
                else
                {
                    upR = false
                }
                
                if downR && squaresGrid[pieceRow+index][pieceColumn+index].isInBounds && !squaresGrid[pieceRow+index][pieceColumn+index].isOccupied
                {
                    bishopMoves.append(squaresGrid[pieceRow+index][pieceColumn+index])
                }
                else if downR && squaresGrid[pieceRow+index][pieceColumn+index].occupiedBy == "b"
                {
                    bishopMoves.append(squaresGrid[pieceRow+index][pieceColumn+index])
                    downR = false
                }
                else
                {
                    downR = false
                }
                
                if upL && squaresGrid[pieceRow-index][pieceColumn-index].isInBounds && !squaresGrid[pieceRow-index][pieceColumn-index].isOccupied
                {
                    bishopMoves.append(squaresGrid[pieceRow-index][pieceColumn-index])
                }
                else if upL && squaresGrid[pieceRow-index][pieceColumn-index].occupiedBy == "b"
                {
                    bishopMoves.append(squaresGrid[pieceRow-index][pieceColumn-index])
                    upL = false
                }
                else
                {
                    upL = false
                }
                
                if downL && squaresGrid[pieceRow+index][pieceColumn-index].isInBounds && !squaresGrid[pieceRow+index][pieceColumn-index].isOccupied
                {
                    bishopMoves.append(squaresGrid[pieceRow+index][pieceColumn-index])
                }
                else if downL && squaresGrid[pieceRow+index][pieceColumn-index].occupiedBy == "b"
                {
                    bishopMoves.append(squaresGrid[pieceRow+index][pieceColumn-index])
                    downL = false
                }
                else
                {
                    downL = false
                }
                
            }
            
        }
        
        
        return bishopMoves
    }
    
    
    func remove()
    {
        squaresGrid[pieceRow][pieceColumn].isOccupied = false
        squaresGrid[pieceRow][pieceColumn].occupiedBy = ""
        if pieceColor == "w"
        {
            whitePieces.remove(at: whitePieces.index(of: self)!)
        }
        else
        {
            blackPieces.remove(at: blackPieces.index(of: self)!)
        }
        self.removeFromSuperview()
        //self.delete(self) //error
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
