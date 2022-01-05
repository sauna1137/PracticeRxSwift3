import UIKit
import RxSwift
import PlaygroundSupport

let disposebag = DisposeBag()


// .ignoreElements()
// 全てのイベントを無視して完了やエラーのみ通知 conmpletedされたときにsubscribe内の処理が行われる
let strikes = PublishSubject<String>()

strikes
    .ignoreElements()
    .subscribe { _ in
        print("[Subscription is called]")
    }.disposed(by: disposebag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onCompleted()  // [Subscription is called]





// .element(at: 2)
// 指定インデックス番号のイベントを通知して完了 指定するインデックス回目の処理でsubscribe内の処理を行う
let strikes2 = PublishSubject<String>()

strikes2.element(at: 2)
    .subscribe(onNext: { _ in
        print("You are out")
    }).disposed(by: disposebag)

strikes2.onNext("x")
strikes2.onNext("y")
strikes2.onNext("z")  // You are out





// .filter {}
// 指定条件に合致するものだけ通過 一致するもののみsubscribeで処理を行う
Observable.of(1,2,3,4,5,6,7)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // 2 4 6





// .skip()
// スキップでindex番目から処理を行う
Observable.of("A","B","C","D","E","F")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // D E F





// .skip(while: {})
// 先頭から指定条件に合致している間だけイベントをスキップ
Observable.of(2,2,3,4,4)
    .skip(while: { $0 % 2 == 0 })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // 3 4 4




// skip until
//指定した Observable が onNext を発行するまで、元の Observable が発行したイベントを無視
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.skip(until: trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)

subject.onNext("A")
subject.onNext("B")
trigger.onNext("X")   // trggerでonNextを読み込むようにする
subject.onNext("C")   // C





// take()
// 先頭から指定時間の間のイベントだけ通知して完了
Observable.of(1,2,3,4,5,6)
    .take(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // 1 2 3





// takeWhile
// 先頭から指定条件に合致している間だけイベントを通知
Observable.of(2,4,6,7,8,10)
    .take(while: { return $0 % 2 == 0 })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // 2 4 6





// takeUntil
// 指定した Observable が何かイベントを発行すると終了
let subject2 = PublishSubject<String>()
let trigger2 = PublishSubject<String>()

subject2.take(until: trigger2)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)

subject2.onNext("1")
subject2.onNext("2")   // 1 2
trigger2.onNext("A")   // trigger発火
subject2.onNext("3")   // 無視される
