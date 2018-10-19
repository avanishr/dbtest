//
//  ViewController.swift
//  DBTest
//
//  Created by Avanish Rayankula on 10/19/18.
//  Copyright © 2018 Epic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        addInsertView()
        //addUpdateView()
        //addShowContentsView()
    }
        
        
    private func addInsertView() {
        let insertView = generateLabel(label: "Insert", textColor: UIColor.white, backgroundColor: UIColor.blue)
        view.addSubview(insertView)
        insertView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(insertRecord))
        insertView.addGestureRecognizer(tap)
        
        
        let horizontalConstraint = insertView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = insertView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = insertView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = insertView.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
    private func generateLabel(label: String, textColor: UIColor, backgroundColor: UIColor) -> UILabel {
        let newLabel = UILabel()
        newLabel.backgroundColor = backgroundColor
        newLabel.textColor = textColor
        newLabel.text = label
        newLabel.textAlignment = NSTextAlignment.center
        newLabel.isUserInteractionEnabled = true
        return newLabel
    }
    
    @objc func insertRecord() {
        print("record inserted")
    }

}

