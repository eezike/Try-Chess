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
    
    //=========================================================================
    //Setting up the board
    @IBOutlet weak var board: UICollectionView!
    var count = 0
    var row = 0
    
    var squares = [[Square]()]
    var oneRow = [Square]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Square
        
        if row % 2 == 0
        {
            if count % 2 == 0
            {
                cell.backgroundColor = .white
            }
            else
            {
                cell.backgroundColor = .black
            }
        }
        else
        {
            if count % 2 == 0
            {
                cell.backgroundColor = .black
            }
            else
            {
                cell.backgroundColor = .white
            }
        }
        
        oneRow.append(cell)
        
        if (count+1) % 8 == 0
        {
            squares.append(oneRow)
            oneRow.removeAll()
            row += 1
            count = -1
        }
        count += 1
        
        cell.value = count+(row*10)
        return cell
    }
    //=========================================================================
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(squares.count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

