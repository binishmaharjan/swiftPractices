//
//  ThirdViewController.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/25.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
  
  private let thirdView = ThirdView.loadXib()
  let items = [
    ThirdModal(name: "うずまきナルト", description: "なお、中忍試験の時期に自来也について里を出ていたため、同期の中で一人だけ下忍で結局試験を受けずに下忍のまま火影になった事を明かしている（帰郷直後以外は誰も気にしなかったが）。", image: "image_2"),
    ThirdModal(name: "金木", description: "そして気を引くためとはいえ、歴代火影の顔岩に落書きする、老人の盆栽を壊すなどの様々な悪戯がナルトの冷遇ぶりに拍車をかけた(ヒルゼン曰く、どのような形であれ自分の存在を認めてほしかった。)", image: "image_1"),
    ThirdModal(name: "ナツ", description: "父は里最高クラスの忍者、母は強力なチャクラと封印術に長けた人柱力、と血統だけ見れば結構なサラブレッドなのだが、ナルト当人の基本能力で秀でているのはチャクラ量と適応力くらい。これを自来也言うところの「諦めねェド根性」と忍道を貫く努力で引っくり返して強くなって来た。", image: "image_3")
    
  ]
  
  override func loadView() {
    self.view = thirdView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableView()
  }
  
  private func setupTableView() {
    thirdView.tableView.delegate = self
    thirdView.tableView.dataSource = self
    thirdView.tableView.estimatedRowHeight = 100
    thirdView.tableView.rowHeight = UITableView.automaticDimension
    thirdView.tableView.register(ThirdCell.loadNib(), forCellReuseIdentifier: ThirdCell.xibName)
  }
  
}

extension ThirdViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdCell.xibName, for: indexPath)  as? ThirdCell else {
      preconditionFailure("No proper Cell")
    }
    let charc = items[indexPath.row]
    cell.titleLabel.text = charc.name
    cell.descriptionLabel.text = charc.description
    cell.profileImage.image = UIImage(named: "\(charc.image)")
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = HeaderView.loadXib()
    return headerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = HeaderView.loadXib()
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 100
  }
}
