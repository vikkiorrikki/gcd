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
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        } //Schedules a block for execution using the specified attributes, and returns immediately.
    }
    
    fileprivate func loginAlert() {
        let alertController = UIAlertController(title: "Login?", message: "Input your loagin and password", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancleAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        
        alertController.addTextField { (userNameTextField) in
            userNameTextField.placeholder = "Input your login"
        }
        
        alertController.addTextField { (userPasswordTextField) in
            userPasswordTextField.placeholder = "Input your password"
            userPasswordTextField.isSecureTextEntry = true
        }
        
        self.present(alertController, animated: true)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://www.itl.cat/pngfile/big/253-2531591_roger-federer-high-quality-wallpapers-melhor-jogador-de.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async { //UI should be processed in the main thread
                self.image = UIImage(data: imageData)
            }
        }
    }
}

