const express = require("express");
const mongoose = require("mongoose");
const Medication = require("./medicationSchema");
const app = express();
app.use(express.json());

const port = 3000;
// route to get all medications
app.get("/medications", async (req, res) => {
  try {
    const medications = await Medication.find();
    res.status(200).json(medications);
  } catch (err) {
    console.log(err);
  }
});
// find by id
app.get("/medications/:id", async (req, res) => {
  try {
    const medication = await Medication.findById(req.params.id);
    res.status(200).json(medication);
  } catch (err) {
    console.log(err);
  }
});

// update by id
app.put("/medications/:id", async (req, res) => {
  try {
    const medication = await Medication.findByIdAndUpdate(
      req.params.id,
      req.body
    );

    //we cannot update medication;
    if (!medication) {
      return res.status(404).send();
    }
    const updatedMedication = await Medication.findById(req.params.id);
    res.status(200).json(updatedMedication);
  } catch (err) {
    console.log(err);
  }
});

app.post("/medications", async (req, res) => {
  try {
    const medication = await Medication.create(req.body);
    res.status(201).json(medication);
  } catch (err) {
    console.log(err);
  }
});

// delete by id
app.delete("/medications/:id", async (req, res) => {
  try {
    const medication = await Medication.findByIdAndDelete(req.params.id);
    if (!medication) {
      return res.status(404).send();
    }
    res.status(200).json(medication);
  } catch (err) {
    console.log(err);
  }
});

mongoose.set("strictQuery", false);

mongoose
  .connect(
    "mongodb+srv://admin:admin@medicationapi.obt5raz.mongodb.net/?retryWrites=true&w=majority"
  )
  .then(() => {
    console.log("Connected to database!");
    app.listen(port, () =>
      console.log(`Example app listening on port ${port}!`)
    );
  })
  .catch(() => {
    console.log("Connection failed!");
  });
