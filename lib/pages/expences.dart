import 'package:expence_master_yt/models/expence.dart';
import 'package:expence_master_yt/widgets/add_new_expence.dart';
import 'package:expence_master_yt/widgets/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  //expencelist
  final List<ExpenceModel> _expenceList = [
    ExpenceModel(
        amount: 12,
        date: DateTime.now(),
        title: "Football",
        category: Category.leasure),
    ExpenceModel(
        amount: 10,
        date: DateTime.now(),
        title: "Carrot",
        category: Category.food)
  ];
  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };
  //add new expence
  void onAddNewExpence(ExpenceModel expence) {
    setState(() {
      _expenceList.add(expence);
      calCategoryValues();
    });
  }
//remove expence

  void onDeleteExpence(ExpenceModel expence) {
    //store the delete expence
    ExpenceModel deletingExpence = expence;
    //get the expence of the removing expence
    final int removingIndex = _expenceList.indexOf(expence);
    setState(() {
      _expenceList.remove(expence);
      calCategoryValues();
    });

    //show snack bar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Delete Succesful"),
      action: SnackBarAction(
        label: "undo",
        onPressed: () {
          setState(() {
            _expenceList.insert(removingIndex, deletingExpence);
            calCategoryValues();
          });
        },
      ),
    ));
  }

//pie chart
  double foodVal = 0;
  double travelVal = 0;
  double leasureVal = 0;
  double workVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double travelValTotal = 0;
    double leasureValTotal = 0;
    double workValTotal = 0;

    for (final expence in _expenceList) {
      if (expence.category == Category.food) {
        foodValTotal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        leasureValTotal += expence.amount;
      }
      if (expence.category == Category.work) {
        workValTotal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelValTotal += expence.amount;
      }
    }
    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      leasureVal = leasureValTotal;
      workVal = workValTotal;
    });
    //update the data map
    dataMap = {
      "Food": foodVal,
      "Travel": travelVal,
      "Leasure": leasureVal,
      "Work": workVal,
    };
  }

  @override
  void initState() {
    super.initState();
    calCategoryValues();
  }

  //function to open model overlay
  void _openAddExpenceOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return addNewExpences(
          onAddExpence: onAddNewExpence,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expence Master"),
          backgroundColor: const Color.fromARGB(255, 175, 76, 145),
          elevation: 0,
          actions: [
            Container(
              color: const Color.fromARGB(255, 241, 234, 163),
              child: IconButton(
                onPressed: _openAddExpenceOverlay,
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            PieChart(dataMap: dataMap),
            ExpenceList(
              expenceList: _expenceList,
              onDeleteExpence: onDeleteExpence,
            )
          ],
        ));
  }
}
