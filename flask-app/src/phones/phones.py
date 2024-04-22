from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

phones = Blueprint('phones', __name__)

@phones.route('/<userID>', methods=['GET', 'POST'])
def phones_pages(userID):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT * FROM Phone')
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    elif request.method == 'POST':
        phoneID = request.form.get("phoneID")
    return redirect(f'/phones/{userID}/{phoneID}')

@phones.route('/<userID>/<phone_id>', methods=['GET', 'POST'])
def display_phone(userID, phone_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Phone WHERE phoneID = %s", (int(phone_id)))
    result = cursor.fetchone()
    phone_data = {
            "phoneID" : result[0],
            "length" : result[1],
            "depth" : result[2],
            "thickness" : result[3],
            "horizontalResolution" : result[4],
            "verticalResolution" : result[5],
            "ram" : result[6],
            "storage" : result[7],
            "refreshRate" : result[8],
            "batteryLength" : result[9],
            "weight" : result[10],
            "interface" : result[11],
            "phoneName" : result[12],
        }
    the_response = make_response(jsonify(phone_data))
    return the_response


@phones.route('/<userID>/<phone_id>', methods=['DELETE'])
def delete_phone(phone_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("DELETE FROM Phone WHERE phoneID = %s", (int(phone_id)))
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
                   "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batteryLength, weight, interface, phoneName))
    return redirect(f"/phones/{phone_id}")

@phones.route('/<userID>/<phone_id>', methods=['POST'])
def favorite_phone(userID, phone_id):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO FavoritePhone (userID, phoneID) VALUES (%s, %s)", (userID, phone_id))
    return redirect(f"/phones/{userID}/{phone_id}")