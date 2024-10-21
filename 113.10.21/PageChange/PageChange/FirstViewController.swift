//
//  ViewController.swift
//  PageChange
//
//  Created by ChuanChiaWei on 2024/10/21.
//

import UIKit

class FirstViewController: UIViewController {
    
    //<傳遞訊息的Step4> 
    @IBOutlet weak var labelMessage: UILabel!
    
    //MARK： Target Action
    @IBAction func buttonSecondVC(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SecondVC", sender: self)
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("第一頁 : view 1 載入完成")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view 1 即將出現")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view 1 已經出現")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("view 1 已經完成介面佈置")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view 1 已經消失")
    }

    //<訊息傳遞的Step5>即將轉換到下一頁時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "SecondVC" {
            //<訊息傳遞的Step5-1>從連接線實體取得已經初始化的第二頁實體，必須完成子類別的轉型
            let secondVC = segue.destination as! SecondViewController
            //<訊息傳遞的Step5-2>把第一頁的標籤文字拆封過後傳遞給第二頁
            secondVC.stringMessage = labelMessage.text!
            //String?經過強制拆封後，如果字串的包裝盒為nil，會自動變成空自串""
        } else if segue.identifier == "otherVC" {
            //<訊息傳遞的Step5-1>從連接線實體取得已經初始化的第二頁實體，必須完成子類別的轉型
            let secondVC = segue.destination as! SecondViewController
            secondVC.stringMessage = labelMessage.text!
        }
        
        //<訊息傳遞的Step5-1>從連接線實體取得已經初始化的第二頁實體，必須完成子類別的轉型
        //let secondVC = segue.destination as! SecondViewController
        //<訊息傳遞的Step5-2>把第一頁的標籤文字拆封過後傳遞給第二頁
        //secondVC.stringMessage = labelMessage.text!
        //String?經過強制拆封後，如果字串的包裝盒為nil，會自動變成空自串""
    }
    
    

}

