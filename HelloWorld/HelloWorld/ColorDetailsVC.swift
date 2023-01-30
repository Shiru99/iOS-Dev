//
//  ColorDetailsVC.swift
//  HelloWorld
//
//  Created by Shriram Ghadge on 28/01/23.
//

import UIKit

class ColorDetailsVC: UIViewController {
    
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color ?? .blue
    }
    


}
