//
//  TableViewController.swift
//  StudentListCoreData
//
//  Created by Lin Wei on 2/9/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit
// step 1
import CoreData
class TableViewController: UITableViewController {
    
//    var students  = [String]()
    
// step 2
    
//    var students = [NSManagedObject]()
    
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // step 10
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // step 11 fetch request
        
        let request = NSFetchRequest(entityName: "Student")
        
        // step 12 excte moc request and asiging to the student array
        
        let err:NSError?
        do{
//           try students = managedObjectContext.executeFetchRequest(request) as! [NSManagedObject]
            try students = managedObjectContext.executeFetchRequest(request) as! [Student]
            
        }
        catch let error1 as NSError {
            
            err =  error1
            if err != nil {
            print("loading data problem")
            }
        }
        
 
        
        
        
    }
    
    //step 4
    func saveStudents (name:String){
        
        //step 5 create a managedObjectContext
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
       
        // step 6
        // insert entity "Student" into managedObjectContext
        let student =  NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: managedObjectContext) as! Student
    
        //step 7 
        
        // insert text to the enity object Student
        student.setValue(name, forKey: "name")
        
        let err: NSError?
        //step 8 moc save and store inside the students array
        do {
            try  managedObjectContext.save()
           self.students.append(student)
        }
        catch let error1  as NSError {
            
           err = error1
     
            if err != nil {
                print("problem saving data")
            }
            
        }
      
        
    
    }
    
    
    
    
    
    @IBAction func AddButtonOnClick(sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Student", message: "Enter A New Student Name", preferredStyle: .Alert)
        
        let saveAlertAction = UIAlertAction(title: "Save", style: .Default) { (action:UIAlertAction) -> Void in
            let textField =  alert.textFields![0] as UITextField
            
           
            
            //  self.students.append(textField.text!)
            //step 9 custome save func
            
            self.saveStudents(textField.text!)
            
           
            self.tableView.reloadData()
        }
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
             
        }
        
        
        alert.addAction(saveAlertAction)
        alert.addAction(cancelAlertAction)
     presentViewController(alert, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

//        cell.textLabel?.text = students[indexPath.row]
        
        //step 3
//        let student:NSManagedObject = students[indexPath.row]
//        
//        cell.textLabel?.text = student.valueForKey("name") as? String
        
        
        cell.textLabel?.text = students[indexPath.row].name 
        
        // Configure the cell...

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
