import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medication_app/model/medication_details.dart';
import 'package:medication_app/provider/medication_provider.dart';
import 'package:medication_app/widgets/CustomMultiLineTextField.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomButton.dart';
import '../widgets/CustomTextField.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _medicationNameController = TextEditingController();
  TextEditingController _dosageController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MedicationList>(context, listen: false).fetchDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Medication App'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<MedicationList>(context, listen: false)
            .fetchDataFromServer(),
        child: Consumer<MedicationList>(
          builder: (context, medicationList, child) {
            return ListView.builder(
              itemCount: medicationList.medicationList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
                    SlidableAction(
                      label: 'Delete',
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      onPressed: (context) {
                        medicationList.removeMedication(
                            medicationList.medicationList[index]);
                      },
                    ),
                  ]),
                  startActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
                    SlidableAction(
                      label: 'Edit',
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                      onPressed: (context) {
                        print(medicationList.medicationList[index].name);
                        String unit =
                            medicationList.medicationList[index].dosageUnits;
                        BottomSheetForMedication(
                          'Edit',
                          context,
                          unit,
                          () {
                            // Edit Medication
                            if (_medicationNameController.text.isNotEmpty &&
                                _dosageController.text.isNotEmpty &&
                                _notesController.text.isNotEmpty) {
                              // Edit Medication
                              Provider.of<MedicationList>(context,
                                      listen: false)
                                  .editMedication(
                                      index,
                                      Medication(
                                        id: DateTime.now().toString(),
                                        name: _medicationNameController.text,
                                        description: _notesController.text,
                                        dosageUnits: unit,
                                        dosage: _dosageController.text,
                                      ))
                                  .then((value) => Navigator.pop(context));
                            }
                          },
                          medicationList.medicationList[index].name,
                          medicationList.medicationList[index].dosage,
                          medicationList.medicationList[index].description,
                        ).then((value) {
                          if (value != null) {
                            medicationList.editMedication(
                              index,
                              Medication(
                                id: medicationList.medicationList[index].id,
                                name: _medicationNameController.text,
                                description: _notesController.text,
                                dosageUnits: unit,
                                dosage: _dosageController.text,
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ]),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        medicationList.medicationList[index].name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Text(
                        medicationList.medicationList[index].description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Text(
                        '${medicationList.medicationList[index].dosage} ${medicationList.medicationList[index].dosageUnits}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Defining value for the dropdown button
          String unit = 'pill';
          // Show Bottom Sheet
          BottomSheetForMedication(
            "Add",
            context,
            unit,
            () {
              // Add Medication
              if (_medicationNameController.text.isNotEmpty &&
                  _dosageController.text.isNotEmpty &&
                  _notesController.text.isNotEmpty) {
                // Add Medication
                Provider.of<MedicationList>(context, listen: false)
                    .addMedication(
                      Medication(
                        id: DateTime.now().toString(),
                        name: _medicationNameController.text,
                        description: _notesController.text,
                        dosageUnits: unit,
                        dosage: _dosageController.text,
                      ),
                    )
                    .then((value) => Navigator.pop(context));
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> BottomSheetForMedication(
      String title, BuildContext context, String unit, Function onPressed,
      [String name = '', String dosage = '', String notes = '']) {
    name != ""
        ? _medicationNameController.text = name
        : _medicationNameController.text = "";
    dosage != ""
        ? _dosageController.text = dosage
        : _dosageController.text = "";
    notes != "" ? _notesController.text = notes : _notesController.text = "";
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 600,
          child: Column(
            children: [
              Text(
                '$title Medication',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Medication Name',
                controller: _medicationNameController,
                initialValue: name,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Dosage',
                      controller: _dosageController,
                      initialValue: dosage,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // scrollview is used to make the dropdown button scrollable
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StatefulBuilder(
                        builder: (context, set) => DropdownButton(
                          style: const TextStyle(
                            color: Color(0xff4B57A3),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          value: unit,
                          items: const [
                            DropdownMenuItem(
                              value: 'pill',
                              child: Text(
                                'pill',
                              ),
                            ),
                            DropdownMenuItem(
                              child: Text('mg'),
                              value: 'mg',
                            ),
                            DropdownMenuItem(
                              child: Text('ml'),
                              value: 'ml',
                            ),
                            DropdownMenuItem(
                              child: Text('g'),
                              value: 'g',
                            ),
                          ],
                          onChanged: (value) {
                            set(() {
                              unit = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomMultiLineTextField(
                controller: _notesController,
                hintText: "Description",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomElevatedButton(
                text: 'Add',
                onPressed: () {
                  onPressed();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
