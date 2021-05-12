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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MemeLocalData.count() > 0 {
            tableView.reloadData()
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
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

private extension MemeListViewController {
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        let memeCell = UINib(nibName: "MemeTableCell", bundle: nil)
        tableView.register(memeCell, forCellReuseIdentifier: "MemeTableCell")
    }
}

extension MemeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeLocalData.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as? MemeTableCell else {
            return UITableViewCell()
        }
        
        cell.setData(data: MemeLocalData.getMemes(indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "MemeDetailViewController") as? MemeDetailViewController {
            controller.memeData = MemeLocalData.getMemes(indexPath.row)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MemeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension MemeListViewController: CreateMemeDelegate {
    func didSaveSuccessful() {
        tableView.reloadData()
        tableView.isHidden = false
    }
}
