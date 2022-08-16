import 'package:flutter/material.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditIDCardFormPage extends StatefulWidget {
  const EditIDCardFormPage({Key? key}) : super(key: key);

  @override
  EditIDCardFormPageState createState() {
    return EditIDCardFormPageState();
  }
}

class EditIDCardFormPageState extends State<EditIDCardFormPage> {
  final _formKey = GlobalKey<FormState>();
  final IDCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors
                  .black), // set backbutton color here which will reflect in all screens.
          leading: BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: 320,
                  child: const Text(
                    "What's Your IDCard?",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: SizedBox(
                      height: 100,
                      width: 320,
                      child: TextFormField(
                        // Handles Form Validation for First Name
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your IDCard';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'IDCard',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                          ),
                        ),
                        controller: IDCardController,
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}
