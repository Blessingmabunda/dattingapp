import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _dob;
  String? _gender;
  File? _idImage;
  File? _selfieImage;

  final redColor =  Colors.red.shade700;

  Future<void> _pickImage(bool isSelfie) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (isSelfie) {
          _selfieImage = File(pickedFile.path);
        } else {
          _idImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dob = picked);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Submit the form
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signing Up...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: redColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Create Your Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: redColor)),
              SizedBox(height: 20),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) => value!.isEmpty ? 'Enter your first name' : null,
              ),
              SizedBox(height: 10),

              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  child: Text(_dob == null ? 'Select your birth date' : "${_dob!.toLocal()}".split(' ')[0]),
                ),
              ),
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              SizedBox(height: 20),

              _buildImageUploader("Upload ID or Passport", _idImage, () => _pickImage(false)),
              SizedBox(height: 20),

              _buildImageUploader("Take a Selfie", _selfieImage, () => _pickImage(true)),
              SizedBox(height: 30),

              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploader(String label, File? image, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: redColor, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(color: redColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: image == null
                ? Center(child: Icon(Icons.camera_alt, size: 40, color: redColor))
                : Image.file(image, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
