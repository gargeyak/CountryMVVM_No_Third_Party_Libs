//
//  ViewController.swift
//  AssessmentMVVM
//
//  Created by Ady on 11/1/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class ViewController: UIViewController {
    
    var countryViewModel = CountryViewModel()
    var isShowingList = true
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDataFromviewModel()
        setFlowLayoutForCollectionView(isList: true)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            isShowingList = true
        case 1:
            isShowingList = false
        default:
            break
        }
        setFlowLayoutForCollectionView(isList: isShowingList)
    }
    
    
    func getDataFromviewModel() {
        
        countryViewModel.getDataFromApi { [unowned self] (error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return countryViewModel.countryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemAtIndex = countryViewModel.countryArr[indexPath.row]
        
        if isShowingList{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCollectionViewCell else{
                return UICollectionViewCell()
            }
            DispatchQueue.main.async {
                cell.itemNameLbl.text = itemAtIndex.Name
            }
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as? GridCollectionViewCell else{
                return UICollectionViewCell()
            }
            DispatchQueue.global().async {
                if let imageUrl = URL(string: itemAtIndex.FlagPng){
                    if let image = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage{
                        DispatchQueue.main.async {
                            cell.itemImgView.image = image
                        }
                    }else{
                        
                        do{
                            let data = try Data.init(contentsOf: imageUrl)
                            let image = UIImage(data: data)
                            imageCache.setObject(image!, forKey: imageUrl as AnyObject)
                            DispatchQueue.main.async {
                                cell.itemImgView.image = image
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            return cell
        }
    }
    
    func setFlowLayoutForCollectionView(isList: Bool) {
        
        let collectionViewFrame = collectionView.frame
        if isList {
            
            let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: collectionViewFrame.width, height: 30)
            collectionView.collectionViewLayout = collectionViewFlowLayout
        } else {
            
            let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: collectionViewFrame.width/2 - 10, height: collectionViewFrame.width/2 - 10)
            collectionViewFlowLayout.minimumInteritemSpacing = 5
            collectionViewFlowLayout.minimumLineSpacing = 5
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            collectionView.collectionViewLayout = collectionViewFlowLayout
        }
        collectionView.reloadData()
    }
}
