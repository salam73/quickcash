import 'package:flutter/material.dart';
import 'package:quickcash/api_service.dart';
import 'package:quickcash/model/customer.dart';
import 'package:quickcash/utils/ProgressHUD.dart';
import 'package:quickcash/utils/form_helper.dart';
import 'package:quickcash/utils/validator_service.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  APIService apiService;
  CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = new APIService();
    model = new CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Sign Up"),
      ),
      body: ProgressHUD(
        child: new Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Name"),
                FormHelper.textInput(
                  context,
                  model.firstName,
                  (value) => {this.model.firstName = value},
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter First Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                  context,
                  model.lastName,
                  (value) => {this.model.lastName = value},
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Last Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email Id"),
                FormHelper.textInput(
                  context,
                  model.email,
                  (value) => {this.model.email = value},
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Email Id.';
                    }

                    if (value.toString().isEmpty &&
                        !value.toString().isValidEmail()) {
                      return 'Please enter Email Id.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("password"),
                FormHelper.textInput(
                  context,
                  model.password,
                  (value) => {this.model.password = value},
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter password';
                    }

                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new Center(
                  child: FormHelper.saveButton('Register', () {
                    if (validateAndSave()) {
                      print(model.toJson());
                      setState(() {
                        isApiCallProcess = true;
                      });

                      apiService.createCustomer(model).then((ret) {
                        setState(() {
                          isApiCallProcess = false;
                        });

                        if (ret) {
                          FormHelper.showMessage(context, "WooCommereApp",
                              'Register Success', 'ok', () {
                            Navigator.of(context).pop();
                          });
                        }
                      });
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      return true;
    }
    return false;
  }
}
