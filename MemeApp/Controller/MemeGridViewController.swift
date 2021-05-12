//
//  MemeGridViewController.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 22/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

class MemeGridViewController: UIViewController {
    
    @IBOutlet private weak var defaultEmptyLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MemeLocalData.count() > 0 {
            collectionView.reloadData()
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
        }
    }
    
    @IBAction func createMemeDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "CreateMemeViewController") as? CreateMemeViewController {
            controller.delegate = self
            navigationController?.present(controller, animated: true, completion: nil)
        }
    }
}

private extension MemeGridViewController {
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let memeCell = UINib(nibName: "MemeCollectionCell", bundle: nil)
        collectionView.register(memeCell, forCellWithReuseIdentifier: "MemeCollectionCell")
    }
}

extension MemeGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeLocalData.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as? MemeCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(data: MemeLocalData.getMemes(indexPath.row))
        
        return cell
    }
}

extension MemeGridViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = sectionInsets.left * (itemsPerRow + 1)
        let availWidth = view.frame.width - padding
        let widthPerItem = availWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "MemeDetailViewController") as? MemeDetailViewController {
            controller.memeData = MemeLocalData.getMemes(indexPath.row)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MemeGridViewController: CreateMemeDelegate {
    func didSaveSuccessful() {
        collectionView.reloadData()
        collectionView.isHidden = false
    }
}
