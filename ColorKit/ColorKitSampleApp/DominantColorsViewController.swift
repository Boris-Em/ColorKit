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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dominantColors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let colorFrequency = dominantColors[indexPath.row]
        cell.backgroundColor = colorFrequency.color
        cell.textLabel?.text = "\(colorFrequency.frequency)"
        return cell
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
