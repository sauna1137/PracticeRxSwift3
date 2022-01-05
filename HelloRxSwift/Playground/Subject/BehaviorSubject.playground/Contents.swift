import UIKit
import RxSwift

let disposebag = DisposeBag()

let subject = BehaviorSubject(value: "initial value")

//　初めから処理を持つsubject
subject.subscribe { event in
    print(event)
}
// 結果
// next(initial value)


print(2)

// valueは書き換えられる
let subject2 = BehaviorSubject(value: "initial value2")

subject2.onNext("last value")

subject2.subscribe { event in
    print(event)
}
// 結果
// next(last value)

print(3)

let subject3 = BehaviorSubject(value: "initial value3")
subject3.onNext("last value")

subject3.subscribe { event in
    print(event)
}
subject.onNext("issue 1")
// 結果
// next(last value)
// next(issue 1)
