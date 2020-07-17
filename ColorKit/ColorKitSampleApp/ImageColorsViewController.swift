//
//  ImageColorsViewController.swift
//  ColorKitSampleApp
//
//  Created by Boris Emorine on 5/31/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit
import ColorKit

class ImageColorsViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        return ImageColorsViewController.images.map { (image) -> UIImageView in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        scrollView.delegate = self
        scrollView.subviews.first?.removeFromSuperview()
        
        imageViews.forEach { (imageView) in
            scrollView.addSubview(imageView)
        }
        
        currentImage = ImageColorsViewController.images.first!
        
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
        pageControl.numberOfPages = imageViews.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(ImageColorsViewController.images.count), height: scrollView.bounds.height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorDetailViewController = segue.destination as? ColorDetailViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow,
            let section = DominantColorsTableViewSection(rawValue: selectedIndexPath.section) else {
                fatalError("Failed to get requirements for segue.")
        }

        var color: UIColor
        switch section {
        case .dominantColor:
            color = dominantColors[selectedIndexPath.row].color
        case .averageColor:
            color = averageColor
        }
        
        colorDetailViewController.color = color
        tableView.deselectRow(at: selectedIndexPath, animated: true)
    }

}

extension ImageColorsViewController: UITableViewDataSource {
    
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

extension ImageColorsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toColorDetail", sender: nil)
    }
    
}

extension ImageColorsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard !(scrollView is UITableView) else { return }
        let numberOfPages = imageViews.count
        let currentPage = Int(scrollView.contentOffset.x / (scrollView.contentSize.width / CGFloat(numberOfPages)))
        guard let currentImage = imageViews[currentPage].image else {
            fatalError("Could not find image.")
        }
        
        self.currentImage = currentImage
        pageControl.currentPage = currentPage
    }
    
}
