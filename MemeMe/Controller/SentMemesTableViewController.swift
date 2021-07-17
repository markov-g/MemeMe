//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Georgi Markov on 7/4/21.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: BarButton Action
extension SentMemesTableViewController {
    @objc private func addTapped() {
        let editMemeController = storyboard?.instantiateViewController(identifier: "EditMemeVC") as! ViewController
        navigationController?.pushViewController(editMemeController, animated: true)
    }
    
    @objc private func editTapped() {
        if tableView.isEditing {
            navigationItem.leftBarButtonItem?.title = "Edit"
            tableView.setEditing(false, animated: true)
        } else {
            navigationItem.leftBarButtonItem?.title = "Done!"
            tableView.setEditing(true, animated: true)
        }
    }
}

// MARK: TableView Methods
extension SentMemesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = (indexPath as IndexPath).row
        let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailMemeVC") as! MemeDetailViewController
        detailViewController.meme = Meme.getAllMemes()[selectedRow]
        self.navigationController!.pushViewController(detailViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Meme.getAllMemes().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableCell") else {
            fatalError("DequeReusableCell failed")
        }
        let meme = Meme.getAllMemes()[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
                
        return cell
    }
    
    // MARK - Data source methods to implement for Delete actions
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            Meme.removeMemeAtIndex(idx: indexPath.row)
            tableView.deleteRows(at: [(indexPath as IndexPath)], with: .fade)
        }
    }
}
