//
//  AlarmsViewController.swift
//  timesup
//
//  Created by Tim Harris on 2/7/18.
//  Copyright © 2018 Tim Harris. All rights reserved.
//

import UIKit

class AlarmsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Add Alarm", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    
    var alarms: Array<Alarm> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .lightGray
        collectionView?.register(AlarmCellView.self, forCellWithReuseIdentifier: "AlarmCell")
        
        collectionView?.contentInset = UIEdgeInsetsMake(16, 0, 80, 0)
        collectionView?.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: (collectionView?.safeAreaLayoutGuide.leadingAnchor)!, constant: 10).isActive = true
        addButton.trailingAnchor.constraint(equalTo: (collectionView?.safeAreaLayoutGuide.trailingAnchor)!, constant: -10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: (collectionView?.safeAreaLayoutGuide.bottomAnchor)!, constant: -10).isActive = true
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
    
    @objc func handleAdd() -> Void {
        let newAlarm  = Alarm()
        alarms.append(newAlarm)
        collectionView?.reloadData()
        
    }
    
}


class AlarmCellView: UICollectionViewCell {
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}