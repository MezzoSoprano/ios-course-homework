import UIKit


class DiaryNote {
    
    let creationDate: Date = Date()
    
    var creationDateFormatted: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.locale = Locale(identifier: "uk_UA")
            return dateFormatter.string(from: creationDate)
        }
    }
    
    var name: String? {
        didSet {
            if name != oldValue && oldValue != nil && name != nil {
                let editingDate = Date()
                print("Ім'я \"\(oldValue!)\" нотатки було змінено на \"\(name!)\" о \(editingDate)")
            }
        }
    }
    
    var text: String? {
        didSet {
            if text != oldValue && oldValue != nil && text != nil{
                let editingDate = Date()
                print("Текст нотатки \"\(name!)\" з \"\(oldValue!)\" був змінений на \"\(text!)\" о \(editingDate)")
            }
        }
    }
    
    var tags: [String]? {
        didSet {
            if tags != oldValue && oldValue != nil && tags != nil{
                let editingDate = Date()
                print("Теги \(oldValue!)  нотатки \"\(name!)\" були змінені на \"\(tags!)\" о \(editingDate)")
            }
        }
    }
    
    init ()
    {
        name = ""
        text = ""
        tags = [""]
    }
    
    init? (name: String? = nil, text: String? = nil, tags: [String]? = nil)
    {
        //formatting temp date for checking
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "uk_UA")
        let date = dateFormatter.string(from: creationDate)
        
        //check if format is ok
        if creationDateFormatted != date
        {
            return nil
        }
        
        self.name = name
        self.text = text
        self.tags = tags
        
    }
    
    func simpleDescription() -> String {
        
        let str1 = "\(creationDateFormatted) \n\n" + (name != nil ? "\"\(name!)\" \n\n" : "") + (text != nil ? "\(text!) \n\n" : "")
        
        
        var str2: String = ""
        if let temp = tags {
            for str in temp
            {
                str2 += "["+str+"]"
            }
        }
        return str1 + str2
    }
}

var dir = DiaryNote(name: "Осінь", text: "Еххх. Як все складно.", tags: ["Чому", "Як"]) //all arguments
var dir1 = DiaryNote() //none
var dir2 = DiaryNote(name: "Осінь")
var dir3 = DiaryNote(text: "Еххх. Як все складно.", tags: ["Чому", "Як"])
var dir4 = DiaryNote(text: "Еххх. Як все складно.")

dir!.simpleDescription()
dir1.simpleDescription()
dir2!.simpleDescription()
dir3!.simpleDescription()
dir4!.simpleDescription()


//checking didSet
dir!.text = "Невже це буде працювати"
dir!.tags = ["Вау"]
dir2!.name = "Зробити дз"

//ignoring the same editing
dir2!.name = "Зробити дз"

