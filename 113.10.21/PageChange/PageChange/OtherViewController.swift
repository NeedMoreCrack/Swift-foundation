//
//  OtherViewController.swift
//  PageChange
//
//  Created by ChuanChiaWei on 2024/10/21.
//

import UIKit

class OtherViewController: UIViewController {
    
    //回上一頁按鈕
    @IBAction func buttonBack(_ sender: UIButton) {
        //移除本頁
        self.dismiss(animated: true)
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
