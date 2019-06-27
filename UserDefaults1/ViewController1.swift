//
//  ViewController1.swift
//  UserDefaults1
//
//  Created by 関口大海 on 2019/06/26.
//  Copyright © 2019 関口大海. All rights reserved.
//

import UIKit

class ViewController1: UITableViewController {
    
    
    // セルに表示する項目を格納
    var itemArray = ["本を読む", "映画見る", "夕飯を買う"]
    
    // UserDefaultsの初期化
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        
//         UD内のデータをitemArrayに反映（UD内にデータがなかった場合にクラッシュしないように条件分岐で守る）
        if let items = defaults.array(forKey: "items") as? [String] {
            itemArray = items
        }
        
    }
    
    
    // ☆☆☆追加ボタン（アラートシステム）☆☆☆ //
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        // アラートシステムの宣言
        let alert = UIAlertController(title: "新規項目の追加", message: "", preferredStyle: .alert)
        
        // スコープを共通化して流用するためのTextField
        var textField = UITextField()
        
        // アラートにTextFieldを追加
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新規項目を追加してください"
            textField = alertTextField
        }
        
        // アラートシステムの中で青文字でボタンとして押せる部分の設定
        let action = UIAlertAction(title: "追加", style: .default) { (action) in
            // 「追加」ボタンを押した時の処理
            self.itemArray.append(textField.text!)
            
            // itemArrayをUserDefaultsに保存
            self.defaults.set(self.itemArray, forKey: "items")
            
            // TableViewのリロード
            self.tableView.reloadData()
        }
        
        // アラートにボタン（Action）を追加
        alert.addAction(action)
        
        // 表示
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // ☆☆☆以下、TableViewについての設定☆☆☆ //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップしたセルを離した後に非選択に戻す
        tableView.deselectRow(at: indexPath, animated: true)
        
        // タップしたセルのチェックを付けたり外したりする
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }

}
