import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  var language = ['English', 'Urdu', 'Arabic'];
  var originlanguage = "--Select Language--";
  var destinationlanguage = "--Select Language--";
  var output = "";
  TextEditingController languagecontroller = TextEditingController();
  void translation(String scr, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: scr, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (scr == '--' || dest == '--') {
      setState(() {
        output = 'failed to translate';
      });
    }
  }

  String getlanguagecode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Arabic') {
      return 'ar';
    } else if (language == 'Urdu') {
      return 'ur';
    } else {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Language Translator",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff0f172a),
      
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originlanguage,
                      style: TextStyle(color: Colors.red),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: language.map((String dropownstringitem) {
                      return DropdownMenuItem(
                        child: Text(dropownstringitem),
                        value: dropownstringitem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originlanguage = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationlanguage,
                      style: TextStyle(color: Colors.red),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: language.map((String dropownstringitem) {
                      return DropdownMenuItem(
                        child: Text(dropownstringitem),
                        value: dropownstringitem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationlanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  autofocus: false,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'please enter what you want to translate ',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    )),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                  controller: languagecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white24),minimumSize: WidgetStatePropertyAll(Size(200, 60))),
                    onPressed: () {
                      translation(
                          getlanguagecode(originlanguage),
                          getlanguagecode(destinationlanguage),
                          languagecontroller.text.toString());
                    },
                    child: Text("Translate",style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20,color: Colors.red),),),
              ),
              SizedBox(
                height: 20,
              ),
              // Text("\n$output",style: TextStyle(fontWeight: FontWeight.bold,fontSize:50,color: Colors.yellow),)
              Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "\n$output",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
