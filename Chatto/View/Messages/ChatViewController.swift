//
//  ChatViewController.swift
//  Chatto
//
//  Created by User on 2/20/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import UIKit
import MaterialComponents
import RxSwift

class ChatViewController: UIViewController {
    @IBOutlet weak var buttonCamera: UIButton!
    @IBOutlet weak var imageCamera: UIImageView!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var imageSend: UIImageView!
    @IBOutlet weak var texBoxtHeight: NSLayoutConstraint!
    @IBOutlet weak var constrainTextView: NSLayoutConstraint!
    @IBOutlet weak var textMessage: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSend: UIView!
    
    
    var friendId :String = ""
    var chId :String = ""
    let viewModel = MessageViewModel()
    let disposeBag = DisposeBag()
    let dataSource = PublishSubject<[Message]>()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSend.isEnabled = false
        tableView.registerNib(identifier: "ChatSendTableViewCell")
        tableView.registerNib(identifier: "ChatReceiveTableViewCell")
        setupBindings()
        signSendPressed()
        self.viewModel.getChannelId(freindId: self.friendId )

    }
    
    func signSendPressed(){
        buttonSend.rx.tap
            .`do`(onNext:  { [unowned self] in
                self.textMessage.resignFirstResponder()
            }).subscribe(onNext: { [unowned self] in
                let msg = self.textMessage.text ?? ""
                let memberId = UserDefaults.standard.userID
                let timeStamp = Date().shortDateTime
                let messageDic = ["msg":msg,"first_member":memberId,"second_member":self.friendId
                    ,"timeStamp":timeStamp]
                self.viewModel.sendMEssage(message: messageDic as [String : Any], channelID: self.viewModel.channelId)
            }).disposed(by: disposeBag)
    }
    func setupBindings() {
        viewModel.changeChannelIdClousre = { [weak self] () in
            DispatchQueue.main.async {
                self?.buttonSend.isEnabled = true
            }
        }
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

        viewModel
            .isSendSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in
              // self?.tableView.scrollToBottom()
               self?.textMessage.text = ""
            }).disposed(by: disposeBag)
        
        dataSource.asObservable()
            .bind(to: tableView.rx.items) { (tableView, row, message) in
                let indexPath = IndexPath(row: row, section: 0)
                if message.first_member == UserDefaults.standard.userID{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatSendTableViewCell", for: indexPath) as! ChatSendTableViewCell
                     cell.msgCell = message
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatReceiveTableViewCell", for: indexPath) as! ChatReceiveTableViewCell
                     cell.msgCell = message
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.subscribe(onNext: ({ (cell,indexPath) in
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            },completion: nil)
        })).disposed(by: disposeBag)
    }

}
extension UITableView {
    
    func scrollToBottom(){
        DispatchQueue.main.async {
                let indexPath = IndexPath(
                    row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                    section: self.numberOfSections - 1)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
         
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
