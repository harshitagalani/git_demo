import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';
import 'modal.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  get_data() async {
    var url =
        Uri.parse('https://studentcontact1.000webhostapp.com/view_contact.php');
    var response = await http.get(url);
    List l = jsonDecode(response.body);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Contact"),
      ),
      body: FutureBuilder(
          future: get_data(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              List l = snapshot.data as List;
              {
                return ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    modal m=modal.fromJson(l[index]);
                    return Card(
                      child: ListTile(
                        trailing: Wrap(children: [
                          IconButton(onPressed: () async {
                            var url =
                            Uri.parse('https://studentcontact1.000webhostapp.com/delete_contact.php?id=${l[index]['id']}');
                            var response = await http.get(url);

                            print("msg:${response.body}");
                            setState(() {

                            });
                          }, icon: Icon(Icons.delete)
                          ),
                          IconButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Home(l[index]['id'],l[index]['name'],l[index]['contact']);
                            },));
                          }, icon: Icon(Icons.edit))
                        ],),
                        title: Text("${m.name}"),
                        subtitle: Text("${m.contact}"),
                      ),
                    );
                  },
                );
              }
            } else {
              return Text("");
            }
          }),
    );
  }
}



















































































