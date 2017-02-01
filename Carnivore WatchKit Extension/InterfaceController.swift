
import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    var ounces = 16
    var cookTemp = MeatTemperature.medium
    var timerRunning = false
    var usingMetric = false
    
    @IBOutlet var timerButton: WKInterfaceButton!    
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var weightPicker: WKInterfacePicker!
    
    @IBOutlet var temperatureLabel: WKInterfaceLabel!
    
    @IBOutlet var temperaturePicker: WKInterfacePicker!
    
    @IBAction func onTemperatureChanged(_ value: Int) {
        
        let temp = MeatTemperature(rawValue: value)!
        cookTemp = temp
        temperatureLabel.setText(temp.stringValue)
        
    }
    
    @IBAction func onWeightChanged(_ value: Int) {
        
        ounces = value + 1
        
    }
    @IBAction func onTimerButton() {
        
        // Upon a user tap, if the timer is already running, stop it and update the button title
        if timerRunning {
            timer.stop()
            timerButton.setTitle("Start Timer")
        
        } else {
            
            // If the timer is not running, create a cooking time interval and use it to create a Date. Then start the timer and update the button title
            let time = cookTemp.cookTimeForOunces(ounces)
            timer.setDate(Date(timeIntervalSinceNow: time))
            timer.start()
            timerButton.setTitle("Stop Timer")
            
        }
        
        timerRunning = !timerRunning

    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var weightItems = [WKPickerItem]()
        
        for i in 1...32 {
            
            let item = WKPickerItem()
            item.title = String(i)
            weightItems.append(item)
        }
        
        weightPicker.setItems(weightItems)
        
        weightPicker.setSelectedItemIndex(ounces - 1)
        
        var tempItems = [WKPickerItem]()
        for i in 1...4 {
            
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: "temp-\(i)")
            tempItems.append(item)
        }
        
        temperaturePicker.setItems(tempItems)
        
        onTemperatureChanged(0)
    }
    

}
