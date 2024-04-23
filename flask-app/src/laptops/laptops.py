from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

laptops = Blueprint('laptops', __name__)

@laptops.route('/<userID>', methods=['GET'])
def laptop_page(userID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Laptop')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# @laptops.route('/<userID>/<laptop_id>', methods=['GET'])
# def display_laptop(userID, laptop_id):
#     database = db.connect()
#     cursor = database.cursor()
#     cursor.execute("SELECT * FROM Laptop WHERE laptopID = %s", (laptop_id))
#     laptop = cursor.fetchone()
#     laptop_data = {
#         "laptopID": laptop[0],
#         "length": laptop[1],
#         "depth": laptop[2],
#         "thickness": laptop[3],
#         "horizontalResolution": laptop[4],
#         "verticalResolution": laptop[5],
#         "ram":laptop[6],
#         "storage": laptop[7],
#         "refreshRate": laptop[8],
#         "batterySize": laptop[9],
#         "weight": laptop[10],
#         "backlitKeyboard": laptop[11],
#         "GPU": laptop[12],
#         "CPU": laptop[13],
#         "laptopName": laptop[14],
#         "operatingSystem": laptop[15]
#     }
#     the_response = make_response(jsonify(laptop_data))
#     return the_response

@laptops.route('/<userID>/delete', methods=['DELETE'])
def delete_laptop(userID):
    database = db.connect()
    cursor = database.cursor()
    laptop_id = request.form.get("laptopID")
    cursor.execute(f"DELETE FROM Laptop WHERE laptopID = {laptop_id}")
    database.commit()
    return jsonify('', 204)

@laptops.route('/<userID>/add', methods=['POST'])
def add_laptops(userID):
    database = db.connect()
    cursor = database.cursor()
    length = request.form.get("length")
    depth = request.form.get("depth")
    thickness = request.form.get("thickness")
    horizontalResolution = request.form.get("horizontalResolution")
    verticalResolution = request.form.get("verticalResolution")
    ram = request.form.get("ram")
    storage = request.form.get("storage")
    refreshRate = request.form.get("refreshRate")
    batterySize = request.form.get("batterySize")
    weight = request.form.get("weight")
    backlitKeyboard = request.form.get("backlitKeyboard")
    GPU = request.form.get("GPU")
    CPU = request.form.get("CPU")
    laptopName = request.form.get("laptopName")
    operatingSystem = request.form.get("operatingSystem")
    cursor.execute("INSERT INTO Laptop (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batterySize, weight, backlitKeyboard, GPU, CPU, laptopName, operatingSystem)" +
                   "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batterySize, weight, backlitKeyboard, GPU, CPU, laptopName, operatingSystem))
    database.commit()
    return jsonify('Fresh Laptop', 201)

# @laptops.route('/<userID>/<laptop_id>', methods=['POST'])
# def favorite_laptop(userID, laptop_id):
#     database = db.connect()
#     cursor = database.cursor()
#     cursor.execute("INSERT INTO FavoriteLaptop (userID, laptopID) VALUES (%s, %s)", (userID, laptop_id))
#     database.commit()
#     return redirect('Newly Favorited Laptop', 201)
