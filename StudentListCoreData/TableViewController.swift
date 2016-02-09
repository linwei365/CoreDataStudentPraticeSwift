//
//  TableViewController.swift
//  StudentListCoreData
//
//  Created by Lin Wei on 2/9/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit
//step 1 import CoreData
import CoreData

class TableViewController: UITableViewController {
    //step 2 create array NSManageObject type this example the Student is a NSManageObject
    var students  = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //step 10  create a intial  moc
        
        let manangedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //step 11 create a request from entity
        
        let request = NSFetchRequest(entityName: "Student")
        
        //step 12 excute manangedObjectContext retchRequest and set it back to the array
        
        let err:NSError?
      
        do{
            try students = manangedObjectContext.executeFetchRequest(request) as! [Student]
        }
        catch let error as NSError{
            
            err = error
            
            if err != nil {
                
                print("an error loading data from core Data " )
            }
        }
        
 
        
    }
    
    
    func saveStudent(name:String){
        
        //step 5 create manangedObjectContext from delegate
        let manangedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //step 6 insert entity into manangedObjectContext
        
        let student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: manangedObjectContext) as! Student
    
        // step 7 set value for key
        student.setValue(name, forKey: "name")
        
        //step 8 save
        let error: NSError?
        
        do {
            try manangedObjectContext.save()
            //step 9 append manangedObjectContext into the array
            students.append(student)
        }
        catch let errorB as NSError {
            
            error = errorB
            
            if error != nil {
                
                print("error to save")
            }
            
        }
        
        
    }
    
    @IBAction func AddButtonOnClick(sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Student", message: "Enter A New Student Name", preferredStyle: .Alert)
        
        let saveAlertAction = UIAlertAction(title: "Save", style: .Default) { (action:UIAlertAction) -> Void in
            let textField =  alert.textFields![0] as UITextField
            
            //step 4 cusotm save
            
            self.saveStudent(textField.text!)
//            self.students.append(textField.text!)
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
//step 3
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
