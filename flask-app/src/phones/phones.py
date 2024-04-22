from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

phones = Blueprint('phones', __name__)

@phones.route('/<userID>', methods=['GET', 'POST'])
def phones_pages(userID):
    if request.method == 'GET':
        return "Get Phones Page"
    elif request.method == 'POST':
        phoneID = request.form.get("phoneID")
        return redirect(f'phones/{userID}/{phoneID}')

@phones.route('/<userID>/<phone_id>', methods=['GET'])
def display_phone(phone_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Phone WHERE phoneID = ?", (phone_id))
    the_response = make_response(jsonify(cursor.fetchone))
    return the_response


@phones.route('/<userID>/<phone_id>', methods=['DELETE'])
def delete_phone(phone_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("DELETE FROM Phone WHERE phoneID = ?", (phone_id))
    return redirect("/phones")

@phones.route('/<userID>/add', methods=['POST'])
def add_phone(phone_id):
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
    batteryLength = request.form.get("batteryLength")
    weight = request.form.get("weight")
    interface = request.form.get("interface")
    phoneName = request.form.get("phoneName")
    cursor.execute("INSERT INTO Phone (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate,batteryLength, weight, interface, phoneName)" +
                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate,batteryLength, weight, interface, phoneName))
    return redirect(f"/phones/{phone_id}")

@phones.route('/<userID>/<phone_id>', methods=['POST'])
def favorite_phone(userID, phone_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO FavoritePhone (userID, phoneID) VALUES (?, ?)", (userID, phone_id))
    return redirect(f"/phones/{userID}/{phone_id}")