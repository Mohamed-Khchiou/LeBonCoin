//
//  Project > Le bon coin
//  Filename > ViewController.swift
//
//  Created by Guillaume Gonzales on 04/10/2018.
//  Copyright © 2018 Tokidev S.A.S. - All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase // ne fonctionne pas sans chez nous

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var annonces : [Annonce] = []
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 235/255, alpha: 1)
        
        collectionView.register(AnnonceCell.self, forCellWithReuseIdentifier: cellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        setupNavigationBarTitle()
        fetchAnnonces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        fetchAnnonces()
    }
    
    fileprivate func setupNavigationBarTitle() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.clipsToBounds = true
        navigationItem.titleView = titleImageView
        
        
        
    }
    
    fileprivate func fetchAnnonces() {
        annonces.removeAll()
        
        let ref = Database.database().reference().child("offers")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            self.collectionView.refreshControl?.endRefreshing()
            
            guard let annonceDic = snapshot.value as? [String: Any] else { return }
        
                annonceDic.forEach({ (oid,annonceValue) in
                    guard let annonceValue = annonceValue as? [String: Any] else { return }
                    let annonce = Annonce(dictionary: annonceValue)
                    self.annonces.insert(annonce, at: 0)
                    
                })
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        })
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annonces.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnnonceCell
        cell.annonce = annonces[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

