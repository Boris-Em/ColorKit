//
//  ColorDetailViewController.swift
//  ColorKitSampleApp
//
//  Created by Boris Emorine on 7/17/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit
import ColorKit

class ColorDetailViewController: UITableViewController {
    
    var color: UIColor!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var cielabLabel: UILabel!
    @IBOutlet weak var xyzLabel: UILabel!
    @IBOutlet weak var cmykLabel: UILabel!
    @IBOutlet weak var relativeLuminanceLabel: UILabel!
    @IBOutlet weak var complementaryColorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = color
        colorNameLabel.text = "Name: \(color.name())"
        rgbLabel.text = String(format: "Red: %.2f Green: %.2f Blue: %.2f", color.red, color.green, color.blue)
        hexLabel.text = "Hex: \(color.hex)"
        cielabLabel.text = "CIE L: \(color.L) a: \(color.a) b: \(color.b)"
        xyzLabel.text = "X: \(color.X) Y: \(color.Y) Z:\(color.Z)"
        cmykLabel.text = String(format: "C: %.2f M: %.2f Y: %.2f K: %.2f", color.cyan, color.magenta, color.yellow, color.key)
        relativeLuminanceLabel.text = "Relative Luminance: \(color.relativeLuminance)"
        complementaryColorView.backgroundColor = color.complementaryColor
        complementaryColorView.layer.cornerRadius = 5
    }
    
}
