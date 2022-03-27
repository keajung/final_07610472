import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data = <dynamic>[];
  List<int> colorCodes = <int>[900,800,700,600,500,400,300,200,100];

  dynamic info;
  final List<String> image =  <String>[];
  final List<String> answer = <String>[];
  final List<String> choice_list =  <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(100),
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _handleClickButton();
                    });
                  },
                  child: const Text('LOAD FOODS DATA'),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: image.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.network('${image[index]}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(

                              /*children: [
                                Text(choice_list[index] , style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 15)),
                                Text('${choice_list[index].toString()} บาท' , style: TextStyle(fontSize: 13)),
                              ],*/
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
  _handleClickButton() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    var result = await http.get(url, headers: {'id' : '07610472'});
    var json = jsonDecode(result.body);

    print(json);

    data = json['data'];
    for(int i=0;i<data.length;++i){
      info = data[i];
      image.add(info['image']);
      answer.add(info['answer']);
      choice_list.add(info['choice_list']);
    }

  }
}

