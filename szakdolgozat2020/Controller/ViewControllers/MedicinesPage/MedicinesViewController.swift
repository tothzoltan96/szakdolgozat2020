//
//  MedicineViewController.swift
//  szakdolgozat2020
//
//  Created by Tóth Zoltán on 2020. 04. 27..
//  Copyright © 2020. Tóth Zoltán. All rights reserved.
//

import UIKit

// Medicines page - UIViewController
class MedicinesViewController: UIViewController, ProvidingInjecting, UITableViewDelegate {
    
    // Args struct
    struct Args {
        var pageSource: PageSource
    }
    
    // Variables
    var medicineArgs = Args(pageSource: .medicines)
    private(set) lazy var medicineProvier: MedicineProviding = {
        medicineInject(medicineArgs.pageSource)
    }()
    
    // IB Outlets
    @IBOutlet weak var medicineSearchBar: UISearchBar!
    @IBOutlet weak var medicineQrCodeReaderButton: UIButton!
    @IBOutlet weak var medicineTableView: UITableView!
    
    // For grouped list variables
    var medicinesDictionary                                 = [String: [MedicineModel]]()
    var sectionLetters                                      = [String]()
    var medicines                                           = [MedicineModel]()
    
    // viewDidLoad func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.start(with: medicineArgs.pageSource)
        
        self.dismissKey()
        medicineSearchBar.delegate                          = self
        medicineSearchBar.enablesReturnKeyAutomatically     = true
        medicineSearchBar.placeholder                       = NSLocalizedString("medicinesTab.searchBar.placeholder.text", comment: "")
        medicineSearchBar.searchTextField.backgroundColor   = Colors.appBlue
        medicineSearchBar.searchTextField.textColor         = .white
        medicineSearchBar.searchTextField.tintColor         = .white
        medicineSearchBar.image(for: .search, state: .normal)
        
        medicineTableView.sectionIndexBackgroundColor       = .white
        medicineTableView.backgroundColor                   = .white
        medicineTableView.tintColor                         = .red
        medicineTableView.dataSource                        = self
        medicineTableView.delegate                          = self
    }
    
    func selectionCalculator() {
        for medicineItem in medicines {
            let medicineKey = String(medicineItem.medicineName.prefix(1))
            if var medicineValues = medicinesDictionary[medicineKey] {
                medicineValues.append(medicineItem)
                medicinesDictionary[medicineKey] = medicineValues
            } else {
                medicinesDictionary[medicineKey] = [medicineItem]
            }
        }
        
        sectionLetters = medicinesDictionary.keys.sorted()
    }
}

//MARK: - MedicinesViewController - #1 Extension: Hide keyboard

extension MedicinesViewController {
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MedicinesViewController.dismissKeyboard))
        tap.cancelsTouchesInView        = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        medicineSearchBar.text         = ""
        view.endEditing(true)
    }
}

//MARK: - UISearchBarDelegate

extension MedicinesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        medicineSearchBar.text = ""
        medicineSearchBar.resignFirstResponder()
    }
}
