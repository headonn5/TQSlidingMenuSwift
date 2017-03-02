TQSlidingMenuSwift
==================

iOS Sliding Menu using Swift, based on the Gmail app using sliding menu.

![](https://deepdivers.files.wordpress.com/2017/03/tqslidingmenudemo.gif)

## Installation

#### CocoaPods
```
pod 'TQSlidingMenuSwift'
```

####Manually
Drag TQPresentationController.swift, TQBaseViewController.swift, TQMenuController.swift to your app.
Extend your presenting view controllers from TQBaseViewController, and the menu view controller from TQMenuController
That's it. Play with your Sliding Menu now!!!.

## Usage

Add `import TQSlidingMenuSwift` in your file

1. Embed the first view controller in navigation controller, and derive it from TQBaseViewController.
2. Create Menu Table View controller class, and add the same in story board, and derive it from TQMenuController.
(Do not forget to re-name the class of tableview controller in storyboard to custom tableview controller class you just created).
3. Set storyboard identifiers for all the view controllers to be displayed by sliding menu.
4. Call setNavigtionMenu(...) method in viewDidLoad() method of every view controller that needs to be displayed.
```swift
setNavigtionMenu(withScreenTitle: "Google", withMenuControllerId: "menuVC")
```
5. In Menu Table View Controller created by you, add the below code for when user select a row :
```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
switch indexPath.row {
case 0:
performCustomSegue(withIdentifier: "VC1")
case 1:
performCustomSegue(withIdentifier: "VC2")
default:
performCustomSegue(withIdentifier: "VC1")
}
dismiss(animated: true, completion: nil)
}
```
Provide the storyboard id of view controllers to be presented


## Contributing
Contributers can fork the repo and provide useful features that can be integrated in it.

## Requirements
Requires Swift version > 3.0
