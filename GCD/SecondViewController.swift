//
//  SecondViewController.swift
//  GCD
//
//  Created by Виктория Саклакова on 11.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            
            imageView.image = newValue
            imageView.sizeToFit() // resize the current view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://www.itl.cat/pngfile/big/253-2531591_roger-federer-high-quality-wallpapers-melhor-jogador-de.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
        self.image = UIImage(data: imageData)
    }
}

