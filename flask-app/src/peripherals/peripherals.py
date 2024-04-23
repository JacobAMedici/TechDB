from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

peripherals = Blueprint('peripherals', __name__)

@peripherals.route('/<userID>', methods=['POST'])
def peripherals_page(userID):
    peripheralType = request.form.get("peripheralType")
    if peripheralType == "nothing":
        blank_data = {
            "Please Select A Peripheral Type": "",     
        }
        return make_response(jsonify(blank_data))
    cursor = db.get_db().cursor()
    cursor.execute(f'SELECT * FROM {peripheralType}')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
    
@peripherals.route('/<userID>/<peripheralType>/<peripheral_id>', methods=['GET'])
def display_peripheral(userID, peripheralType, peripheral_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute(f"SELECT * FROM {peripheralType} WHERE peripheralID = {peripheral_id}")
    the_response = make_response(jsonify(cursor.fetchone()))
    return the_response

@peripherals.route('/<userID>/<peripheralType>/<peripheral_id>', methods=['POST'])
def favorite_peripheral(userID, peripheralType, peripheral_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO %s (userID, peripheralID) VALUES (%s, %s)", (peripheralType, userID, peripheral_id))
    database.commit()
    return jsonify('Favorited Peripheral', 201)

@peripherals.route('/<userID>/delete', methods=['DELETE'])
def delete_peripheral(userID):
    database = db.connect()
    cursor = database.cursor()
    peripheralType = request.form.get("peripheralType")
    peripheral_id = request.form.get("peripheralID")
    peripheralID_Column = "tabletID"
    if peripheralType == "Mouse":
        peripheralID_Column = "mouseID"
    if peripheralType == "Keyboard":
        peripheralID_Column = "KeyboardID"
    if peripheralType == "Headphones":
        peripheralID_Column = "HeadphoneID"
    if peripheralID_Column == "Switch":
        peripheralID_Column = "switchID"
    cursor.execute(f"DELETE FROM {peripheralType} WHERE {peripheralID_Column} = {peripheral_id}")
    return jsonify('Deleted Peripheral', 204)

@peripherals.route('/<userID>/add', methods=['POST'])
def add_peripheral(userID):
    database = db.connect()
    cursor = database.cursor()
    peripheralType = request.form.get("peripheralType")
    if peripheralType == "Mouse":
        return redirect("/peripherals/<userID>/add/mouse")
    elif peripheralType == "Keyboard":
        return redirect("/peripherals/<userID>/add/keyboard")
    elif peripheralType == "Headphones":
        return redirect("/peripherals/<userID>/add/headphones")
    elif peripheralType == "Tablet":
        return redirect("/peripherals/<userID>/add/tablet")
    elif peripheralType == "Switch":
        return redirect("/peripherals/<userID>/add/switch")
    
@peripherals.route('/<userID>/add/mouse', methods=['POST'])
def add_mouse(userID):
    database = db.connect()
    cursor = database.cursor()
    description = request.form.get("description")
    sensorType = request.form.get("sensorType")
    size = request.form.get("size")
    weight = request.form.get("weight")
    freeScrolling = request.form.get("freeScrolling")
    mouseName = request.form.get("mouseName")
    cursor.execute("INSERT INTO Mouse(description, sensorType, size, weight, freeScrolling, mouseName) VALUES (%s, %s, %s, %s, %s, %s)", (description, sensorType, size, weight, freeScrolling, mouseName))
    database.commit()
    return jsonify('Added Peripheral', 201)

@peripherals.route('/<userID>/add/keyboard', methods=['POST'])
def add_keyboard(userID):
    database = db.connect()
    cursor = database.cursor()
    backlight = request.form.get("backlight")
    size = request.form.get("size")
    keyboardName = request.form.get("keyboardName")
    switchID = request.form.get("switchID")
    cursor.execute("SELECT MAX(keyboardID) FROM Keyboard")
    keyboardID = cursor.fetchone()[0]
    cursor.execute("INSERT INTO Keyboard (backlight, size, keyboardName) VALUES (%s, %s, %s)", (backlight, size, keyboardName))
    cursor.execute("INSERT INTO UsesSwitch (switchID, keyboardID) VALUES (%s, %s)", (switchID, keyboardID))
    database.commit()
    return jsonify('Added Peripheral', 201)

@peripherals.route('/<userID>/add/headphones', methods=['POST'])
def add_headphones(userID):
    database = db.connect()
    cursor = database.cursor()
    numDrivers = request.form.get("numDrivers")
    bluetooth = request.form.get("bluetooth")
    microphone = request.form.get("microphone")
    description = request.form.get("description")
    headphoneName = request.form.get("headphoneName")
    cursor.execute("INSERT INTO Headphones(numDrivers, bluetooth, microphone, description, headphoneName) VALUES (%s, %s, %s, %s, %s)", (numDrivers, bluetooth, microphone, description, headphoneName))
    database.commit()
    return jsonify('Added Peripheral', 201)

@peripherals.route('/<userID>/add/tablet', methods=['POST'])
def add_tablet(userID):
    database = db.connect()
    cursor = database.cursor()
    length = request.form.get("length")
    depth = request.form.get("depth")
    thickness = request.form.get("thickness")
    horizontalResolution = request.form.get("horizontalResolution")
    verticalResolution = request.form.get("verticalResolution")
    ram = request.form.get("ram")
    storage = request.form.get("storage")
    tabletName = request.form.get("tabletName")
    cursor.execute("INSERT INTO Tablet(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName))
    database.commit()
    return jsonify('Added Peripheral', 201)

@peripherals.route('/<userID>/add/switch', methods=['POST'])
def add_switch(userID):
    database = db.connect()
    cursor = database.cursor()
    description = request.form.get("description")
    actuationForce = request.form.get("actuationForce")
    color = request.form.get("color")
    actuationDistance = request.form.get("actuationDistance")
    switchName = request.form.get("switchName")
    cursor.execute("INSERT INTO Switch (description, actuationForce, color, actuationDistance, switchName) VALUES (%s, %s, %s, %s, %s)", (description, actuationForce, color, actuationDistance, switchName))
    database.commit()
    return jsonify('Added Peripheral', 201)