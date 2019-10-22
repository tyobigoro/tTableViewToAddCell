//
//  ViewController.swift
//  tTableViewToAddCell
//
//  Created by tyobigoro_i on 2019/10/22.
//  Copyright © 2019 tyobigoro_i. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tTableView: UITableView!
    
    var array: [Int] = [1, 2, 3, 4, 5, 6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tTableView.tableFooterView = UIView(frame: .zero)
        tTableView.estimatedRowHeight = 40
    }
    
    
    @IBAction func scroll(_ sender: Any) {
        
        //let offsetY: CGFloat = 40.0
        //tTableView.contentOffset.y += offsetY
        
        let offsetY = tTableView.contentOffset.y
        
        let offset = CGPoint(x: 0.0, y: offsetY + 40)
        tTableView.setContentOffset(offset, animated: true)
        
        
    }
    
    // セルを追加する（必要があればtableViewをスクロールする）
    @IBAction func addCellBtnDidTap() {
        
        
        
        // 追加するセルの直上のセルのインデックスパスを取得
        let lastCellIndexPath = IndexPath(row: array.count - 1, section: 0)
        // データ追加
        array.append(array.count + 1)
        // 追加したセルのインデックスパスを取得
        let addCellIndexPath = IndexPath(row: array.count - 1, section: 0)
        // 追加するセルの直上のセルのMaxYをself.view系に変換して取得
        let lastCellMaxY
            = tTableView.convert(tTableView.rectForRow(at: lastCellIndexPath), to:self.view).maxY
        // tableViewのmaxYを取得
        let tTableViewMaxY = tTableView.frame.maxY
        
        // addCellを挿入するスペースがない場合の処理
        if lastCellMaxY + 40 > tTableViewMaxY {
        
            // スクロール量を求める
            let offsetY: CGFloat = (lastCellMaxY + 40) - tTableViewMaxY + 0.5
        
            //let offsetY = tTableView.contentOffset.y
                   
            //let offset = CGPoint(x: 0.0, y: offsetY + 40)
            
            
            print("------------------------------------------------")
            print("### offsetY:", offsetY)
            print("### before tTableView.contentOffset.y:", tTableView.contentOffset.y)
            
            //// スクロール完了後にセルを追加する
            UIView.animate(withDuration: 0.6, animations: {
                self.tTableView.contentOffset.y += offsetY
                //self.tTableView.setContentOffset(offset, animated: false)
            }){(finished) in
                print("### after tTableView.contentOffset.y:", self.tTableView.contentOffset.y)
                self.tTableView.insertRows(at: [addCellIndexPath], with: .right)
                
            }
        // addCellを挿入するスペースがある場合の処理
        } else {
            // セルを追加する
            tTableView.insertRows(at: [addCellIndexPath], with: .right)
        }
    }
    
    // numOfCell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    // generateCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(array[indexPath.row])
        return cell
    }
    
    // heightForCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
