import UIKit
import RxSwift
import RxCocoa

let disposebag = DisposeBag()


//Rxでは　to という名前で、Observable を他のデータ構造へ変換する役割になっています。


// toArray
// onCompleted が発生するまでに流れてきたイベントを配列にして流す Observable に変換
Observable.of(1,2,3,4,5)
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    }).disposed(by: disposebag) // [1, 2, 3, 4, 5]




// map
// 各要素の内容を指定した処理で別の値や型に変換
Observable.of(1,2,3,4,5)
    .map {
        return $0 * 2
    }.subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)  // 2 4 6 8 10




// flatMap
// 元の Observable のイベントを Observable に変換した上で、その発行するイベントをマージ
struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()

student.asObservable()
    .flatMap { $0.score.asObservable()}
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)

student.onNext(john) // 75
john.score.accept(100) // 100

student.onNext(mary) // 95
mary.score.accept(80)  // 80



print("!!!!!!!!")

// flatMapLatest
//flatMapLatest と同じくイベントを Observable に変換し、常に１つの Observable のイベントしか通知しないのですが、次の Observable が来るとそちらにスイッチ
struct Student2 {
    var score: BehaviorRelay<Int>
}

let john2 = Student(score: BehaviorRelay(value: 75))
let mary2 = Student(score: BehaviorRelay(value: 95))

let student2 = PublishSubject<Student>()

student2.asObservable()
    .flatMapLatest { $0.score.asObservable()}
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposebag)

student2.onNext(john2)  // 75
john2.score.accept(100) //100
student2.onNext(mary2)
john2.score.accept(45) // 95
mary2.score.accept(50) //50
