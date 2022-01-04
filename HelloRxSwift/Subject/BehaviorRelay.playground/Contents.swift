import UIKit
import RxSwift
import RxCocoa

let disposebag = DisposeBag()



let relay = BehaviorRelay(value: "initial value")

relay.asObservable()
    .subscribe {
        print($0)
    }

relay.accept("hello")
// 結果
//　next(initial value)
//　next(hello)



// 初期値を設定し出力
let relay2 = BehaviorRelay(value: [String]())

relay2.accept(["item 1"])

relay2.asObservable()
    .subscribe {
    print($0)
    }
// 結果
// next(["item 1"])




// 初期値は更新される
let relay3 = BehaviorRelay(value: ["item 1"])

relay3.accept(["item 2"])

relay3.asObservable()
    .subscribe {
    print($0)
    }
// 結果
// next(["item 2"])




let relay4 = BehaviorRelay(value: ["item 1"])

relay4.accept(relay4.value + ["item 2"])

relay4.asObservable()
    .subscribe {
    print($0)
    }
// 結果
// next(["item 1", "item 2"])



let relay5 = BehaviorRelay(value: ["item 1"])

var value = relay5.value
value.append("item 2")
value.append("item 3")

relay5.accept(value)

relay5.asObservable()
    .subscribe {
    print($0)
    }
// 結果
// next(["item 1", "item 2", "item 3"])
