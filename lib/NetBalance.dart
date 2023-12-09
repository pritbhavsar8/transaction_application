import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transaction_application/Resource/DatabaseHelper.dart';

class NetBalance extends StatefulWidget {
  const NetBalance({Key? key}) : super(key: key);

  @override
  State<NetBalance> createState() => _NetBalanceState();
}

class _NetBalanceState extends State<NetBalance> {


  var income=0.0,expence=0.0,balance=0.0;


  getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getincome();
    data.forEach((row) {
      setState(() {
        income = income + double.parse(row["Amount"].toString());
      });
    });
    var edata = await obj.getexpenses();
    edata.forEach((row) {
      setState(() {
        expence = expence + double.parse(row["Amount"].toString());
      });
    });
    setState(() {
      balance = income - expence;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red.shade900,
        centerTitle: true,
        toolbarHeight: 70,
        toolbarOpacity: 0.5,
        shadowColor: Colors.orange.shade900,
        elevation: 5.0,
        backgroundColor: Colors.grey.shade100,
        title: Text("Net Balance"),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Income: " + income.toString()),
          Text("Expence:" + expence.toString()),
          Text("Total Balance: "+balance.toString()),
        ],
      ),
    );
  }
}
