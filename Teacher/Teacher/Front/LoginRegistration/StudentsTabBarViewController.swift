//
//  SecondTabBarViewController.swift
//  Teacher
//
//  Created by Expl0it on 5/3/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import Foundation
import UIKit


let student1 = ["profile_icon.png", "Student 1"]
let student2 = ["profile_icon.png", "Student 2"]
let student3 = ["profile_icon.png", "Student 3"]
let student4 = ["profile_icon.png", "Student 4"]
let student5 = ["profile_icon.png", "Student 5"]
let student6 = ["profile_icon.png", "Student 6"]
let student7 = ["profile_icon.png", "Student 7"]
let student8 = ["profile_icon.png", "Student 8"]
let student9 = ["profile_icon.png", "Student 9"]
let student10 = ["profile_icon.png", "Student 10"]
let myStudents = [student1, student2, student3, student4, student5, student6]
let allStudents = [student1, student2, student3, student4, student5, student6, student7, student8, student9, student10]

class StudentsTabBarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var studentSegmentedControl: UISegmentedControl!
   
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Public Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch studentSegmentedControl.selectedSegmentIndex {
        case 0:
            return myStudents.count
        case 1:
            return allStudents.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentViewControllerTableViewCell
        switch studentSegmentedControl.selectedSegmentIndex {
        case 0:
            cell.studentImageView.image = UIImage(named: myStudents[indexPath.row][0])
            cell.studentNameLabel.text = myStudents[indexPath.row][1]
        case 1:
            cell.studentImageView.image = UIImage(named: allStudents[indexPath.row][0])
            cell.studentNameLabel.text = allStudents[indexPath.row][1]
        default:
            break
        }
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch studentSegmentedControl.selectedSegmentIndex {
        case 0:
            let studentImage = myStudents[indexPath.row][0]
            let studentName = myStudents[indexPath.row][1]
            let selectedStudent = [studentImage, studentName]
            print(selectedStudent)
        case 1:
            let studentImage = allStudents[indexPath.row][0]
            let studentName = allStudents[indexPath.row][1]
            let selectedStudent = [studentImage, studentName]
            print(selectedStudent)
        default:
            break
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func segmentedChanged(_ sender: Any) {
        studentTableView.reloadData()
    }
}
