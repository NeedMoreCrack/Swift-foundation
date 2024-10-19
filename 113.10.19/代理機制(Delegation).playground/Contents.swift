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


//下面的範圍定義了一個骰子遊戲和一個用於追蹤遊戲進度的朝狀協定的代理機制：
//以下此類別為framework的現成類別(無法看到實作)
class DiceGame {  //對比AVAudioPlayer類別
    let sides: Int  //骰子面數
    let generator = LinearCongruentialGenerator()  //隨機數字產生器
    weak var delegate: Delegate?  //對應AVAudioPlayerDelegate


    init(sides: Int) {
        self.sides = sides
    }


    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }


    func play(rounds: Int) {
        delegate?.gameDidStart(self)
        for round in 1...rounds {
            let player1 = roll()
            let player2 = roll()
            if player1 == player2 {
                delegate?.game(self, didEndRound: round, winner: nil)
            } else if player1 > player2 {
                delegate?.game(self, didEndRound: round, winner: 1)
            } else {
                delegate?.game(self, didEndRound: round, winner: 2)
            }
        }
        delegate?.gameDidEnd(self)
    }

    //巢狀協定 對比AVAudioPlayerDelegate
    protocol Delegate: AnyObject {  //此協定比較好的命名方式硬為DiceGameDelegate
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didEndRound round: Int, winner: Int?)
        func gameDidEnd(_ game: DiceGame)
    }
}
