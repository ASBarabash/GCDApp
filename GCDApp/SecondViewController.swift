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
        delay(3) {
            self.loginAlert()
        }
    }
    
    // Задержка asyncAfter
    private func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    private func loginAlert() {
        let ac = UIAlertController(title: "Зарегестрированы?", message: "Введите Ваш логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { userNameTF in
            userNameTF.placeholder = "Введите логин"
        }
        
        ac.addTextField { userPasswordTF in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        self.present(ac, animated: true, completion: nil)
        
    }
    
    private func fetchImage() {
        imageURL = URL(string: "https://placepic.ru/wp-content/uploads/2019/07/Majestic-Sow.jpg")
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
