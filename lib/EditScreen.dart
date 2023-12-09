import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Resource/DatabaseHelper.dart';
import 'ViewScreen.dart';
class EditScreen extends StatefulWidget
{

  var updateid="";

   EditScreen ({required this.updateid});
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen>
{
  getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.editTransaction(widget.updateid);
    setState(() {
      _title.text = data[0]["Title"].toString();
      _amount.text = data[0]["Amount"].toString();
      selected = data[0]["Type"].toString();
      _remark.text = data[0]["Remark"].toString();
      _date.text = data[0]["Date"].toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }


  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _date = TextEditingController();
  var selected = "income";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xfffff8e1),
      appBar: AppBar(
        foregroundColor: Colors.red.shade900,
        centerTitle: true,
        toolbarHeight: 70,
        toolbarOpacity: 0.5,
        shadowColor: Colors.orange.shade900,
        elevation: 5.0,
        backgroundColor: Colors.grey.shade100,
        title: Text("Add Transaction"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // color: Colors.black,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          activeColor: Colors.blue,
                          focusColor: Colors.orange,
                          value: "income",
                          groupValue: selected,
                          onChanged: (val){
                            setState(() {
                              selected=val!;
                            });
                          },
                        ),
                        Text("Income",style:TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                        Radio(
                          activeColor: Colors.blue,
                          value: "expense",
                          groupValue: selected,
                          onChanged: (val){
                            setState(() {
                              selected=val!;
                            });
                          },
                        ),
                        Text("Expense",style:TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Text("Title:",style:TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                    SizedBox(
                      width: 330.0,
                      height: 60.0,
                      child: TextField(
                        controller: _title,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text("Amount:",style:TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                    SizedBox(
                      width: 330.0,
                      height: 60.0,
                      child: TextField(
                        controller: _amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text("Remark:",style:TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                    SizedBox(
                      width: 330.0,
                      height: 60.0,
                      child: TextField(
                        controller:_remark,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text("Date:",style:TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                    SizedBox(
                      width: 330.0,
                      height: 60.0,
                      child: TextField(
                        controller: _date,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.date_range_outlined),
                            onPressed: () async
                            {
                              DateTime? datepicker = await showDatePicker(
                                //onDatePickerModeChange: ColorScheme.dark,
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020,1),
                                lastDate: DateTime(2023,12),
                              );
                              if(datepicker!= null){
                                String formattedDate = DateFormat('dd-MM-yyyy').format(datepicker);
                                setState(() {
                                  _date.text = formattedDate.toString();
                                });
                              }
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          width:340.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              var type = selected;
                              var title =  _title.text.toString();
                              var amount = _amount.text.toString();
                              var remark = _remark.text.toString();
                              var date = _date.text.toString();
                              DatabaseHelper obj= DatabaseHelper();
                              var status = await obj.updateTransaction(type,title,amount,remark,date,widget.updateid);
                              if(status==1)
                              {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>ViewScreen())
                                );
                              }
                              else
                              {
                                print("Error");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: ContinuousRectangleBorder(
                                 borderRadius: BorderRadius.circular(11.0),
                              ),
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              )

                            ),
                            child: Container(width:70.0,height:50,child: Center(child: Text("Update"))),

                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );

  }
}
