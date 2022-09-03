//
//  ObjectSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/09/22.
//

import UIKit

class ObjectSelectionViewController: UIViewController {
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        stackViewRows.leadingAnchor.constraint(equalTo: self.scrollViewObjects.leadingAnchor).isActive = true
        stackViewRows.trailingAnchor.constraint(equalTo:stackViewRows.trailingAnchor).isActive=true
        stackViewRows.topAnchor.constraint(equalTo:stackViewRows.topAnchor).isActive=true
        stackViewRows.bottomAnchor.constraint(equalTo:stackViewRows.bottomAnchor).isActive=true
        
        stackViewRows.widthAnchor.constraint(equalTo:self.view.widthAnchor).isActive=true
         */
        
        stackViewRows.axis = .vertical
        stackViewRows.distribution = .fillEqually
        stackViewRows.spacing = 60

        for _ in 0...30{
            let one = ObjectRowElement()
            stackViewRows.addArrangedSubview(one)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
