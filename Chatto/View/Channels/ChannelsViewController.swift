//
//  MessagesTableViewController.swift
//  Chatto
//
//  Created by User on 2/17/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

class ChannelsViewController: UITableViewController {
    @IBOutlet weak var signOut: UIBarButtonItem!

    let viewModel = ChannelsListViewModel()
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    let dataSource = PublishSubject<[Channel]>()
    var friendId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        setupBindings()
        viewModel.observeChannels()
        tableView.registerNib(identifier: "ChannelList")
         self.clearsSelectionOnViewWillAppear = true

        signOutPressed()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    func signOutPressed(){
        signOut.rx.tap
            .`do`(onNext:  { [unowned self] in
            }).subscribe(onNext: { [unowned self] in
                self.loginViewModel.signOut()
            }).disposed(by: disposeBag)
    }
    func signOutCallBack(){
        loginViewModel.isLoading
        .bind(to: rx.isAnimating)
        .disposed(by: disposeBag)
        
        loginViewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in                self?.performSegue(withIdentifier: "signIn", sender: nil)
            }).disposed(by: disposeBag)
        loginViewModel
            .isError
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "chatRoom"
        {
            let ChatVC = segue.destination as? ChatViewController
            ChatVC?.friendId = self.friendId
        }
    }
    func setupBindings() {
        
        viewModel.isLoading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel
            .isError
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
        
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
            dataSource.asObservable().subscribe(onNext: {[weak self]
            updatedArray in
            if updatedArray.count > 0 {
//                self?.lblNoNotificaton.isHidden = true
            } else {
//                self?.lblNoNotificaton.isHidden = false
            }
        })
        .disposed(by: disposeBag)
        
        dataSource.bind(to: self.tableView.rx.items(cellIdentifier: "ChannelList", cellType: ChannelList.self)) {  (row,channel,cell) in
            cell.cellChannel = channel
            }.disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.subscribe(onNext: ({ (cell,indexPath) in
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            },completion: nil)
        })).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Channel.self)
            .subscribe(onNext: { [weak self] item in
                // other actions with Item object
                //self?.viewModel.getChannelId(freindId: item.userId ?? "")
                self?.friendId = item.userId ?? ""
                self?.performSegue(withIdentifier: "chatRoom", sender: nil)

                
            }).disposed(by: disposeBag)
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageListCell", for: indexPath) as! MessageListCell
//        cell.lblActiveAgo.text = "5 min"
//
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "map", sender: self)
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
