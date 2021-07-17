//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Georgi Markov on 7/4/21.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space)) / 3
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}


// MARK: BarButton Action
extension SentMemesCollectionViewController {
    @objc private func addTapped() {
        let editMemeController = storyboard?.instantiateViewController(identifier: "EditMemeVC") as! ViewController
        navigationController?.pushViewController(editMemeController, animated: true)
    }
    
//    @objc private func editTapped() {
//        if collectionView.isEditing {
//            navigationItem.leftBarButtonItem?.title = "Edit"
//            collectionView.endEditing(true)
//        } else {
//            navigationItem.leftBarButtonItem?.title = "Done!"
//            tableView.setEditing(true, animated: true)
//        }
//    }
}

// MARK: Collection View Data Source
extension SentMemesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme.getAllMemes().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEditing {
            
        }
        let selectedRow = (indexPath as IndexPath).row
        let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailMemeVC") as! MemeDetailViewController
        detailViewController.meme = Meme.getAllMemes()[selectedRow]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = Meme.getAllMemes()[(indexPath as NSIndexPath).row]
        
        // Set the properties
        cell.imgView.image = meme.memedImage
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        
        return cell
    }
    
    // MARK - Data source methods to implement for Delete actions
    override func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
