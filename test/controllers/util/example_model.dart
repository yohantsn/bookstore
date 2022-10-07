import 'package:bookstore/data/models/models.dart';

class ExampleModel {
  static List<BookModel> get books => [BookModel.fromJson(_bookJson)];
}

final _bookJson = {
  "kind": "books#volume",
  "id": "EZ5VAAAAMAAJ",
  "etag": "+l7jJrV451Q",
  "selfLink": "https://www.googleapis.com/books/v1/volumes/EZ5VAAAAMAAJ",
  "volumeInfo": {
    "title": "IEEE VLSI Test Symposium",
    "publishedDate": "2005",
    "industryIdentifiers": [
      {"type": "OTHER", "identifier": "UOM:39015058299242"}
    ],
    "readingModes": {"text": false, "image": false},
    "printType": "BOOK",
    "categories": ["Application-specific integrated circuits"],
    "maturityRating": "NOT_MATURE",
    "allowAnonLogging": false,
    "contentVersion": "0.3.2.0.preview.0",
    "panelizationSummary": {"containsEpubBubbles": false, "containsImageBubbles": false},
    "imageLinks": {
      "smallThumbnail":
          "http://books.google.com/books/content?id=EZ5VAAAAMAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
      "thumbnail":
          "http://books.google.com/books/content?id=EZ5VAAAAMAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    },
    "language": "en",
    "previewLink": "http://books.google.pt/books?id=EZ5VAAAAMAAJ&q=test&dq=test&hl=&cd=1&source=gbs_api",
    "infoLink": "http://books.google.pt/books?id=EZ5VAAAAMAAJ&dq=test&hl=&source=gbs_api",
    "canonicalVolumeLink": "https://books.google.com/books/about/IEEE_VLSI_Test_Symposium.html?hl=&id=EZ5VAAAAMAAJ"
  },
  "saleInfo": {"country": "PT", "saleability": "NOT_FOR_SALE", "isEbook": false},
  "accessInfo": {
    "country": "PT",
    "viewability": "NO_PAGES",
    "embeddable": false,
    "publicDomain": false,
    "textToSpeechPermission": "ALLOWED",
    "epub": {"isAvailable": false},
    "pdf": {"isAvailable": false},
    "webReaderLink": "http://play.google.com/books/reader?id=EZ5VAAAAMAAJ&hl=&printsec=frontcover&source=gbs_api",
    "accessViewStatus": "NONE",
    "quoteSharingAllowed": false
  },
  "searchInfo": {
    "textSnippet":
        "In this section, we first discuss prior work, and then review the basic concepts of NoC operation. 2.1 Prior work The design and optimization of dedicated TAMs for <b>test</b> access to SoCs has been the focus of several studies [2, 11]."
  }
};
