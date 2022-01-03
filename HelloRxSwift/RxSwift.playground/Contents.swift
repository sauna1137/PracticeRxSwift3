import UIKit
import RxSwift
import RxCocoa

// 観測可能なelementをプロパティに

// [just] Returns an observable sequence that contains a single element.
let observable = Observable.just(1)


// [of]  This method creates a new Observable instance with a variable number of elements.
let observable2 = Observable.of(1,2,3)


// Observable<[Int]>型
let observable3 = Observable.of([1,2,3])


// Converts an array to an observable sequence.
let observable4 = Observable.from([1,2,3,4,5])



// 観測するプロパティに購読、subscribeを追加
observable4.subscribe { event in
    print(event)
}
// 結果：　　from は配列から一つ一つ取り出される
// next(1)
// next(2)
// next(3)
// next(4)
// next(5)
// completed


// observable3で行う
observable3.subscribe { event in
    print(event)
}
// 結果    of　は配列全体が取り出される
// next([1, 2, 3])
// completed


// subscribeしeventからelementを取り出す
observable4.subscribe { event in
    if let element = event.element {
        print(element)
    }
}
// 結果:
// 1
// 2
// 3
// 4
// 5


// onNextでelementをアンラップせずに取り出せる
observable4.subscribe(onNext: { element in
    print(element)
})
// 結果:
// 1
// 2
// 3
// 4
// 5


// 購読を終了するもの
let disposeBag = DisposeBag()

Observable.of("a","b","c")
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)
//結果
// next(a)
// next(b)
// next(c)
// completed



// ファンクションを実際に作成することもできる
Observable<String>.create { observer in

    observer.onNext("A")
    observer.onCompleted() // 完了
    observer.onNext("?") // 完了の後は呼ばれない
    return Disposables.create() // 処理の破棄
}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("completed")}, onDisposed: {print("Disposed")})

// 結果
// A
// completed
// Disposed
