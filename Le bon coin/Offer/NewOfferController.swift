//
//  Project > Le bon coin
//  Filename > NewOfferController.swift
//
//  Created by Guillaume Gonzales on 04/10/2018.
//  Copyright © 2018 Tokidev S.A.S. - All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewOfferController: UIViewController, UITextFieldDelegate {
    
    
    // variable composnt graphique
    
    let titleAnnonce: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = " Title"
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let categoryAnnonce: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = "Category"
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let cityAnnonce: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = "City"
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let shortDescriptionAnnonce: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = "Short description"
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let priceAnnonce: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.placeholder = "Price"
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let createAnnonce: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 0.5)
        button.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBarTitle()
        setupAnnonce()
    }
    
    fileprivate func setupNavigationBarTitle() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.clipsToBounds = true
        navigationItem.titleView = titleImageView
    }
    
    // insert and organise component inside our view
    fileprivate func setupAnnonce() {
        view.addSubview(titleAnnonce)
        view.addSubview(categoryAnnonce)
        view.addSubview(cityAnnonce)
        view.addSubview(shortDescriptionAnnonce)
        view.addSubview(priceAnnonce)
        view.addSubview(createAnnonce)
        
        titleAnnonce.delegate = self
        categoryAnnonce.delegate = self
        cityAnnonce.delegate = self
        shortDescriptionAnnonce.delegate = self
        priceAnnonce.delegate = self
        
        
        titleAnnonce.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        categoryAnnonce.anchor(top: titleAnnonce.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        cityAnnonce.anchor(top: categoryAnnonce.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        shortDescriptionAnnonce.anchor(top: cityAnnonce.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        priceAnnonce.anchor(top: shortDescriptionAnnonce.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        createAnnonce.anchor(top: priceAnnonce.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
       
    }
    
    @objc func handleTextChange() {
        
        let formValid = titleAnnonce.text?.isEmpty == false &&
                        categoryAnnonce.text?.isEmpty == false &&
                        shortDescriptionAnnonce.text?.isEmpty == false &&
                        priceAnnonce.text?.isEmpty == false
        
        
        if formValid {
            createAnnonce.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 1)
            createAnnonce.isEnabled = true
        } else {
            createAnnonce.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 0.5)
            createAnnonce.isEnabled = false
        }
    }
    
    @objc func handleCreate(){
        
        guard let title = titleAnnonce.text else { return }
        guard let category = categoryAnnonce.text else { return }
        guard let city = cityAnnonce.text else { return }
        guard let desc = shortDescriptionAnnonce.text else { return }
        guard let price = priceAnnonce.text else { return }
        
        let dictionaryValues = ["title": title,
                                "category": category,
                                "city": city,
                                "offer": desc,
                                "price": price]
        
        let ref = Database.database().reference().child("offers").childByAutoId()
        
        ref.setValue(dictionaryValues)
        
        let alert = UIAlertController(title: "Le boin coin", message: "New offer added !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
