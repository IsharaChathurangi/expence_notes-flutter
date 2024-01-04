import 'package:flutter/material.dart';
import 'package:expence_master_yt/models/expence.dart';

class addNewExpences extends StatefulWidget {
  final void Function(ExpenceModel expence) onAddExpence;
  const addNewExpences({super.key, required this.onAddExpence});

  @override
  State<addNewExpences> createState() => _addNewExpencesState();
}

class _addNewExpencesState extends State<addNewExpences> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leasure;
  //datevariables
  final DateTime initialDate = DateTime.now();
  final DateTime firstdate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastdate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  DateTime _selectedDate = DateTime.now();

  //datepicker
  Future<void> _openDataModel() async {
    try {
      //show the data model,store selected date
      final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstdate,
          lastDate: lastdate);

      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  //handle form submit

  void hadleFormSubmit() {
    //form validation
    //convert amount onto a double
    final userAmount = int.parse(_amountController.text.trim());
    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return (AlertDialog(
            title: const Text("enter valid date"),
            content: const Text("please emter valid data for title"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close")
                  ),
            ],
          )
          );
        }
          );
        } 
      else{
          ExpenceModel newExpence=ExpenceModel(amount: userAmount, date: _selectedDate, 
          title: _titleController.text.trim(), 
          category: _selectedCategory);
          widget.onAddExpence(newExpence);
          Navigator.pop(context);
          
          
        }
      
    }
    
  

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          //title text field
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                hintText: "add new expence title", label: Text("tile")),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    helperText: "Enter the amount",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              //amount
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(formattedDate.format(_selectedDate)),
                  IconButton(
                    onPressed: _openDataModel,
                    icon: const Icon(Icons.date_range_outlined),
                  ),
                ],
              ))

              //datepicker
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  }),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //close the model
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 206, 144, 144))),
                    child: const Text("Close"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  //save data
                  ElevatedButton(
                    onPressed: hadleFormSubmit,
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 226, 204, 224))),
                    child: const Text("Save"),
                  ),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
