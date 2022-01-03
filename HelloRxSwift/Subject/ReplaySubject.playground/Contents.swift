import UIKit
import RxSwift

let disposebag = DisposeBag()

// bufferSizeで最後からいくつの処理を対象とするか指定
let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("issue 1")
subject.onNext("issue 2")
subject.onNext("issue 3")

subject.subscribe {
    print($0)
}
//　結果
//　next(issue 2)
//　next(issue 3)


subject.onNext("issue 4")
subject.onNext("issue 5")
subject.onNext("issue 6")
// next(issue 4)
// next(issue 5)
// next(issue 6)

print("subject2")
subject.subscribe {
    print($0)
}
// 結果　サブスクライブしてからのsubjectから最後の2つの処理が実行される
//　subject2
//　next(issue 5)
//　next(issue 6)
