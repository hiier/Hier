//
//  CreateEventTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/30/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MapKit

class CreateEventTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var eventTitle: UITextField! {
        didSet {
            eventTitle.borderStyle = .none
            eventTitle.delegate = self
            eventTitle.font = Constants.TitleFont
            eventTitle.placeholder = "Title"
            eventTitle.returnKeyType = .done
        }
    }
    
    @IBOutlet weak var eventDescription: UITextView! {
        didSet {
            eventDescription.font = Constants.DefaultTextFont
            eventDescription.textAlignment = .left
            eventDescription.placeholder = "Description (optional)"
        }
    }
    
    @IBOutlet weak var eventPhoto: UIImageView! {
        didSet {
            eventPhoto.layer.cornerRadius = Constants.CornerRadius
            eventPhoto.layer.borderColor = Constants.LightGreen.cgColor
            eventPhoto.layer.borderWidth = 1
            eventPhoto.clipsToBounds = true
            eventPhoto.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(choosePhoto(gesture:)))
            singleTap.numberOfTapsRequired = 1
            eventPhoto.addGestureRecognizer(singleTap)
        }
    }
    
    @IBOutlet weak var eventTime: UITextField! {
        didSet {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(chooseTime))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissDatePicker))
            toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
            eventTime.borderStyle = .none
            eventTime.font = Constants.DefaultTextFont
            eventTime.inputAccessoryView = toolbar
            eventTime.inputView = datePicker
            eventTime.placeholder = "Pick Time"
        }
    }
    
    @IBOutlet weak var eventLocation: UIButton! {
        didSet {
            eventLocation.setTitle("Add Location", for: .normal)
            eventLocation.setTitleColor(Constants.PlaceholderColor, for: .normal)
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.alpha = 0.5
            submitButton.backgroundColor = Constants.LightGreen
            submitButton.isEnabled = false
            submitButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismissEvent()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        submitEvent()
    }
    
    @IBAction func unwindToCreateEventTableViewController(segue: UIStoryboardSegue) {
        if let elvc = segue.source as? EventLocationViewController {
            selectedPlacemark = elvc.selectedPlacemark
            if selectedPlacemark != nil {
                eventLocation.setTitle(selectedPlacemark?.name, for: .normal)
                eventLocation.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    
    @IBAction func validateFields() {
        let areRequiredFieldsValid = isTitleValid() && isDescriptionValid() && isTimeValid() && isLocationValid()
        if areRequiredFieldsValid {
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        } else {
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
    }

    // MARK: - Properties
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    var selectedPlacemark: MKPlacemark? {
        didSet {
            validateFields()
        }
    }
    
    var selectedDateTime: Date? {
        didSet {
            validateFields()
        }
    }
    
    // MARK: - Event photo methods

    func choosePhoto(gesture: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: "Choose camera or photo library", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: useCamera))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: chooseFromPhotoLibrary))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func useCamera(action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            picker.delegate = self
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
        }
    }
    
    private func chooseFromPhotoLibrary(action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        eventPhoto.contentMode = .scaleAspectFill
        eventPhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Event time methods
    
    func chooseTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        eventTime.text = dateFormatter.string(from: datePicker.date)
        selectedDateTime = datePicker.date
        dismissDatePicker()
    }
    
    func dismissDatePicker() {
        self.view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = textField.text!.characters.count + (string.characters.count - range.length)
        switch textField {
        case eventTitle:
            return length <= 100
        default:
            return true
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table view config
        tableView.keyboardDismissMode = .onDrag
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "location" {
            if let nc = segue.destination as? UINavigationController {
                if let elvc = nc.viewControllers.first as? EventLocationViewController {
                    view.endEditing(true)
                    elvc.selectedPlacemark = self.selectedPlacemark
                }
            }
        }
    }
    
    // MARK: - Custom methods
    
    private func dismissEvent() {
        view.endEditing(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func submitEvent() {
        
        dismissEvent()
    }
    
    private func isTitleValid() -> Bool {
        return !eventTitle.text!.isEmpty
    }
    
    private func isDescriptionValid() -> Bool {
        return true
    }
    
    private func isTimeValid() -> Bool {
        return selectedDateTime != nil
    }
    
    private func isLocationValid() -> Bool {
        return selectedPlacemark != nil
    }
}


