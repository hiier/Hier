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
    
    private var eventTitle: UITextField!
    
    private var eventDescription: UITextView!
    
    private var eventPhoto: UIImageView!
    
    private var eventTime: UITextField!
    
    private var eventLocation: UIButton!
    
    private var eventMaxParticipants: UITextField!
    
    private var submitButton: UIButton!
    
    private var datePicker: UIDatePicker!
    
    // MARK: - Properties
    
    private var selectedPlacemark: MKPlacemark? {
        didSet {
            validateLocation()
        }
    }
    
    private var selectedDateTime: Date? {
        didSet {
            validateTime()
        }
    }
    
    private var isTitleValid: Bool = false {
        didSet {
            validateEvent()
        }
    }
    
    private var isTimeValid: Bool = false {
        didSet {
            validateEvent()
        }
    }
    
    private var isLocationValid: Bool = false {
        didSet {
            validateEvent()
        }
    }
    
    private var isEventValid: Bool = false {
        didSet {
            if isEventValid {
                enableSubmit()
            } else {
                disableSubmit()
            }
        }
    }
    
    private var cells: [[UITableViewCell]] = [
        [UITableViewCell(), UITableViewCell()],
        [UITableViewCell(), UITableViewCell(), UITableViewCell()],
        [UITableViewCell()]
    ]
    
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
        view.endEditing(true)
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
        case eventMaxParticipants:
            return length <= 3
        default:
            return true
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar
        title = "Create Event"
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissEvent))
        cancelBarButton.tintColor = Constants.ThemeColor
        navigationItem.leftBarButtonItem  = cancelBarButton
        
        // Set event title
        eventTitle = UITextField()
        eventTitle.font = Constants.TitleFont
        eventTitle.placeholder = "Title"
        eventTitle.returnKeyType = .done
        eventTitle.delegate = self
        eventTitle.addTarget(self, action: #selector(validateTitle), for: .editingChanged)
        
        // Set 1st cell
        layoutSingleOutlet(outlet: eventTitle, cell: cells[0][0], inset: UIEdgeInsetsMake(8, 16, 8, 8))
        
        // Set event description
        eventDescription = UITextView()
        eventDescription.font = Constants.DefaultTextFont
        eventDescription.textAlignment = .left
        eventDescription.placeholder = "Description (optional)"
        
        // Set event photo
        eventPhoto = UIImageView()
        eventPhoto.layer.cornerRadius = Constants.CornerRadius
        eventPhoto.clipsToBounds = true
        eventPhoto.isUserInteractionEnabled = true
        eventPhoto.image = UIImage(named: "add_photo")
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(choosePhoto(gesture:)))
        singleTap.numberOfTapsRequired = 1
        eventPhoto.addGestureRecognizer(singleTap)
        
        // Set 2nd cell
        let secondCell = cells[0][1]
        secondCell.contentView.addSubview(eventPhoto)
        secondCell.contentView.addSubview(eventDescription)
        eventPhoto.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.trailing.equalTo(secondCell.contentView.snp.trailing).offset(-8)
            make.top.equalTo(secondCell.contentView.snp.top).offset(8)
        }
        eventDescription.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(secondCell.contentView.snp.leading).offset(16)
            make.trailing.equalTo(eventPhoto.snp.leading).offset(-8)
            make.top.equalTo(eventPhoto.snp.top)
            make.bottom.equalTo(eventPhoto.snp.bottom)
        }
        
        // Set date picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        
        // Set event time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissDatePicker)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(chooseTime))
            ], animated: false)
        eventTime = UITextField()
        eventTime.borderStyle = .none
        eventTime.font = Constants.DefaultTextFont
        eventTime.inputAccessoryView = toolbar
        eventTime.placeholder = "Pick Time"
        eventTime.inputView = datePicker
        
        // Set 3rd cell
        layoutIconAndField(iconName: "calendar", field: eventTime, cell: cells[1][0])
        
        // Set event location
        eventLocation = UIButton()
        eventLocation.setTitle("Add Location", for: .normal)
        eventLocation.setTitleColor(Constants.PlaceholderColor, for: .normal)
        eventLocation.titleLabel?.font = Constants.DefaultTextFont
        eventLocation.contentHorizontalAlignment = .left
        eventLocation.addTarget(self, action: #selector(presentEventLocationViewController), for: .touchUpInside)
        
        // Set 4th cell
        layoutIconAndField(iconName: "pin", field: eventLocation, cell: cells[1][1])
        
        // Set max #participants
        eventMaxParticipants = UITextField()
        eventMaxParticipants.font = Constants.DefaultTextFont
        eventMaxParticipants.placeholder = "Max #participants"
        eventMaxParticipants.keyboardType = .numberPad
        eventMaxParticipants.delegate = self
        
        // Set 5th cell
        layoutIconAndField(iconName: "group", field: eventMaxParticipants, cell: cells[1][2])
        
        // Set submit button
        submitButton = UIButton()
        submitButton.setTitle("submit", for: .normal)
        submitButton.backgroundColor = Constants.ThemeColor
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitEvent), for: .touchUpInside)
        disableSubmit()
        
        // Set 6th cell
        layoutSingleOutlet(outlet: submitButton, cell: cells[2][0], inset: UIEdgeInsetsMake(0, 0, 0, 0))
        
        // Table view config
        for row in cells {
            for cell in row {
                cell.selectionStyle = .none
            }
        }
        tableView.keyboardDismissMode = .onDrag
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 44
            case 1:
                return 118
            default:
                return 0
            }
        case 1:
            return 44
        case 2:
            return 44
        default:
            return 0
        }
    }
    
    // MARK: - Methods
    
    private func layoutSingleOutlet(outlet: UIView, cell: UITableViewCell, inset: UIEdgeInsets) {
        cell.contentView.addSubview(outlet)
        outlet.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(cell).inset(inset)
        }
    }
    
    private func layoutIconAndField(iconName: String, field: UIView, cell: UITableViewCell) {
        let icon = UIImageView(image: UIImage(named: iconName))
        icon.contentMode = .scaleAspectFit
        cell.contentView.addSubview(icon)
        cell.contentView.addSubview(field)
        icon.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(cell.contentView.snp.leading).offset(16)
            make.top.equalTo(cell.contentView.snp.top).offset(8)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        field.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.top.equalTo(icon.snp.top)
            make.bottom.equalTo(icon.snp.bottom)
            make.trailing.equalTo(cell.contentView.snp.trailing).offset(-8)
        }
    }
    
    func presentEventLocationViewController() {
        if let nc = storyboard?.instantiateViewController(withIdentifier: "eventLocationWrapperNavigationController") as? UINavigationController{
            if let elvc = nc.viewControllers.first as? EventLocationViewController {
                view.endEditing(true)
                elvc.selectedPlacemark = selectedPlacemark
                present(nc, animated: true, completion: nil)
            }

        }
    }
    
    func unwindToCreateEventTableViewController(placemark: MKPlacemark?) {
        selectedPlacemark = placemark
        if selectedPlacemark != nil {
            eventLocation.setTitle(selectedPlacemark?.name, for: .normal)
            eventLocation.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    private func disableSubmit() {
        submitButton.isEnabled = false
        submitButton.alpha = 0.5

    }
    
    private func enableSubmit() {
        submitButton.isEnabled = true
        submitButton.alpha = 1.0
    }
    
    func dismissEvent() {
        view.endEditing(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func submitEvent() {
        // TO DO: call API to create event
        dismissEvent()
    }
    
    func validateTitle() {
        isTitleValid = !eventTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateTime() {
        isTimeValid = selectedDateTime != nil
    }
    
    func validateLocation() {
        isLocationValid = selectedPlacemark != nil
    }
    
    private func validateEvent() {
        isEventValid = isTitleValid && isTimeValid && isLocationValid
    }
}


