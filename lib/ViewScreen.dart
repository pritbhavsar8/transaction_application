import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transaction_application/NetBalance.dart';

import 'AddScreen.dart';
import 'EditScreen.dart';
import 'Resource/DatabaseHelper.dart';

class ViewScreen extends StatefulWidget
{

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen>
{
  Future<List>? alldata;
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata=getdata();
    });
  }

  Future<List> getdata() async
  {
    var obj = DatabaseHelper();
    var data = await obj.viewTransaction();
    return data;
  }

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      backgroundColor:  Color(0xfffff8e1),
      appBar: AppBar(
        title: Text("View Transaction"),
        centerTitle: true,
        foregroundColor: Colors.red.shade900,
        toolbarHeight: 70,
        toolbarOpacity: 0.5,
        shadowColor: Colors.orange.shade900,
        elevation: 5.0,
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NetBalance(),)
                );
              },
              icon: Icon(Icons.list_rounded),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add',
        backgroundColor: Colors.orange,
        splashColor: Colors.yellowAccent,
       foregroundColor: Colors.red.shade900,
        shape: CircleBorder(),
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddScreen(),)
          );
        },
        child: Icon(Icons.add,size: 25.0,),
      ),
      body:   FutureBuilder(
        future: alldata,
        builder: (context,snapshots)
        {
          if(snapshots.hasData)
          {
            if(snapshots.data!.length <=0 )
            {
              return Center(
                  child: Text("No Data",style:TextStyle(
                    color: Colors.red,
                  ),
                  ));
            }
            else
            {
              return ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context,index)
                {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: (snapshots.data![index]["Type"].toString()=="income")?Colors.green.shade100:Colors.red.shade100,
                    ),
                    child: Column(
                      children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(snapshots.data![index]["Title"].toString()),
                           Text(snapshots.data![index]["Amount"].toString()),
                         ],
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshots.data![index]["Type"].toString()),
                            Text(snapshots.data![index]["Date"].toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(snapshots.data![index]["Remark"].toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: () async
                            {
                              var id = snapshots.data![index]["tid"].toString();
                              var obj = new DatabaseHelper();
                              var status = await obj.deleteTransaction(id);
                              if(status==1)
                              {
                                setState(() {
                                  alldata=getdata();
                                });
                              }
                              else
                              {
                                print("Not Deleted");
                              }

                            }, child: Icon(Icons.delete),),
                            SizedBox(width: 20.0,),
                            ElevatedButton(
                                onPressed: (){
                                  var id = snapshots.data![index]["tid"].toString();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => EditScreen(
                                      updateid: id,
                                    ),),
                                  );
                                },
                                child: Icon(Icons.edit),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );

                },
              );
            }
          }
          else
          {
            return Center(
                child: Text("Loading...")
            );
          }
        },
      ),


    );
  }
}
