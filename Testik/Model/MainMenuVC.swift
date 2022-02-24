//
//  MainMenuVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 10.06.2021.
//

import UIKit

final class MainMenuVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Const, Var & Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var tests = ["Touch", "RGB", "BWG", "Contrast", "Main Speaker", "Front Speaker", "Headphones", "Microphone", "Wi-Fi", "Bluetooth", "Cellular", "GPS", "Camera", "Flash", "AmbiLight", "Accelerometer", "Distanсe", "Authorization", "Compass", "Charge", "Buttons", "Vibration"]
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
        
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tests.count
    }
        
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
            
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = tests[indexPath.item]
        cell.layer.borderColor = UIColor.systemGray2.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 20
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath as IndexPath) as! HeaderCollectionReusableView
        
        header.configure()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSelection selection: Int) -> CGSize {
        return CGSize(width: view.frame.size.width-40, height: 60)
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell \(tests[indexPath.item])!")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(identifier: tests[indexPath.item] ) //as! NewView
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}

