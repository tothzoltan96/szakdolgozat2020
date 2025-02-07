//
//  MedicinesViewController+controlling.swift
//  szakdolgozat2020
//
//  Created by Tóth Zoltán on 2020. 05. 16..
//  Copyright © 2020. Tóth Zoltán. All rights reserved.
//

// Imports
import Foundation
import UIKit

// MedicinesControlling protocol
protocol MedicinesControlling {
    func start (with pageSource: PageSource)
    func gatherMedicines()
}

//MARK: - MedicinesControlling

// MedicinesControlling protocol implement here
extension MedicinesViewController: MedicinesControlling {
    
    // Variables
    var controller: MedicinesControlling {
        self
    }
    
    // Functions
    func start(with pageSource: PageSource) {
        presenter.displayTitle(by: args.pageSource)
        gatherMedicines()
    }
    
    func gatherMedicines() {
        medicineProvier.getMedicines { [weak self] medicines in
            DispatchQueue.main.sync {
                self?.presenter.display(medicines)
            }
        }
    }
}
