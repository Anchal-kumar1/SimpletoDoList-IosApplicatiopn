//
//  SplashVc.swift
//  DemotodoList
//
//  Created by Anchal on 13/06/23.
//

import UIKit

class SplashVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    

   

}
