//
//  AlarmsViewController.swift
//  timesup
//
//  Created by Tim Harris on 2/7/18.
//  Copyright © 2018 Tim Harris. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("New Alarm", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        return button
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        return button
    }()
    
    let blurView: UIVisualEffectView = {
        let BlurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: BlurEffect)
        return view
    }()
    
    var lowerStack: UIStackView!
    
    
    
    var alarms: Array<Alarm> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .lightGray
        collectionView?.register(AlarmCellView.self, forCellWithReuseIdentifier: "AlarmCell")
        
        collectionView?.contentInset = UIEdgeInsetsMake(16, 0, 80, 0)
        
        
        collectionView?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.leadingAnchor.constraint(equalTo: (collectionView?.safeAreaLayoutGuide.leadingAnchor)!, constant: 0).isActive = true
        blurView.trailingAnchor.constraint(equalTo: (collectionView?.safeAreaLayoutGuide.trailingAnchor)!, constant: 0).isActive = true
        blurView.bottomAnchor.constraint(equalTo: (collectionView?.safeAreaLayoutGuide.bottomAnchor)!, constant: 0).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        blurView.contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10).isActive = true
        addButton.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
      
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alarms.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 100)
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let newCell = cell as! AlarmCellView
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
         //newCell.translatesAutoresizingMaskIntoConstraints = false
        /*
        if alarms.count > 1 {
            // New cell added. Get previous cells constainsts.
           newCell.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 0 ).isActive = true
            newCell.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 10).isActive = true
            newCell.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 0).isActive = true
            newCell.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            let oldIndex = IndexPath(item: 1, section: 0)
            let lastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmCell", for: oldIndex)
            
            lastCell.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 0 ).isActive = true
            lastCell.topAnchor.constraint(equalTo: newCell.bottomAnchor, constant: 10).isActive = true
            lastCell.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 0).isActive = true
            lastCell.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            
        } else {
            // First cell added
            newCell.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 0 ).isActive = true
            newCell.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 10).isActive = true
            newCell.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 0).isActive = true
            newCell.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
        }
        
       */
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.superview?.bringSubview(toFront: cell!)
        blurView.superview?.bringSubview(toFront: blurView)
        addButton.removeFromSuperview()
        lowerStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        blurView.contentView.addSubview(lowerStack)
        lowerStack.translatesAutoresizingMaskIntoConstraints = false
        lowerStack.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10).isActive = true
        lowerStack.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10).isActive = true
        lowerStack.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10).isActive = true
        lowerStack.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leadingAnchor.constraint(equalTo: lowerStack.leadingAnchor, constant: 0).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: blurView.contentView.frame.width/3).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: lowerStack.bottomAnchor, constant: -10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.leftAnchor.constraint(equalTo: cancelButton.rightAnchor, constant: 10).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: lowerStack.trailingAnchor, constant: -10).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 0).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        UIView.animate(withDuration: 0.7, animations: {
            collectionView.isScrollEnabled = false
            cell?.backgroundColor = .white
            cell?.translatesAutoresizingMaskIntoConstraints = false
            cell?.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
            cell?.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
            cell?.widthAnchor.constraint(equalToConstant: collectionView.bounds.width).isActive = true
            cell?.heightAnchor.constraint(equalToConstant: collectionView.bounds.height).isActive = true
        }, completion: nil)
        //cell?.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    
    @objc func handleAdd() -> Void {
        let newAlarm  = Alarm()
        alarms.insert(newAlarm, at: 0)
        let newIndexPath = IndexPath(item: 0, section: 0)
        collectionView?.insertItems(at: [newIndexPath])
        
        /*
        let testNotification = UNMutableNotificationContent()
        testNotification.title = "Alarm"
        testNotification.body = "It's 7:30"
        testNotification.sound = UNNotificationSound.default()
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "alarmNotification", content: testNotification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
        */
        //collectionView?.reloadData()
        
    }
    
}

enum viewState {
    case creation
    case normal
    case edit
}

class AlarmCellView: UICollectionViewCell {
    
    var state:viewState = .creation
    
    
    let alarmLabel:UILabel = {
        let label = UILabel()
        label.text = "Alarm"
        label.textColor = .black
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.text = "7:30 AM"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    let tapGesture = UITapGestureRecognizer()
    let swipeGesture = UISwipeGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowOpacity = 1.0
        
        addSubview(alarmLabel)
        alarmLabel.translatesAutoresizingMaskIntoConstraints = false
        alarmLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        alarmLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        alarmLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        alarmLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        swipeGesture.addTarget(self, action: #selector(tapCell))
        swipeGesture.direction = .left
        addGestureRecognizer(swipeGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapCell(){
        print("tapped")
        self.backgroundColor = .green
        //let currentSize = frame.size
        //frame.size = CGSize(width: currentSize.width, height: 400)
    }
    
}
