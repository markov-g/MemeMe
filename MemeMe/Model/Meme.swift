//
//  Meme.swift
//  MemeMe
//
//  Created by Georgi Markov on 6/13/21.
//

import Foundation
import UIKit


struct Meme {
    let topText: String?
    let bottomText: String?
    let originalImage: UIImage?
    let memedImage: UIImage?
    
    private static var memesCollection: [Meme] = [] {
        didSet {
            NSLog("Current memes count \(memesCollection.count)")
        }
    }
    
    static func add(_ meme: Meme) {
        Self.memesCollection.append(meme)
    }
    
    static func getAllMemes() -> [Meme] {
        return Self.memesCollection
    }
    
    static func removeMemeAtIndex(idx: Int) {
        memesCollection.remove(at: idx)
    }
}

