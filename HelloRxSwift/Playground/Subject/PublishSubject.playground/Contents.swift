import UIKit
import RxSwift
import RxCocoa

let disposebag = DisposeBag()

let subject = PublishSubject<String>()

// subscribeされていないので実行時は何も起きない
subject.onNext("issue 1")

//subjectを購読する subscribe後に何も実行されていないのでこの時点では何も起きない
subject.subscribe { event in
    print(event)
}

//ここで初めて next(issue 2)　がプリントされる
subject.onNext("issue 2")
subject.onNext("issue 3")

// 結果
// next(issue 2)
// next(issue 3)


// disposeすると issue 4は表示されない
//　subject.dispose()
//　subject.onNext("issue 4")


subject.onCompleted()
// 結果
// next(issue 2)
// next(issue 3)
// completed


//　表示されない
subject.onNext("issue 4")
