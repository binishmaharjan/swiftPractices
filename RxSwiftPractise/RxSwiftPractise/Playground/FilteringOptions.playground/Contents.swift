import UIKit
import RxSwift
import RxCocoa

/*
 IgnoreFilter : The ignoreElements suppresses all of the items emitted by the source Observable, but allows its termination notification( onError or onCompleted ) to pass through unchanged.
 
 ElementAt: The ElementAt operator pulls an item located at specific index location at sequence of item emitted by the source Observable and emits that items as its own sole emission.
 
 Filter: The Filter operates filters an Observables by only allowing items through that pass a test that you specify in the form of a predicate function.
 
 Skip: Its skips the first n items emitted by the observable and attend only to those items that comes after, by modifiny the observable.
 
 Skip While: Skips until the condition is staisfied, once condition is unsatified it emits all the values after that ingnoring the skip condition.
 
 Skip Until: Skip Until waits for a trigger and emits all the item after it is triggred.
 
 Take: Take emits only the first n number of items emitted by an Observable and then completes while ignoring the rest of reminder.
 
 Take While: Take While emits the item until the consition is met, once the condition is not met it stops emitting the items even if there are other item that match the condition down the road.
 */

let disposeBag = DisposeBag()
//Ignore
print("Ignore : ")

let strikes = PublishSubject<String>()
strikes
  .ignoreElements()
  .subscribe{ _ in
  print("Subsciption Is Called")
}.disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onCompleted()
print("==========================")

//Element At
print("Element At : ")

let strikes2 = PublishSubject<String>()
strikes2
  .elementAt(2)
  .subscribe(onNext: { _ in
  print("You are out!")
}).disposed(by: disposeBag)
strikes2.onNext("X")
strikes2.onNext("X")
strikes2.onNext("X")
print("==========================")

//Filter
print("Filter :")

Observable.of(1,2,3,4,5,6,7,8)
  .filter{ $0 % 2 == 0}
  .subscribe(onNext : {
    print($0)
  }).disposed(by: disposeBag)
print("==========================")

//Skip
print("Skip :")

Observable.of("A","B","C","D","E","F","G","H")
.skip(5)
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)
print("==========================")

//Skip While
print("Skip WHile :")
Observable.of(2,2,3,4,4)
  .skipWhile{$0 % 2 == 0}
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)
print("==========================")

//Skip Until
print("Skip Unit")
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()
subject
  .skipUntil(trigger)
  .subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
subject.onNext("A")
subject.onNext("B")
trigger.onNext("X")
subject.onNext("C")
print("==========================")


//Take
print("Take :")
Observable.of(1,2,3,4,5,6)
  .take(3)
  .subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("==========================")


//Take While
print("Take While :")
Observable.of(2,4,6,7,8,10)
  .takeWhile{ $0 % 2 == 0 }
  .subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("==========================")

//Take Until
print("Take Until")
let subject2 = PublishSubject<String>()
let trigger2 = PublishSubject<String>()
subject2.takeUntil(trigger2).subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

subject2.onNext("A")
subject2.onNext("B")
trigger2.onNext("X")
subject2.onNext("C")
print("==========================")
