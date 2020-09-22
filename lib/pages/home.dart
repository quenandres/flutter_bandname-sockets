import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 4),
    Band(id: '3', name: 'Rata blanca', votes: 3),
    Band(id: '4', name: 'Twenty one pilots', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle( color: Colors.black87 )),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(bands[index]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
}

  Widget _bandTile( Band band ) {
    return Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction){
          print('direccion: $direction');
          print('direccion: ${ band.id }');
          // TODO: Llamar el borrado en el server
        },
        background: Container(
          padding: EdgeInsets.only(left: 8.0 ),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Delete band', style: TextStyle(
              color: Colors.white
            ))
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text( band.name.substring(0, 2) ),
            backgroundColor: Colors.blue[100],
          ),
          title: Text( band.name ),
          trailing: Text('${ band.votes }', style: TextStyle(
            fontSize: 20
          )),
          onTap: (){
            print(band.name);
          },
        ),
    );
  }

  addNewBand(){

    final textController = TextEditingController();

    /* if( Platform.isAndroid ){
      //Android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('new band name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed:() => addBandToList( textController.text )
              )
            ],
          );
        },      
      );
    } */

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text('New band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList( textController.text ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dissmised'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
    
  }

  void addBandToList( String name ){
    
    if( name.length > 1 ){
      //Podemos agregar
      this.bands.add(Band(id:DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }

}