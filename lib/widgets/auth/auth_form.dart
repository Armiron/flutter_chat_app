import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn, this.isLoading, {super.key});
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  UserImagePicker(),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username must be at least 4 characters long.';
                        }
                        return null;
                      },
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : "I already have an account"),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
