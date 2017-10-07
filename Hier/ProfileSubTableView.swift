//
//  ProfileSubTableView.swift
//  Hier
//
//  Created by P.R.K on 10/5/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class ProfileSubTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    internal lazy var heights = [IndexPath: CGFloat]()
    open var dataSourceItems = [DataSourceItem]()
 
    
    /**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    /// An initializer.
    public init() {
        super.init(frame: .zero, style: .plain)
        prepare()
    }
    
    /// Prepares the tableView.
    open func prepare() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = nil
        
        register(TableViewCell.self, forCellReuseIdentifier: "ProfileSubTableViewCell")
    }


}

extension ProfileSubTableView: TableViewDataSource {
    
    
    @objc
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceItems.count
    }
    
    @objc
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSubTableViewCell", for: indexPath) as! TableViewCell
        
        guard let data = dataSourceItems[indexPath.row].data as? [String: String] else {
            return cell
        }
        
    
        cell.imageView?.image = UIImage(named:"defaultProfile")
        cell.detailTextLabel?.text = "detail info"
        cell.dividerColor = Color.grey.lighten2
        cell.textLabel?.text = data["name"]
        
        return cell
    }
    
    
    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    /// Prepares the cells within the tableView.
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
//        cell.data = data[indexPath.row]
//        cell.isLast = indexPath.row == data.count - 1
//        heights[indexPath] = cell.height
//        return cell
//    }
}

extension ProfileSubTableView: TableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return heights[indexPath] ?? 100
          return 88
    }
}
