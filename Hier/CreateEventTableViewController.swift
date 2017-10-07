//
//  CreateEventTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/30/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MapKit
import PhoneNumberKit

class CreateEventTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var eventTitle: UITextField! {
        didSet {
            eventTitle.borderStyle = .none
            eventTitle.delegate = self
            eventTitle.font = Constants.DefaultTextFont
            eventTitle.placeholder = "Title"
            eventTitle.returnKeyType = .done
            eventTitle.addTarget(self, action: #selector(CreateEventTableViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var eventDescription: UITextView! {
        didSet {
            eventDescription.delegate = self
            eventDescription.font = Constants.DefaultTextFont
            eventDescription.textAlignment = .left
            eventDescription.placeholder = "Description (optional)"
        }
    }
    
    @IBOutlet weak var eventPhoto: UIImageView! {
        didSet {
            eventPhoto.layer.cornerRadius = Constants.CornerRadius
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
    
    @IBOutlet weak var eventContactPhone: UITextField! {
        didSet {
            eventContactPhone.borderStyle = .none
            eventContactPhone.delegate = self
            eventContactPhone.font = Constants.DefaultTextFont
            eventContactPhone.placeholder = "Phone (optional)"
            eventContactPhone.keyboardType = .numberPad
            eventContactPhone.addTarget(self, action: #selector(CreateEventTableViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var eventMaxNumParticipants: UITextField! {
        didSet {
            eventMaxNumParticipants.borderStyle = .none
            eventMaxNumParticipants.delegate = self
            eventMaxNumParticipants.font = Constants.DefaultTextFont
            eventMaxNumParticipants.placeholder = "Max #participants (optional)"
            eventMaxNumParticipants.keyboardType = .numberPad
            eventMaxNumParticipants.addTarget(self, action: #selector(CreateEventTableViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.backgroundColor = Constants.LightGreen
            submitButton.setTitleColor(UIColor.white, for: .normal)
            disableSubmitButton()
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
            selectedLocation = elvc.selectedPlacemark
            if let location = selectedLocation {
                eventLocation.setTitle(Helpers.parseAddress(selectedItem: location), for: .normal)
                eventLocation.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }

    // MARK: - Properties
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    var selectedLocation: MKPlacemark? {
        didSet {
            validateFields()
        }
    }
    
    var selectedTime: Date? {
        didSet {
            validateFields()
        }
    }
    
    let phoneNumberKit = PhoneNumberKit()
    
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
        selectedTime = datePicker.date
        dismissDatePicker()
    }
    
    func dismissDatePicker() {
        self.view.endEditing(true)
    }
    
    // MARK: - UITextField methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = textField.text!.characters.count + (string.characters.count - range.length)
        switch textField {
        case eventTitle:
            return length <= 100
        case eventMaxNumParticipants:
            return length <= 3
        default:
            return true
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case eventTitle:
            validateFields()
        case eventContactPhone:
            validateFields()
        case eventMaxNumParticipants:
            validateFields()
        default:
            break
        }
    }
    
    // MARK: - UITextView methods
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case eventDescription:
            validateFields()
        default:
            break
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
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
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
                    elvc.selectedPlacemark = self.selectedLocation
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
    
    private func disableSubmitButton() {
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
    }
    
    private func enableSubmitButton() {
        submitButton.isEnabled = true
        submitButton.alpha = 1.0
    }
    
    private func isTitleValid() -> Bool {
        return !eventTitle.text!.removingWhitespaces().isEmpty
    }
    
    private func isDescriptionValid() -> Bool {
        return eventDescription.text!.isEmpty || !eventDescription.text!.removingWhitespaces().isEmpty
    }
    
    private func isTimeValid() -> Bool {
        return true
    }
    
    private func isLocationValid() -> Bool {
        return selectedLocation != nil
    }
    
    private func isContactPhoneValid() -> Bool {
        if eventContactPhone.text!.isEmpty {
            return true
        }
        do {
            let _ = try phoneNumberKit.parse(eventContactPhone.text!)
            return true
        } catch {
            return false
        }
    }
    
    private func isMaxNumParticipantsValid() -> Bool {
        if eventMaxNumParticipants.text!.isEmpty {
            return true
        }
        if let _ = Int(eventMaxNumParticipants.text!) {
            return true
        }
        return false
    }
    
    private func validateFields() {
        let areRequiredFieldsValid = isTitleValid() && isDescriptionValid() && isTimeValid() && isLocationValid() && isContactPhoneValid() && isMaxNumParticipantsValid()
        if areRequiredFieldsValid {
            enableSubmitButton()
        } else {
            disableSubmitButton()
        }
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
}
