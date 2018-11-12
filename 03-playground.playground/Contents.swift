import UIKit

protocol TagProtocol : class{
    var text: String?  { get set }
    var note: NoteProtocol?{ get set }
}

class NoteTag : TagProtocol {
    
    var text: String?
    weak var note: NoteProtocol? = nil
    let creationDate: Date = Date()
    
    init() {
        self.text = "Empty Tag"
    }
    
    init?(text: String?) {
        self.text = text
    }
    
    init?(text: String?, note: NoteProtocol) {
        self.text = text
        self.note = note
    }
    
    deinit { print("Tag deinitialization") }
}



protocol NoteProtocol: class {
    
}

class DiaryNote : NoteProtocol{
    
    let creationDate: Date = Date()
    
    var creationDateFormatted: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.locale = Locale(identifier: "uk_UA")
            return dateFormatter.string(from: creationDate)
        }
    }
    
    var tags: [TagProtocol]?
    
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
    
    init ()
    {
        name = ""
        text = ""
        tags = nil
    }
    
    init? (name: String? = nil, text: String? = nil, tags: [TagProtocol]? = nil)
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
                str2 += "["+str.text!+"]"
            }
        }
        return str1 + str2
    }
    
    deinit {
        print("Note \(name ?? "noname") deinitialization")
    }
}

//creating tags
var tag1 = NoteTag(text: "Сеед")
var tag2 = NoteTag(text: "Чому")

//creating note
var dir2 = DiaryNote(name: "Осінь", tags: [tag1!, tag2!])

tag1?.note = dir2
tag2?.note = dir2

//showing notes
dir2!.simpleDescription()

//checking didSet
dir2!.name = "Зробити дз"

//checking if Resolving Strong Reference Cycles exist (if deinit works)
dir2 = nil
tag1 = nil
tag2 = nil
