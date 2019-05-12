import UIKit
import RxSwift
import RxCocoa

/*
 toArray : Convert the elements into the array of elements.
 
 Map : The map operator applies a function of your choosing ot each item emited by the observer and return the observer that emits the result of thees funcion.
 
 Flatmap: THe flatmap operator transforms an Observable by applying a function that you specify it each item emitted by the source Observable, where that function returns an Observable that itself emits items.
 
 Flat Map Latest: The flatmap latest only obserbs the latest value and ignores all the changes made to the items.
 */

let disposeBag = DisposeBag()

//toArray
print("To Array :")
Observable.of(1,2,3,4,5)
.toArray()
  .subscribe(onNext : {
    print($0)
  }).disposed(by: disposeBag)
print("=========================")

//Map
print("Map :")
Observable.of(2,3,4)
  .map{ $0 * 2}
  .subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)
print("=========================")

//Flat Map
print("Flat Map")
struct Student {
  var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 98))

let students = PublishSubject<Student>()
students.asObservable()
  .flatMap{ $0.score.asObservable() }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

students.onNext(john)
john.score.accept(94)
students.onNext(mary)
mary.score.accept(99)
john.score.accept(77)
print("=========================")

//FlatMapLatest
print("Flat Map Latest")

let amy = Student(score: BehaviorRelay(value: 43))
let sheldon = Student(score: BehaviorRelay(value: 65))

let students2 = PublishSubject<Student>()
students2.asObservable()
  .flatMapLatest{ $0.score.asObservable() }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)
students2.onNext(amy)
amy.score.accept(11)
students2.onNext(sheldon)
amy.score.accept(77)
print("=========================")
