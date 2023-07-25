import 'package:flutter/material.dart';

class ListTotal extends StatefulWidget {
  const ListTotal({super.key});

  @override
  State<ListTotal> createState() => _ListTotalState();
}

class _ListTotalState extends State<ListTotal> {


  List<String> name = ['임서희', '최휘빈', '강성구', '탁성건', '허재', '이용준' ];
  late List<bool> _checked;


  @override
  void initState() {
    super.initState();

    _checked = List<bool>.filled(name.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      itemCount: name.length,
      itemBuilder: (context,index){
        return Column(
              children: <Widget>[
                CheckboxListTile(
                    value: _checked[index],
                    title: Text(name[index]),
                    onChanged: (bool? val) {
                      setState(() {
                        _checked[index] = val!;
                      });
                    },
                  ),
              ],
            );
      },

    );



  }
}
