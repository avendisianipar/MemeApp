//
//  MemeListViewController.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 22/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

class MemeListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var defaultEmptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
}

private extension MemeListViewController {
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let memeCell = UINib(nibName: "MemeTableCell", bundle: nil)
        tableView.register(memeCell, forCellReuseIdentifier: "MemeTableCell")
    }
}

extension MemeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as? MemeTableCell else {
            return UITableViewCell()
        }
        
        cell.setData(image: UIImage(),
                     desc: "Lorem ipsum, utawa ringkesé lipsum, iku tèks standar sing dipasang kanggo nuduhaké.")
        
        return cell
    }
}

extension MemeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}



