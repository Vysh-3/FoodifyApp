// For kIsWeb
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Adjust the package name

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    user = _auth.currentUser;
    if (user != null) {
      nameController.text = user?.displayName ?? '';
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          phoneController.text = userDoc["phone"] ?? '';
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    if (user != null) {
      try {
        await user?.updateDisplayName(nameController.text);
        await _firestore.collection("users").doc(user!.uid).set({
          "name": nameController.text,
          "phone": phoneController.text,
          }, SetOptions(merge: true));

        await user?.reload();
        user = _auth.currentUser;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating profile: $e")),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8FBFF),
        title: Text("Profile",
      style: TextStyle(
          color: Color(0xFF3D3D3D),
            fontSize: 24,
             fontFamily: 'DMSans', // Use your required font
             fontWeight: FontWeight.bold
             ),
            )
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
                        const SizedBox(height: 20),
            TextField(
              controller: nameController,
              style: TextStyle( // ✅ Style for entered text
    color: Color(0xFF3D3D3D),
    fontFamily: 'SkModernist',
    fontWeight: FontWeight.normal,
  ),
              decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle( // ✅ Apply your styles here
      color: Color(0xFFAAACAE),
      fontFamily: 'SkModernist',
      fontWeight: FontWeight.normal,
    ),),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              style: TextStyle( // ✅ Style for entered text
    color: Color(0xFF3D3D3D),
    fontFamily: 'SkModernist',
    fontWeight: FontWeight.normal,
  ),
              decoration: InputDecoration(
                labelText: "Phone number",
                labelStyle: TextStyle( // ✅ Apply your styles here
      color: Color(0xFFAAACAE),
      fontFamily: 'SkModernist',
      fontWeight: FontWeight.normal,
    ),
    ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            
            Spacer(),

            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 335,
                  height: 51,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF9881F), Color(0xFFFF774C)], // 🌈 Gradient Colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  child: ElevatedButton(
                    onPressed: _updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'SkModernist',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
                
                
                ),
              )
            ],
          ),
        ),
      );       
  }
}