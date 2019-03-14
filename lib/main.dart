import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const primaryColor = 0xFF9b59b6;

const o = [
  {
    'id': '1',
    'color': Colors.redAccent, 
    'challenge' : 'Falar com alguém na rua' 
  },{
    'id': '2',
    'color': Colors.blue,  
    'challenge' : 'Abraçar alguém' 
  },{
    'id': '3',
    'color': Colors.green,  
    'challenge' : 'Dizer que ama alguém' 
  },{
    'id': '4',
    'color': Colors.yellow,  
    'challenge' : 'Comprar um chocolate para um amigo que você conhece há muito tempo' 
  },{
    'id': '5',
    'color': Colors.orange,  
    'challenge' : 'Pedir perdão' 
  },
];





void main() => runApp(App());


class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App>{
  int count = 0;
  int pageIndex = 0;
  String backgroundImage = '';

  void fetchImage() async {
    var response = await get('https://api.unsplash.com/photos/random?client_id=4cf3959e82fe10e0cb78926997ba03dc8c74f761037124cb369ca86289e295ba');
    print(response.body);
    setState((){backgroundImage = json.decode(response.body)['urls']['regular'].toString();});
  }

  @override
  void initState(){
    super.initState();
    fetchImage();
  }

Widget renderItem(BuildContext context, var item){
    return 
     Container(      
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(backgroundImage),
                fit:BoxFit.cover
              )
            ),           
            height: MediaQuery.of(context).size.height,     
            child:
                Center(                  
                  child: Card(
                    color: new Color(primaryColor),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),                                        
                      child:Text(               
                        item['challenge'],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ) 
                    )
                  )
                ),
          );
  }
  handleChangePage(event){
     setState(()  {
      count += 1;
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pequenos Desafios'),
        ),
        body: Container(
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: o.length,
          onPageChanged: (e){handleChangePage(e);},
          itemBuilder: (BuildContext context, int index){
            return renderItem(context, o[index]);
          },
        )
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(                  
                  child: Icon(Icons.check),                  
                  onPressed: (){fetchImage(); 
                  },
                ),
      )
    );  
  }
}

