from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

laptops = Blueprint('laptops', __name__)

@laptops.route('/<userID>', methods=['GET', 'POST'])
def laptop_page(userID):
    if request.method == 'GET':
        return "Get Laptops Page"
    elif request.method == 'POST':
        laptopID = request.form.get("laptopID")
        return redirect(f'laptops/{userID}/{laptopID}')


@laptops.route('/<userID>/<laptop_id>', methods=['GET'])
def display_laptop(laptop_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Laptop WHERE laptopID = %i", (laptop_id))
    the_response = make_response(jsonify(cursor.fetchone))
    return the_response

@laptops.route('/<userID>/<laptop_id>', methods=['DELETE'])
def delete_laptop(laptop_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("DELETE FROM Laptop WHERE laptopID = %i", (laptop_id))
    return redirect("/laptops")

@laptops.route('/<userID>/add', methods=['POST'])
def add_laptops():
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
                   "VALUES (%f, %f, %f, %i, %i, %i, %i, %f, %f, %f, %s, %s, %s, %s, %s)", (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batterySize, weight, backlitKeyboard, GPU, CPU, laptopName, operatingSystem))

    return redirect(f"/laptops/<userID>")

@laptops.route('/<userID>/<laptop_id>', methods=['POST'])
def favorite_laptop(userID, laptop_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO FavoriteLaptop (userID, laptopID) VALUES (%i, %i)", (userID, laptop_id))
    return redirect(f"/laptops/{userID}/{laptop_id}")
