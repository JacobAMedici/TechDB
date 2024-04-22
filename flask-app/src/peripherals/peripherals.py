from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

peripherals = Blueprint('peripherals', __name__)

@peripherals.route('/<userID>', methods=['GET', 'POST'])
def peripherals_page(userID):
    if request.method == 'GET':
        return "Get Peripherals Page"
    elif request.method == 'POST':
        peripheralType = request.form.get("peripheralType")
        peripheralID = request.form.get("peripheralID")
        return redirect(f'peripherals/{userID}/{peripheralType}/{peripheralID}')
    
@peripherals.route('/<userID>/<peripheralType>/<peripheral_id>', methods=['GET'])
def display_peripheral(userID, peripheralType, peripheral_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute(f"SELECT * FROM {peripheralType} WHERE peripheralID = ?", (peripheral_id))
    the_response = make_response(jsonify(cursor.fetchone()))
    return the_response

@peripherals.route('/<userID>/<peripheralType>/<peripheral_id>', methods=['POST'])
def favorite_peripheral(userID, peripheralType, peripheral_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO (?) (userID, peripheralID) VALUES (?, ?)", (peripheralType, userID, peripheral_id))
    return redirect(f"/peripherals/{userID}/{peripheralType}/{peripheral_id}")

@peripherals.route('/<userID>/<peripheralType>/<peripheral_id>', methods=['DELETE'])
def delete_peripheral(userID, peripheralType, peripheral_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute(f"DELETE FROM {peripheralType} WHERE peripheralID = ?", (peripheral_id))
    return redirect("/peripherals")

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
    cursor.execute("INSERT INTO Mouse(description, sensorType, size, weight, freeScrolling, mouseName) VALUES (?, ?, ?, ?, ?, ?)", (description, sensorType, size, weight, freeScrolling, mouseName))
    return redirect(f"/peripherals/{userID}")

@peripherals.route('/<userID>/add/keyboard', methods=['POST'])
def add_keyboard(userID):
    database = db.connect()
    cursor = database.cursor()
    backlight = request.form.get("backlight")
    size = request.form.get("size")
    keyboardName = request.form.get("keyboardName")
    switchID = request.form.get("switchID")
    cursor.execute("SELECT MAX(keyboardID) FROM Keyboard")
    keyboardID = cursor.fetchone()[0] + 1
    cursor.execute("INSERT INTO Keyboard (backlight, size, keyboardName) VALUSES (?, ?, ?)", (backlight, size, keyboardName))
    cursor.execute("INSERT INTO Switches (switchID, keyboardID) VALUES (?, ?)", (switchID, keyboardID))
    return redirect(f"/peripherals/{userID}")

@peripherals.route('/<userID>/add/headphones', methods=['POST'])
def add_headphones(userID):
    database = db.connect()
    cursor = database.cursor()
    numDrivers = request.form.get("numDrivers")
    bluetooth = request.form.get("bluetooth")
    microphone = request.form.get("microphone")
    description = request.form.get("description")
    headphoneName = request.form.get("headphoneName")
    cursor.execute("INSERT INTO Headphones(numDrivers, bluetooth, microphone, description, headphoneName) VALUES (?, ?, ?, ?, ?)", (numDrivers, bluetooth, microphone, description, headphoneName))
    return redirect(f"/peripherals/{userID}")

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
    cursor.execute("INSERT INTO Tablet(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName))
    return redirect(f"/peripherals/{userID}")

@peripherals.route('/<userID>/add/switch', methods=['POST'])
def add_switch(userID):
    database = db.connect()
    cursor = database.cursor()
    description = request.form.get("description")
    actuationForce = request.form.get("actuationForce")
    color = request.form.get("color")
    actuationDistance = request.form.get("actuationDistance")
    switchName = request.form.get("switchName")
    cursor.execute("INSERT INTO Switch (description, actuationForce, color, actuationDistance, switchName) VALUES (?, ?, ?, ?, ?)", (description, actuationForce, color, actuationDistance, switchName))
    return redirect(f"/peripherals/{userID}")