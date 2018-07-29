//
//  Square.swift
//  Try Chess
//
//  Created by Emeka Ezike on 7/27/18.
//  Copyright © 2018 Emeka Ezike. All rights reserved.
//

import UIKit

class Square: UICollectionViewCell {
    
    var value = 0
    var color = UIColor.white
    var isOccupied = false
    var occupiedBy = ""
    var isInBounds = true
    var r = 0
    var c = 0

    func getX() -> CGFloat
    {
        
        let x = center.x - 18.75
        return x
    }
    
    func getY() -> CGFloat
    {
        let y = center.y + 89.75 + 37.5
        return y
    }
    
    func getPosition() -> CGPoint
    {
        return CGPoint(x: getX(), y: getY())
    }
    
}
