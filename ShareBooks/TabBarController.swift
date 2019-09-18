//
//  TabBarController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/23.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    static func createWithStoryboard() -> TabBarController{
        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        return tabBarController
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
