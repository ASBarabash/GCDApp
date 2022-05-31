//
//  SecondViewController.swift
//  GCDApp
//
//  Created by Alexandr Barabash on 30.05.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var imageURL: URL?
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        
    }
    
    private func fetchImage() {
        imageURL = URL(string: "https://images.pexels.com/photos/1485894/pexels-photo-1485894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        // создаем очередь
        let queue = DispatchQueue.global(qos: .utility)
        // помещаем
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            // работу с интерфейсом помещаем в основной поток
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        
    }
}
