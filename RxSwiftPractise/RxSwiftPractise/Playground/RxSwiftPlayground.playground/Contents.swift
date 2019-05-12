import UIKit
import RxSwift
import RxCocoa

/*
 RxSwift in its essence simplifies developing asyncronus program by allowing your code to read to new data and process is as sequential, isolated manner
 
 A observable or sequence is the heart of RxSwift which emits values like integer, string etc.
 For example the slider.  we can subscribe to the slider and whenever the value of the slider is chaged we can get the updated value.
 
 Scrolling the table view is an event
 Clicking the button is an event
 Changing the segment tab is an event
 
 Subject is a observable and also a observer. Subject get the event from someone and forward the result to their subsribers
 Types of subject
 - PublishSubject : Starts empty and only emits new elements to the subscriber
 
 - BehaviourSubject : Starts with a initial value and replays it or the latest element to the new subcriber
 
 - ReplaySubject : Initialized with the buffer size and will maintain a buffer of elements up to the size and replay it to the new subscriber
 
 - BehaviourRelay(Variable)
 
 */

let disposeBag = DisposeBag()

print("Observable")
Observable.of("A", "B", "C")
  .subscribe {
    print($0)
}.disposed(by: disposeBag)

Observable.from(["Apple", "Ball", "Cat", "Dog"])
  .subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("==================================")

// Creating the custom Observables
print("Custom Observable")
Observable<String>.create { observable in
  observable.onNext("A")
  observable.onNext("B")
  observable.onCompleted()
  observable.onNext("?")
  return Disposables.create()
}
  .subscribe(onNext: { print($0) },
             onError: { print($0) },
             onCompleted: { print("on Completed") },
             onDisposed: { print("on Disposed") })
.disposed(by: disposeBag)
print("==================================")

//Publish Subjects
print("Publish Subjects")
let subject = PublishSubject<String>()
subject.onNext("Issue 1")
subject.subscribe({
  print($0)
})
subject.onNext("Issue 2")
subject.onNext("Issue 3")
subject.dispose()
subject.onCompleted()
subject.onNext("Issue 4")
print("==================================")

// Behaviour Subject
print("Behaviour Subjects")
let subject1 = BehaviorSubject(value: "Initial Value")
subject1.onNext("Last Value")
subject1.subscribe({
  print($0)
})
subject1.onNext("Issue 1")
print("==================================")

// Replay Subjects
print("Replay Subject")
let subject2 = ReplaySubject<String>.create(bufferSize: 2)

print("Subsciption 1")
subject2.onNext("Issue 1")
subject2.onNext("Issue 2")
subject2.onNext("Issue 3")
subject2.subscribe({
  print($0)
})

subject2.onNext("Issue 4")
subject2.onNext("Issue 5")
subject2.onNext("Issue 6")

print("Subscription 2")
subject2.subscribe({
  print($0)
})
print("==================================")

// Behaviour Relay
print("BehaviourRelay")
let relay = BehaviorRelay(value: ["Item 0"])
relay.accept(relay.value + ["Item 1","Item + 2", "Item 3"])
relay.asObservable().subscribe({
  print($0)
})
