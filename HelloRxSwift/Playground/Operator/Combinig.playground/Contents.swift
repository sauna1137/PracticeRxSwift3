import UIKit
import RxCocoa
import RxSwift

let disposebag = DisposeBag()



// starts with
// 先頭に指定した値を発行するイベントを付け加える
let numbers = Observable.of(2,3,4)

let observable = numbers.startWith(1)
observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposebag)  // 1 2 3 4




// concat
// 前の Observable が onCompleted してから次の Observable を subscribe します
let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)
let observable2 = Observable.concat([first,second])

observable2.subscribe(onNext: {
    print($0)
}).disposed(by: disposebag)  // 1 2 3 4 5 6




// merge
// 複数の Observable を subscribe して、全てのイベントを通知
let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(),right.asObservable())

//let observable3 = source.merge()
//observable3.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposebag)

left.onNext(5)
left.onNext(3)
right.onNext(2)
right.onNext(1)
left.onNext(99)    // 5 3 2 1 99


print("combine latest")


// combineLatest
// 複数の Observable の最新値同士を組み合わせ
let observable4 = Observable.combineLatest(left, right,resultSelector: { lastLeft,lastRight in
    "\(lastLeft) \(lastRight)"
})

let disposable = observable4.subscribe(onNext: { value in
    print(value)
})

left.onNext(2)
right.onNext(4)  // 2 4
left.onNext(10)  // 10 4
right.onNext(30) // 10 30
right.onNext(20) // 10 20
left.onNext(5)  // 5 20




// with latest from
// 元の Observable をトリガーにして指定した Observable の最新値を取得
let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable5 = button.withLatestFrom(textField)
let disposable5 = observable5.subscribe(onNext: {
    print($0)
})

textField.onNext("Sw")
button.onNext(())        // Sw
textField.onNext("Swif")
button.onNext(())        // Swif
textField.onNext("Swift")
textField.onNext("Swift !")
button.onNext(())       // Swift !




// reduce
// 第一引数から始まり、引数の全てを処理する
let source2 = Observable.of(1,2,3)
source2.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag) // 6

source2.reduce(0) { summary, newValue in
    return summary + newValue
}.subscribe(onNext: {
    print($0)
}).disposed(by: disposebag)  // 6




// scan
// reduce に似ていますが、途中経過もイベントとして発行,それまでの総和をイベントとして通知
let source3 = Observable.of(1,2,3,5,6)

source3.scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // 1 3 6 11 17
