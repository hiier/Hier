//
//  CommentsViewController.swift
//  Hier
//
//  Created by Yang Zhao on 11/27/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: - Constants
    
    private let CellReuseIdentifier = "commentTableViewCell"

    
    // MARK: - Outlets
    
    private var tableView: UITableView!
    private var toolbar: UIToolbar!
    private var textField: UITextField!
    
    // MARK: - Properties
    
    public var comments: [Comment] = []

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = .roundedRect
        textField.borderColor = Constants.ThemeColor
        textField.delegate = self
        
        toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .white
        toolbar.tintColor = Constants.ThemeColor
        toolbar.setItems([
            UIBarButtonItem(customView: textField),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(post))
            ], animated: false)
        
        view.addSubview(tableView)
        view.addSubview(toolbar)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.bottom.equalTo(toolbar.snp.top)
            make.trailing.equalTo(view.snp.trailing)
        }
        toolbar.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view.snp.leading)
            make.bottom.equalTo(view.snp.bottom)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath)
        if let ctvc = cell as? CommentTableViewCell {
            ctvc.selectionStyle = .none
            ctvc.comment = comments[indexPath.row]
        }
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.center = CGPoint(x: view.center.x, y: view.center.y - 110)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.center = CGPoint(x: view.center.x, y: view.center.y + 110)
    }
    
    // MARK: - Methods
    func post() {
        
    }
}
