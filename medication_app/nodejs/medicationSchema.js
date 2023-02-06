const mongoose = require("mongoose");

const medicationModel = mongoose.Schema(
  {
    name: { type: String, required: [true, "Please Enter Name"] },
    description: { type: String, required: [true, "Please Enter Description"] },
    dosage: { type: String, required: [true, "Please Enter Dosage"] },
    dosageunit: { type: String, required: [true, "Please Enter Frequency"] },
  },
  { timestamps: true }
);

const Medication = mongoose.model("Medication", medicationModel);

module.exports = Medication;
