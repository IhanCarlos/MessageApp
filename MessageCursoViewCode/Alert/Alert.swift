//
//  Alert.swift
//  StudyViewCode
//
//  Created by ihan carlos on 06/01/23.
//

import Foundation
import UIKit

class Alert: NSObject {
    
    var controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title:String, mensager:String, complition: (()-> Void)? = nil) {
        let alertController = UIAlertController(title: title , message: mensager, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel) { action in
            complition?()
        }
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true, completion: nil)
    }
}
