import 'package:flutter/material.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

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
                  width: 330,
                  child: const Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'FirstName',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                              ),
                            ),
                            controller: firstNameController,
                          ))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for Last Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'LastName',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                              ),
                            ),
                            controller: lastNameController,
                          )))
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              print('Yes');
                            }
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
