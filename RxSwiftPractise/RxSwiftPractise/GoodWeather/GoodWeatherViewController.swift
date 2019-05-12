//
//  GoodWeatherViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GoodWeatherViewController: UIViewController {
  
  @IBOutlet weak var cityNameTextField: UITextField!
  @IBOutlet weak var tempuratureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //Subscribing on the textField Text(Control Property)
    
//    self.cityNameTextField.rx.value.subscribe(onNext: { city in
//      guard let city = self.cityNameTextField.text else { return }
//      if !city.isEmpty{
//        self.fetchWeather(city: city)
//      }
//    }).disposed(by: disposeBag)
    
    //Subscribing on textField Search Button
    
    self.cityNameTextField.rx
      .controlEvent(UIControlEvents.editingDidEndOnExit)
      .asObservable()
      .map{ self.cityNameTextField.text }
      .subscribe(onNext: { city in
      guard let city = city else { return }
        if !city.isEmpty {
          self.fetchWeather(city: city)
        }
    }).disposed(by: disposeBag)
  }
  
  private func displayWeather(_ weather: Weather?) {
    guard let weather = weather else {
      self.tempuratureLabel.text = ""
      self.humidityLabel.text = ""
      return
    }
    
    self.tempuratureLabel.text = "\(weather.temp) ℉"
    self.humidityLabel.text = "\(weather.humidity)"
  }

  private func fetchWeather(city: String) {
    guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
      let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&APPID=99ebe86a3610dfe4c47194ba28228781&units=imperial") else { return }
    let resource = Resource<WeatherResult>(url: url)
    
    //By Calling the function to display the Weather
    
//    URLRequest
//      .load(resource: resource)
//      .catchErrorJustReturn(WeatherResult.emptyResult)
//      .observeOn(MainScheduler.instance)
//      .subscribe(onNext: {  result in
//        let weather = result?.main
//        self.displayWeather(weather)
//    }).disposed(by: disposeBag)
    
    //Displaying the weather with rx binding
    
//    let search = URLRequest
//      .load(resource: resource)
//      .catchErrorJustReturn(WeatherResult.emptyResult)
//      .observeOn(MainScheduler.instance)
//
//    search
//      .map{ "\($0?.main.temp) ℉"}
//      .bind(to: self.tempuratureLabel.rx.text)
//      .disposed(by: disposeBag)
//
//    search
//      .map{"\($0?.main.humidity) %"}
//      .bind(to: self.humidityLabel.rx.text)
//      .disposed(by: disposeBag)
    
    //Displaying Weather by usring rx driver
    
//    let search = URLRequest.load(resource: resource)
//      .observeOn(MainScheduler.instance)
//      .asDriver(onErrorJustReturn: WeatherResult.emptyResult)
//
//    search.map{ "\($0?.main.temp) ℉"}
//      .drive(self.tempuratureLabel.rx.text)
//      .disposed(by: disposeBag)
//
//    search.map{ "\($0?.main.humidity) %"}
//      .drive(self.humidityLabel.rx.text)
//      .disposed(by: disposeBag)
    
    //Displaying Weather as rx driver by catching the error thrown by the api
    
    let search = URLRequest.load(resource: resource)
      .observeOn(MainScheduler.instance)
      .catchError { (error) -> Observable<WeatherResult?> in
        print("Error: \(error.localizedDescription)")
      return Observable.just(WeatherResult.emptyResult)
    }.asDriver(onErrorJustReturn: WeatherResult.emptyResult)
    
    search.map { "\($0?.main.temp ?? 0.0)" }
      .drive(self.tempuratureLabel.rx.text)
      .disposed(by: disposeBag)
    
    search.map { "\($0?.main.humidity ?? 0.0)" }
    .drive(self.humidityLabel.rx.text)
    .disposed(by: disposeBag)
  }
}
