//
//  DominantColorsViewController.swift
//  ColorKitSampleApp
//
//  Created by Boris Emorine on 5/31/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit
import ColorKit

class DominantColorsViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Image_Cover_3")!
        imageView.image = image
        let dominantColors = try! image.dominantColors(with: .high)
        
        dominantColors.forEach { (colorFrequency) in
            let view = DominantColorView(with: colorFrequency)
            view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(view)
        }
    }

}

class DominantColorView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(with colorFrequency: UIImage.ColorFrequency) {
        super.init(frame: .zero)
        backgroundColor = colorFrequency.color
        label.text = "Count: \(colorFrequency.frequency)"
        setupView()
    }
    
    func setupView() {
        addSubview(label)
        
        let constraints = [
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

