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
    var pieceRow = 0
    var pieceColumn = 0
    var holdR = 0
    var holdC = 0
    var beenMoved = false
    
    init(type: String, color: String, rc: Array<Int>) {
        let image = UIImage(named: color+type)
        super.init(image: image)
        pieceType = type
        pieceColor = color
        beenMoved = false
        pieceRow = rc[0]
        pieceColumn = rc[1]
        frame = CGRect(origin: squaresGrid[pieceRow][pieceColumn].getPosition(), size: CGSize(width: 37.5, height: 37.5))
        squaresGrid[pieceRow][pieceColumn].isOccupied = true
        squaresGrid[pieceRow][pieceColumn].occupiedBy = pieceColor
    }
    
    func getSquare() -> Square
    {
        return squaresGrid[pieceRow][pieceColumn]
    }
    
    func availMoves () -> Array<Square>
    {
        var moves = [Square]()
        
        switch pieceType
        {
        case "Pawn":
            moves = pawnMoves()
        case "Rook":
            moves = rookMoves()
        case "Knight":
            moves = knightMoves()
        case "Bishop":
            moves = bishopMoves()
        case "Queen":
            moves = rookMoves() + bishopMoves()
        case "King":
            moves = rookMoves() + bishopMoves()
        default:
            break
        }
        
        return moves
    }
    
    func move(to: Square)
    {
        squaresGrid[pieceRow][pieceColumn].isOccupied = false
        squaresGrid[pieceRow][pieceColumn].occupiedBy = ""
        
        UIView.animate(withDuration: 0.375, animations: {self.frame.origin = to.getPosition()}, completion: nil)
        
        if to.isOccupied
        {
            if pieceColor == "w"
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
        
        
        beenMoved = true
        pieceRow = to.r
        pieceColumn = to.c
        to.isOccupied = true
        to.occupiedBy = pieceColor
    }
    
    //===================================================
    var blockingPiece = [Piece]()
    func simMove(to: Square)
    {
        squaresGrid[pieceRow][pieceColumn].isOccupied = false
        squaresGrid[pieceRow][pieceColumn].occupiedBy = ""
        blockingPiece.removeAll()
                if to.isOccupied
                {
                    if self.pieceColor == "b"
                    {
                        for piece in whitePieces
                        {
                            if piece.getSquare() == to
                            {
                                whitePieces.remove(at: whitePieces.index(of: piece)!)
                                blockingPiece.append(piece)
                            }
                        }
                    }

                }
        holdR = pieceRow
        holdC = pieceColumn
        pieceRow = to.r
        pieceColumn = to.c
        to.isOccupied = true
        to.occupiedBy = pieceColor
    }
    
    func goBack(to: Square)
    {
       
        to.isOccupied = false
        to.occupiedBy = ""
        if !blockingPiece.isEmpty
        {
            whitePieces.append(blockingPiece[0])
            to.isOccupied = true
            to.occupiedBy = "w"
        }
        pieceRow = holdR
        pieceColumn = holdC
        squaresGrid[pieceRow][pieceColumn].isOccupied = true
        squaresGrid[pieceRow][pieceColumn].occupiedBy = pieceColor
    }
    //============================================
    
    //=========================================
    //kinds of moves
    func pawnMoves() -> Array<Square>
    {
        var pawnMoves = [Square]()
        var direc = -1
        if pieceColor == "b"
        {
            direc = 1
        }
        if !squaresGrid[pieceRow+direc][pieceColumn].isOccupied && squaresGrid[pieceRow+direc][pieceColumn].isInBounds
        {
            pawnMoves.append(squaresGrid[pieceRow+direc][pieceColumn])
            
        }
        if squaresGrid[pieceRow+direc][pieceColumn+1].occupiedBy != pieceColor && squaresGrid[pieceRow+direc][pieceColumn+1].occupiedBy != ""
        {
            pawnMoves.append(squaresGrid[pieceRow+direc][pieceColumn+1])
        }
        if squaresGrid[pieceRow+direc][pieceColumn-1].occupiedBy != pieceColor && squaresGrid[pieceRow+direc][pieceColumn-1].occupiedBy != ""
        {
            pawnMoves.append(squaresGrid[pieceRow+direc][pieceColumn-1])
        }
        
        if !beenMoved && !squaresGrid[pieceRow+direc][pieceColumn].isOccupied && !squaresGrid[pieceRow+(direc*2)][pieceColumn].isOccupied
        {
            pawnMoves.append(squaresGrid[pieceRow+(direc*2)][pieceColumn])
        }
        
        return pawnMoves
    }
    
    
    func rookMoves() -> Array<Square>
    {
        var up = true
        var down = true
        var left = true
        var right = true
        var rookMoves = [Square]()
        
        var length = 0
        
        if pieceType == "King"
        {
            length = 1
        }
        else
        {
            length = 7
        }
        
        for index in 1...length
        {
            if up && squaresGrid[pieceRow-index][pieceColumn].isInBounds && !squaresGrid[pieceRow-index][pieceColumn].isOccupied
            {
                rookMoves.append(squaresGrid[pieceRow-index][pieceColumn])
            }
            else if up && squaresGrid[pieceRow-index][pieceColumn].isInBounds && squaresGrid[pieceRow-index][pieceColumn].occupiedBy != pieceColor
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
            else if down && squaresGrid[pieceRow+index][pieceColumn].isInBounds && squaresGrid[pieceRow+index][pieceColumn].occupiedBy != pieceColor
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
            else if right && squaresGrid[pieceRow][pieceColumn+index].isInBounds && squaresGrid[pieceRow][pieceColumn+index].occupiedBy != pieceColor
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
            else if left && squaresGrid[pieceRow][pieceColumn-index].isInBounds && squaresGrid[pieceRow][pieceColumn-index].occupiedBy != pieceColor
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
    
    func bishopMoves() -> Array<Square>
    {
        var upR = true
        var downR = true
        var upL = true
        var downL = true
        var bishopMoves = [Square]()
        
        var length = 0
        
        if pieceType == "King"
        {
            length = 1
        }
        else
        {
            length = 7
        }
        
        for index in 1...length
        {
            if upR && squaresGrid[pieceRow-index][pieceColumn+index].isInBounds && !squaresGrid[pieceRow-index][pieceColumn+index].isOccupied
            {
                bishopMoves.append(squaresGrid[pieceRow-index][pieceColumn+index])
                
            }
            else if upR && squaresGrid[pieceRow-index][pieceColumn+index].isInBounds && squaresGrid[pieceRow-index][pieceColumn+index].occupiedBy != pieceColor
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
            else if downR && squaresGrid[pieceRow+index][pieceColumn+index].isInBounds && squaresGrid[pieceRow+index][pieceColumn+index].occupiedBy != pieceColor
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
            else if upL && squaresGrid[pieceRow-index][pieceColumn-index].isInBounds && squaresGrid[pieceRow-index][pieceColumn-index].occupiedBy != pieceColor
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
            else if downL && squaresGrid[pieceRow+index][pieceColumn-index].isInBounds && squaresGrid[pieceRow+index][pieceColumn-index].occupiedBy != pieceColor
            {
                bishopMoves.append(squaresGrid[pieceRow+index][pieceColumn-index])
                downL = false
            }
            else
            {
                downL = false
            }
            
        }
        return bishopMoves
    }
    
    
    func knightMoves() -> Array<Square>
    {
        var knightMoves = [Square]()
        var index = -1
        
        //r +/- 1, r +/- 2, c +/- 1  c +/- 1, c +/- 2, r +/- 1
        for count in -2...2
        {
            if count == 0
            {
                continue
            }
            
            if count % 2 == 0
            {
                index = 1
            }
            else
            {
                index = -1
            }
            
            if squaresGrid[pieceRow+index][pieceColumn].isInBounds
            {
                if squaresGrid[pieceRow+(index*2)][pieceColumn].isInBounds
                {
                    if squaresGrid[pieceRow+(index*2)][pieceColumn+(count/abs(count))].isInBounds && (squaresGrid[pieceRow+(index*2)][pieceColumn+(count/abs(count))].occupiedBy != pieceColor)
                    {
                        knightMoves.append(squaresGrid[pieceRow+(index*2)][pieceColumn+(count/abs(count))])
                    }
                }
                
            }
            
            if squaresGrid[pieceRow][pieceColumn+index].isInBounds
            {
                if squaresGrid[pieceRow][pieceColumn+(index*2)].isInBounds
                {
                    if squaresGrid[pieceRow+(count/abs(count))][pieceColumn+(index*2)].isInBounds && (squaresGrid[pieceRow+(count/abs(count))][pieceColumn+(index*2)].occupiedBy != pieceColor)
                    {
                        knightMoves.append(squaresGrid[pieceRow+(count/abs(count))][pieceColumn+(index*2)])
                    }
                }
                
            }
            
            
        }
        return knightMoves
    }
    //=========================================
    
    func promote() -> UIAlertController
    {
        let alert = UIAlertController(title: "Promote your pawn", message: "", preferredStyle: .alert)
        
        let promotions = ["Queen", "Rook", "Knight", "Bishop"]
        for type in promotions
        {
            alert.addAction(UIAlertAction(title: type, style: .default, handler: { (action) in
                self.pieceType = type
                self.image = UIImage(named: self.pieceColor+self.pieceType)
            }))
        }
       
        return alert
        
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
