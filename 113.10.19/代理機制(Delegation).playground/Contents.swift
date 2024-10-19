import UIKit

protocol SomeProtocol {
    static func someTypeMethod()
}

//以下範例定義了一個協定，要求具有單一的實體方法：
//定義隨機數字產生器協定
protocol RandomNumberGenerator {
    func random() -> Double
}

//這是一個採納並符合RandomNumberGenerator協定的類別實作。該類別實作了一種
//宣告線性同餘產生類別，採納RandomNumberGenerator協定
class LinearCongruentialGenerator: RandomNumberGenerator {
    //定義計算偽隨機數字的種子
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    //實作協定方法(回傳0.0~1.0之間的數字)
//    func random() -> Double {
//        //truncatingRemainder方法為浮點數的除法取餘數
//        lastRandom = ((lastRandom * a + c)
//            .truncatingRemainder(dividingBy:m))
//        return lastRandom / m
//    }
    
    //方法二
    func random() -> Double {
        //使用隨機函式取得UInt32的隨機數字
        let randomNumber = arc4random()
        //如果隨機數字剛好等於UInt32的最大數
        if randomNumber == UInt32.max {
            //將最大數減1當份子，最大數當分母(避免回傳值為1)
            return Double(randomNumber - 1) / Double(UInt32.max)
        } else {
            //
            return Double(randomNumber) / Double(UInt32.max)
        }
    }
}
//測試隨機數字
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

//--------------------代理機制設定--------------------
//下面的範圍定義了一個骰子遊戲和一個用於追蹤遊戲進度的朝狀協定的代理機制：
//以下此類別為framework的現成類別(無法看到實作)
class DiceGame {  //對比AVAudioPlayer類別
    
    //從行為是代理機制埋設的<步驟一>
    //巢狀協定 對比AVAudioPlayerDelegate
    //DiceGame Delegate協定用來追蹤骰子遊戲的進度
    protocol Delegate: AnyObject {  //此協定比較好的命名方式硬為DiceGameDelegate
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didEndRound round: Int, winner: Int?)
        func gameDidEnd(_ game: DiceGame)
    }
    
    let sides: Int  //骰子面數
    let generator = LinearCongruentialGenerator()  //隨機數字產生器
    //此類別的代理人，以巢狀協定當作型別(此屬性需記錄實做過Delegate協定的型別實體)
    weak var delegate: Delegate?  //對應AVAudioPlayerDelegate
    //此行為代理機制的埋設<步驟二>(將Delegate協定方法委託給別人實作)

    init(sides: Int) {
        self.sides = sides
    }


    //丟骰子的方法(隨機回傳骰子的其中一面)
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }

    //每個玩家輪流擲骰子，骰子最高的玩家贏得這一輪
    //DiceGame.Delegate協定提供了三種追蹤遊戲進度的代理方法。這三種方法被納入play(round:)方法中的遊戲邏輯的實作中。
    //當新遊戲開始，新回合開始或遊戲結束時，Dice類會呼叫其委託方法。
    func play(rounds: Int) {  //呼叫方法時，需傳入要進行幾回
        //從行為代理機埋設的<步驟三>嘗試在某一個方法中，呼叫別人要進行幾回遊戲
        //由代理人"執行"遊戲開始的代理方法
        delegate?.gameDidStart(self)
        //以傳入的遊戲回數來進行遊戲
        for round in 1...rounds {
            //假設只有兩個玩家，分別丟出一個骰子
            let player1 = roll()  //玩家一的骰子點數
            let player2 = roll()  //玩家二的骰子點數
            if player1 == player2 {  //兩個玩家丟出一樣的骰子點數(平手)，沒有勝出者
                delegate?.game(self, didEndRound: round, winner: nil)
            } else if player1 > player2 {
                delegate?.game(self, didEndRound: round, winner: 1)
            } else {
                delegate?.game(self, didEndRound: round, winner: 2)
            }
        }
        //遊戲結束時，執行遊戲結束的代理方法
        delegate?.gameDidEnd(self)
    }
}

//--------------------代理機制使用--------------------
//<步驟一>
//下一個範例展示一個名為DiceGameTracker的類別(對比ViewController)，他採納Dice.Delegate協定：
class DiceGameTracker: DiceGame.Delegate {
    //玩家累積分數
    var playerScore1 = 0
    var playerScore2 = 0
    func gameDidStart(_ game: DiceGame) {
        print("Started a new game")
        //將分數歸零
        playerScore1 = 0
        playerScore2 = 0
    }
    func game(_ game: DiceGame, didEndRound round: Int, winner: Int?) {
        switch winner {
            case 1:
                playerScore1 += 1
                print("Player 1 won round \(round)")
            case 2:
                playerScore2 += 1
                print("Player 2 won round \(round)")
            default:
                print("The round was a draw")
        }
    }
    func gameDidEnd(_ game: DiceGame) {
        if playerScore1 == playerScore2 {
            print("The game ended in a draw.")
        } else if playerScore1 > playerScore2 {
            print("Player 1 won!")
        } else {
            print("Player 2 won!")
        }
    }
}

let tracker = DiceGameTracker()  //對比ViewController的實體(現有頁面已經自動產生)
let game = DiceGame(sides:6)  //對比AVAudioPlayer的實體
game.delegate = tracker  //對比audioPlayer.delegate = self
game.play(rounds: 3)  //遊戲進行時，會嘗試呼叫代理方法
