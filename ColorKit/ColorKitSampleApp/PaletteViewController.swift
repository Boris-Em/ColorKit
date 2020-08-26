//
//  PaletteViewController.swift
//  ColorKitSampleApp
//
//  Created by Boris Emorine on 8/26/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit
import ColorKit

class PaletteViewController: UIViewController {
    
    private struct Album {
        let image: UIImage
        let name: String
        let artist: String
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private let albums = [
        Album(image: #imageLiteral(resourceName: "Album_cover_1"), name: "My Beautiful Dark Twisted Fantasy", artist: "Kanye West"),
        Album(image: #imageLiteral(resourceName: "Album_cover_2"), name: "Abbey Road", artist: "The Beatles"),
        Album(image: #imageLiteral(resourceName: "Album_cover_3"), name: "Hotel California", artist: "Eagles"),
        Album(image: #imageLiteral(resourceName: "Album_cover_4"), name: "Never Mind the Bollocks", artist: "Sex Pistols"),
        Album(image: #imageLiteral(resourceName: "Album_cover_5"), name: "The Dark Side of the Moon", artist: "Pink Floyd"),
        Album(image: #imageLiteral(resourceName: "Album_cover_6"), name: "Tommy", artist: "The Who"),
        Album(image: #imageLiteral(resourceName: "Album_cover_7"), name: "Pet Sounds", artist: "The Beach Boys"),
        Album(image: #imageLiteral(resourceName: "Album_cover_8"), name: "Modern Sounds", artist: "Ray Charles"),
        Album(image: #imageLiteral(resourceName: "Album_cover_9"), name: "Tougher than Leather", artist: "Run DMC")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        
        resetView()
    }
    
    private func resetView() {
        guard let album = albums.randomElement() else {
            fatalError("Could not get album")
        }
        
        imageView.image = album.image
        
        let colors = try! album.image.dominantColors()
        guard let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) else {
            fatalError("Could not create palette")
        }
        
        view.backgroundColor = palette.background
        
        titleLabel.text = album.name
        titleLabel.textColor = palette.primary
        
        detailLabel.text = album.artist
        detailLabel.textColor = palette.secondary
    }
    @IBAction func handleTapRefresh(_ sender: Any) {
        resetView()
    }
    
}
