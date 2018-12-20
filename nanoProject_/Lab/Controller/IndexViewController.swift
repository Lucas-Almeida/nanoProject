//
//  IndexViewController.swift
//  Lab
//
//  Created by Ana Caroline Freitas Sampaio on 18/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    @IBOutlet weak var firulaImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var inviteLabel: UILabel!
    
    let indexViewSegue = "searchSegue"
    
    let greeting = GreetingGenerator()
    
    @IBAction func didSearchButonTapped(_ sender: Any) {
        let search = searchTextField.text
        performSegue(withIdentifier: indexViewSegue, sender: search)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController {
            controller.searchBarContent = sender as? String
        }
    }
    
    var color1 = UIColor(displayP3Red: 200/255, green: 104/255, blue: 96/255, alpha: 1)
    var color2 = UIColor(displayP3Red: 40/255, green: 48/255, blue: 56/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.delegate = self
        self.searchTextField.clearButtonMode = .always
        
        searchPersonalization()
        tapOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        inviteLabel.text = greeting.getRandomGreeting()
    }

}

extension IndexViewController: UITextFieldDelegate {
    func searchPersonalization() {
        searchTextField.placeholder = "Ex: Daniel, Emma, etc..."
        searchTextField.textColor = color2
        searchTextField.font = UIFont.systemFont(ofSize: 20)
        
        buttonView.layer.cornerRadius = 25.0
        buttonView.backgroundColor = color1
        buttonView.layer.shadowOpacity = 0.3
        buttonView.layer.shadowOffset = CGSize(width: 1, height: 1)
        buttonView.layer.shadowColor = color2.cgColor
        
        firulaImageView.image = UIImage(named: "firula")
        firulaImageView.layer.shadowOpacity = 0.3
        firulaImageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        firulaImageView.layer.shadowColor = color2.cgColor
        
        inviteLabel.text = greeting.getRandomGreeting()
        
        guard let customFont = UIFont(name: "Quicksand-Regular", size: UIFont.labelFontSize) else {
            fatalError("Failed to load the 'CustomFont-Light' font. Make sure the font file is included in the project and the font name is spelled correctly.")
        }
        
        searchTextField.font = UIFontMetrics.default.scaledFont(for: customFont)
        searchTextField.adjustsFontForContentSizeCategory = true
    }
    
    func tapOut() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        singleTapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTapGesture)
    }
    
    @objc func didTapView() {
        if searchTextField.isFirstResponder {
            searchTextField.resignFirstResponder()
        }
    }
    
    //Delegate do text field
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let search = textField.text!
        
        if search != "" {
           performSegue(withIdentifier: indexViewSegue, sender: search)
        }
        
        return true
    }
    
    
}
