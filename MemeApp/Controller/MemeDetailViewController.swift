//
//  MemeDetailViewController.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 13/05/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageDetailView: UIImageView!
    
    var memeData: MemeDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }
}

private extension MemeDetailViewController {
    func setUpData() {
        if let data = memeData {
            imageDetailView.image = data.memedImage
        } else {
            let alert = UIAlertController(title: "Ops...", message: "Failed to load image, please try again later.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
}
