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
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var currentImage: UIImage! {
        didSet {
            guard oldValue != currentImage else { return }
            do {
                averageColor = try currentImage.averageColor()
                dominantColors = try currentImage.dominantColorFrequencies()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private var dominantColors = [ColorFrequency]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var averageColor: UIColor!
    
    private static let images = [
        UIImage(named: "Dominant_Color_Image_1")!,
        UIImage(named: "Dominant_Color_Image_2")!,
        UIImage(named: "Dominant_Color_Image_3")!,
        UIImage(named: "Dominant_Color_Image_4")!,
        UIImage(named: "Dominant_Color_Image_5")!,
        UIImage(named: "Dominant_Color_Image_6")!
    ]
    
    private lazy var imageViews: [UIImageView] = {
        return DominantColorsViewController.images.map { (image) -> UIImageView in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        scrollView.delegate = self
        scrollView.subviews.first?.removeFromSuperview()
        
        imageViews.forEach { (imageView) in
            scrollView.addSubview(imageView)
        }
        
        currentImage = DominantColorsViewController.images.first!
        
        var constraints = [NSLayoutConstraint]()
        
        for (index, imageView) in imageViews.enumerated() {
            constraints += [
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            ]
            if index == 0 {
                constraints.append(imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor))
            } else {
                let previousImageView = imageViews[index - 1]
                constraints.append(imageView.leadingAnchor.constraint(equalTo: previousImageView.trailingAnchor))
            }
            
            if index == imageViews.count - 1 {
                constraints.append(scrollView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor))
            }
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(DominantColorsViewController.images.count), height: scrollView.bounds.height)
    }

}

extension DominantColorsViewController: UITableViewDataSource {
    
    enum DominantColorsTableViewSection: Int, CaseIterable {
        case dominantColor = 0
        case averageColor = 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DominantColorsTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = DominantColorsTableViewSection(rawValue: section) else {
            fatalError("Could not map section to `DominantColorsTableViewSection` enum")
        }
        
        switch section {
        case .dominantColor:
            return dominantColors.count
        case .averageColor:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DominantColorsTableViewSection(rawValue: indexPath.section) else {
            fatalError("Could not map section to `DominantColorsTableViewSection` enum")
        }
        
        let cell = UITableViewCell()
        
        switch section {
        case .dominantColor:
            let colorFrequency = dominantColors[indexPath.row]
            cell.backgroundColor = colorFrequency.color
            cell.textLabel?.text = "\(colorFrequency.frequency)"
        case .averageColor:
            cell.backgroundColor = averageColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = DominantColorsTableViewSection(rawValue: section) else {
            fatalError("Could not map section to `DominantColorsTableViewSection` enum")
        }

        switch section {
        case .dominantColor:
            return "Dominant Colors"
        case .averageColor:
            return "Average Color"
        }
    }
    
}

extension DominantColorsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let numberOfPages = imageViews.count
        let currentPage = Int(scrollView.contentOffset.x / (scrollView.contentSize.width / CGFloat(numberOfPages)))
        guard let currentImage = imageViews[currentPage].image else {
            fatalError("Could not find image.")
        }
        
        self.currentImage = currentImage
    }
    
}
