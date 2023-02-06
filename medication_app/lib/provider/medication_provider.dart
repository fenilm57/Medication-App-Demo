import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medication_app/dbhelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';

import '../model/medication_details.dart';

class MedicationList extends ChangeNotifier {
  List<Medication> _medicationList = [];

  List<Medication> get medicationList => _medicationList;

  static var db, medicationCollection;
  static connect() async {
    db = await Db.create(MONGOURL);
    await db.open();
    inspect(db);
    medicationCollection = db.collection(MEDICATION_COLLECTION);
  }

  Future<void> addMedication(Medication medication) async {
    // final response = await medicationCollection
    //     .insertAll([medication.toJson()]).then((value) {
    //   _medicationList.add(medication);
    //   notifyListeners();
    // });
    _medicationList.add(medication);
    notifyListeners();

    print("Medication added successfully");
  }

  Future<void> fetchDataFromServer() async {
    final response = await medicationCollection.find().toList();
    _medicationList = [];
    // converting response to map
    final extractedData = response.map((medication) {
      return {
        'id': medication['_id'].toString(),
        'name': medication['name'],
        'description': medication['description'],
        'dosage': medication['dosage'],
        'dosageunit': medication['dosageunit'],
      };
    }).toList();
    // _medicationList = extractedData;

    extractedData.forEach((element) {
      _medicationList.add(Medication(
        id: element['id'],
        name: element['name'],
        description: element['description'],
        dosage: element['dosage'],
        dosageUnits: element['dosageunit'],
      ));
    });
    print(extractedData);
    notifyListeners();

    // print(response.toString());
  }

  Future<void> editMedication(int index, Medication medication) async {
    _medicationList[index] = medication;
    notifyListeners();
  }

  void removeMedication(Medication medication) {
    _medicationList.remove(medication);
    notifyListeners();
  }
}
