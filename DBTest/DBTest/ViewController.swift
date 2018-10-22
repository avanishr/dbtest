//
//  ViewController.swift
//  DBTest
//
//  Created by Avanish Rayankula on 10/19/18.
//  Copyright © 2018 Epic. All rights reserved.
//

import UIKit
import DBAccess

class ViewController: UIViewController {
    var insertView: UILabel?
    var updateView: UILabel?
    var removeView: UILabel?
    var readView: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        addInsertView()
        addUpdateView()
        addRemoveView()
        addShowContentsView()
    }
        
        
    private func addInsertView() {
        insertView = generateLabel(label: "Insert", textColor: UIColor.white, backgroundColor: UIColor.blue)
        let tap = UITapGestureRecognizer(target: self, action: #selector(insertRecord))
        insertView!.addGestureRecognizer(tap)
        
        view.addSubview(insertView!)
        insertView!.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = insertView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        let middleConstraint = insertView!.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthConstraint = insertView!.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = insertView!.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([topConstraint, middleConstraint, widthConstraint, heightConstraint])
    }
    
    private func addUpdateView() {
        updateView = generateLabel(label: "Update", textColor: UIColor.black, backgroundColor: UIColor.green)
        let tap = UITapGestureRecognizer(target: self, action: #selector(updateRecord))
        updateView!.addGestureRecognizer(tap)
        
        view.addSubview(updateView!)
        updateView!.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = updateView!.topAnchor.constraint(equalTo: insertView!.bottomAnchor, constant: 20)
        let middleConstraint = updateView!.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthConstraint = updateView!.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = updateView!.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([topConstraint, middleConstraint, widthConstraint, heightConstraint])
    }
    
    private func addRemoveView() {
        removeView = generateLabel(label: "Remove", textColor: UIColor.white, backgroundColor: UIColor.red)
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeRecord))
        removeView!.addGestureRecognizer(tap)
        
        view.addSubview(removeView!)
        removeView!.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = removeView!.topAnchor.constraint(equalTo: updateView!.bottomAnchor, constant: 20)
        let middleConstraint = removeView!.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthConstraint = removeView!.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = removeView!.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([topConstraint, middleConstraint, widthConstraint, heightConstraint])
    }
    
    private func addShowContentsView() {
        readView = generateLabel(label: "Display", textColor: UIColor.white, backgroundColor: UIColor.brown)
        let tap = UITapGestureRecognizer(target: self, action: #selector(displayRecords))
        readView!.addGestureRecognizer(tap)
        
        view.addSubview(readView!)
        readView!.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = readView!.topAnchor.constraint(equalTo: removeView!.bottomAnchor, constant: 20)
        let middleConstraint = readView!.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthConstraint = readView!.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = readView!.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([topConstraint, middleConstraint, widthConstraint, heightConstraint])
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
        let propertyDef: DBPropertyDefinition = DBPropertyDefinition(name: "categoryID", type: .string, isMultipleResponse: false)
        let properties: [DBProperty] = [DBProperty(type: propertyDef, value: "abc123")]
        let record: DBRecord = DBRecord(identifier: "aaa", type: DBRecordType.category, properties: properties)
        DBQuery.insert(record: record)
    }
    
    @objc func updateRecord() {
        let properties: [DBProperty] = []
        let record: DBRecord = DBRecord(identifier: "aaa", type: DBRecordType.category, properties: properties)
        DBQuery.update(record: record)
    }
    
    @objc func removeRecord() {
        DBQuery.delete(recordWithID: "aaa")
    }
    
    @objc func displayRecords() {
        let record = DBQuery.find(recordWithID: "aaa")
    }
}

