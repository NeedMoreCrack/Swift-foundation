import UIKit

class SecondViewController: UIViewController {
    
    //<訊息傳遞的Step1>此標籤用於"顯示"上一頁傳遞過來的訊息
    @IBOutlet weak var labelMessage: UILabel!
    //<訊息傳遞的Step2>"接取"上一頁傳遞過來的訊息(從儲存屬性與介面無關)
    var stringMessage:String = ""
    
    //回上一頁按鈕
    @IBAction func buttonBack(_ sender: UIButton) {
        //移除本頁
        self.dismiss(animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("第一頁 : view 2 載入完成")
        //<訊息傳遞的Step3>將接取自上一頁的訊息顯示在介面上
        labelMessage.text = stringMessage
        
    }
    
    deinit {
        print("第二頁被釋放")
    }
    
    //MARK: - View Life Cycle
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view 2 即將出現")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view 2 已經出現")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("view 2 已經完成介面佈置")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view 2 已經消失")
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
