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

    
    func getX() -> Int
    {
        return 5
    }
    
    func getY() -> Int
    {
        return 5
    }
    
    func getPosition() -> CGPoint
    {
        return CGPoint(x: getX(), y: getY())
    }
    
}
