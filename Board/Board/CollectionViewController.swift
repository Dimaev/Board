//
//  CollectionViewControllerDemo.swift
//  Board
//
//  Created by Dmitry on 23.02.17.
//  Copyright © 2017 Creator. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, NoteViewDelegate {
    
  
    
    
    var arrNotes:[String] = []
    var selectedIndex = 0

    func saveNotesArray() {
        //save the newly updated array
        UserDefaults.standard.set(arrNotes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
    
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody:
        String) {
        //update the respective values
        
        self.arrNotes[self.selectedIndex] = newBody
        //refresh the view
        self.collectionView?.reloadData()
        
        saveNotesArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
       
        //this is known as downcasting
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [String] {
            //set the instance variable to the newNotes variable
            arrNotes = newNotes

        }
        // Добавляем строку, регистрируем xib
        self.collectionView?.register(UINib(nibName: "TextCellView", bundle: nil), forCellWithReuseIdentifier: "CELL")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return arrNotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //set the selected index before segue
        // получаем уже Cell нужного типа
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL",
                                                      for: indexPath) as! TextCellView
      
        
        cell.labelText.text = arrNotes[indexPath.row]
        

//
        return cell
    }

    @IBAction func newNote() {
        
        var newArr:String = ""
        
        arrNotes.insert(newArr, at: 0)
        
        //save the notes to the phone
        saveNotesArray()
       
        performSegue(withIdentifier:"showEditorSegue", sender: nil)
        
        
    
        //set the selected index to the most recently added item
        self.selectedIndex = 0
        
        //reload the table ( refresh the view)
        self.collectionView?.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        
    if segue.identifier == "showEditorSegue" {
        
        //grab the view controller we're gong to transition to
        let notesEditorVC = segue.destination as!
        NotesViewController
        
        //set the title of the navigation bar to the selectedIndex's title
        notesEditorVC.navigationItem.title =
            arrNotes[self.selectedIndex]
        
        //set the body of the view controller to the selectedIndex's body
        
        notesEditorVC.strBodyText =
            arrNotes[self.selectedIndex]//["body"]
        
        //set the delegate to "self", so the method gets called here
        notesEditorVC.delegate = self
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
