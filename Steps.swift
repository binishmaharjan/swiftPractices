final class Steps: CustomDebugStringConvertible {
  let name: String
  init(name: String) {
    self.name = name
  }
  
  private struct Item {
    var label: String
    var block: ((Steps) -> Void)
  }
  private var items: [Item] = [Item]()
  private var labels = Set<String>()
  private var current: Int = -1
  
  var debugDescription: String {
    return "Steps.name = \(name), current = \(current), items.count=\(items.count), items=\(items.map { $0.label }.joined(separator: ", "))"
  }
  
  // MARK: Add Entry
  @discardableResult
  func label(_ label: String = "", handler: @escaping (Steps) -> Void) -> Steps {
    items.append(Item(label: label, block: handler))
    
    if label.contains(label) {
      print("Steps(\(name)) is duplicated. This will be ignored")
    } else {
      labels.insert(label)
    }
    
    return self
  }
  
  // MARK: Execute
  private func next(index: Int) {
    current = index
    if let item = items[optional: current] {
      print("Steps(\(name)) => label(\(item.label))")
      item.block(self)
    } else {
      print("Steps(\(name)) => index(\(current)) is out of range!")
    }
  }
  
  func next() {
    next(index: current + 1)
  }
  
  func next(to label: String) {
    items.enumerated().forEach { (index, item) in
      if item.label == label {
        next(index: index)
      }
    }
  }
  
  func join(_ finalLabel: String = "end_of_steps!") {
    label(finalLabel) { _ in }.next()
  }
}

extension Array {
  
  /*
   安全な配列アクセスを提供する
   indexが範囲外の時、setterは無視し、getterはnilをか返す
   */
  subscript(optional index: Int) -> Element? {
    get {
      guard self.indices ~= index else {
        return nil
      }
      return self[index]
    }
    
    set {
      guard self.indices ~= index else {
        print("WARN: index(\(index)) is out of range, so ignored. (array: \(self)")
        return
      }
      
      guard let newValue = newValue else {
        print("WARN: new Value must not be nil value, so ignored. (array: \(self)")
        return
      }
      
      self[index] = newValue
    }
  }
  
  /*
   重複を取り除いた配列に変換する
   内部でNSOrderedSetを使うので元の配列の順序になることが保証される
   */
  func unique() -> [Element] {
    let orderSet = NSOrderedSet(array: self)
    return orderSet.array.compactMap { $0 as? Element }
  }
}


// Usage
class ViewController: UIViewController {

  @IBOutlet weak var simpleButton: UIButton!
  
  var data: [AlertData] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    simpleButton.addTarget(self, action: #selector(simpleButtonPressed), for: .touchUpInside)
  }
  
  @objc private func simpleButtonPressed() {
    data = [
      AlertData(title: "First", message: "First Message"),
      AlertData(title: "Second", message: "Second Message"),
      AlertData(title: "Third", message: "Third Message"),
    ]
    
    Steps(name: "DisplayAlert")
      .label("Display") { (step) in
        
        if self.data.isEmpty{
          step.next()
          return
        }
        
        let currentAlert = self.data.removeFirst()
        let currentAlertViewController = self.makeAlert(data: currentAlert) { (_) in
          step.next(to: "Display")
        }
        
        self.present(currentAlertViewController, animated: true)
        
    }.join()
  }
  
  private func makeAlert(data: AlertData, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
    let alert = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
    alert.addAction(cancelAction)
    alert.addAction(okAction)
    return alert
  }


// Api Call
self.isShowHud = true
Steps(name: "Show Station Information")
  .label("station Detail") { step in
    appModel.updateScenrio.updateForStationDetail() { error in
      error.append(error)
      step.next()
    }
}
  .label("station Departures") { step in
    appModel.updateScenrio.updateForStationDepartures() { error in
      error.append(error)
      step.next()
    }
}
  .label("Show") { step in
    self.showHud = false
    handler(true)
}.join()
}

struct AlertData {
  let title: String
  let message: String
}

