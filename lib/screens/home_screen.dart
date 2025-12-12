import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Icon(Icons.home, size: 80, color: Colors.amber,),

            SizedBox( height: 30,),

            Text('Bienvenido', style: TextStyle(fontSize: 24),),

            SizedBox( height: 30,),

            ElevatedButton.icon(onPressed: (){
              Navigator.pushNamed(context, 'details');
            }, label: Text('Ir a detalles'),
            icon: Icon(Icons.info),
            ),

            SizedBox( height: 30,),

            ElevatedButton.icon(onPressed: (){
              Navigator.pushNamed(context, 'settings');
            }, label: Text('Configuración'),
            icon: Icon(Icons.settings),)


          ],
        ),
      ),
    );
  }
}