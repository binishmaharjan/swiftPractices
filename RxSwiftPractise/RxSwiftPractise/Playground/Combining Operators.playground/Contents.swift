import UIKit
import RxSwift
import RxCocoa

/*
 - StartsWith: If you wanto an Observable to emit a specific sequence of items before it begin emitting the items normally expected from it, apply the StartWith operator to it.
 

 - Concat: The Concat operator concatenates the optput of mutliple Observables so that they act like a single Observable, with all of the items emitted by the first Observable being emitted before any of the items emitted by the second Observable

 - Merge: You can combine the output of multiple Observable so that they act like a single Observable, by the using the Merge operator.
 
 Merge interleave the items emitted by the merged Observable where as concat doesnot interleave the items, but emits all of each source Observable items in turn before beginnig to emit items from the next source Observable
 
 - CombineLatest: CombineLatest emits an item whenever any of the source Observables emits an item (so long as each of the ource Observable has emitted at least one item).
 
 - WithLatestFrom: The operator merge two observable sequencecs into one observable sequence by combining each element from self with latest item from the second source.

 - Reduce: The reduce operator applies a function to the first item emitted by the source Observable and then feeds the result of the function back into the function along with the second item emitted by the source Observable, continuing this process until the source Observable emits its final item and completes, whereupon the observable returned from Reduce emits the final value returned from the function.

 - Scan: The Scan Operator applies a function to the first items emitted by the source Observable and then emits the result of that function as its own first emission. It also feed the result of the function back into the function along with the second item emitted by the source Observable in order to generate its second emission.
 */

let disposeBag = DisposeBag()

print(10,20,30)
//StartsWith
print("Starts With : ")
let numbers = Observable.of(1,2,3)
let observable = numbers.startWith(0)
  observable.subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("=============================")

//Concat
print("Concat : ")
let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)
let concat = Observable.concat([first,second])
concat.subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("=============================")

//Merge
print("Merge")
let left = PublishSubject<Int>()
let right = PublishSubject<Int>()
let merge = Observable.merge([left,right])
merge.subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

left.onNext(4)
left.onNext(2)
right.onNext(6)
left.onNext(1)
print("=============================")

//Combine Latest
print("Combine Latest : ")
let left1 = PublishSubject<Int>()
let right1 = PublishSubject<Int>()
let combineLatest = Observable.combineLatest(left1,right1, resultSelector: { lastLeft, lastRight in
  ("\(lastLeft)-\(lastRight)")
})
combineLatest.subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

left1.onNext(45)
right1.onNext(1)
left1.onNext(30)
right1.onNext(2)
right1.onNext(3)
print("=============================")

//WithLatestFrom
print("With Latest From")
let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let withLatest = button.withLatestFrom(textField)
withLatest.subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

textField.onNext("A")
textField.onNext("Ap")
textField.onNext("App")
button.onNext(())

textField.onNext("Appl")
textField.onNext("Apple")
button.onNext(())
print("=============================")

//Reduce
print("Reduce")
let reduce = Observable.of(1,2,3)
reduce.reduce(0, accumulator: +
  ).subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

reduce.reduce(0) { (summary, newValue) in
  return summary + newValue
  }.subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)
print("=============================")

//Scan
print("Scan")
let scan = Observable.of(1,2,3,4,5)
scan.scan(0, accumulator: +)
  .subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("=============================")
