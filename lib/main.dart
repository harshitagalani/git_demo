import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_demo/view.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  String? id;
  String? name;
  String? contact;

  Home([this.id, this.name, this.contact]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  ImagePicker picker = ImagePicker();
  bool is_upload = false;
  XFile? photo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      t1.text = widget.name!;
      t2.text = widget.contact!;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            (widget.id != null) ? Text("update Contact") : Text("Add Contact"),
      ),
      body: Column(
        children: [
          TextField(
            controller: t1,
            decoration: InputDecoration(hintText: "Enter Name"),
          ),
          TextField(
            controller: t2,
            decoration: InputDecoration(hintText: "Enter Contact"),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    photo = await picker.pickImage(source: ImageSource.camera);
                    is_upload = true;
                    setState(()     {});
                  },
                  child: Text("upload image")),
              Container(
                  height: 70,
                  width: 70,
                  child: (is_upload)
                      ? Image.file(File(photo!.path))
                      : Icon(Icons.supervised_user_circle_outlined)),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              String name, contact;
              name = t1.text;
              contact = t2.text;
              String img_path = base64UrlEncode(await photo!.readAsBytes());

             if (widget.id != null) {
                var url = Uri.parse(
                    'https://studentcontact1.000webhostapp.com/update_contact.php');
                var response = await http.post(url, body: {
                  'id': '${widget.id}',
                   'name': '$name',
                  'contact': '$contact',

                });
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
              } else {
                var url = Uri.parse(
                    'https://studentcontact1.000webhostapp.com/add_contact.php');
                var response = await http
                    .post(url, body: {'name': '$name', 'contact': '$contact','image':img_path});
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
              }
              // var url = Uri.parse(
              //     'https://studentcontact1.000webhostapp.com/add_contact.php?name=$name&contact=$contact');
              // var response = await http.get(url);
              // print('Response status: ${response.statusCode}');
              // print('Response body: ${response.body}');

            },
            child: (widget.id != null)
                ? Text("update Contact")
                : Text("Add Contact"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Dashboard();
                  },
                ));
              },
              child: Text("View Conatct"))
        ],
      ),
    );
  }
}
