from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

phones = Blueprint('phones', __name__)

@phones.route('/', methods=['GET'])
def phones_pages():
    return "phones"

@phones.route('/<phone_id>', methods=['GET'])
def display_phone(phone_id):
    return "This is where we will display the phone of phone_id"
    '''
    SELECT * FROM Phone WHERE phoneID = <phone_id>;
    '''

@phones.route('/<phone_id>', methods=['DELETE'])
def delete_phone(phone_id):
    return "This is where we will delete the phone of phone_id"
    '''
    DELETE FROM Phone WHERE phoneID = <phone_id>;
    '''

@phones.route('/add', methods=['POST'])
def add_phone():
    return "This will add a phone with the appropriate fields"
    '''
    INSERT INTO Phone(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate,batteryLength, weight, interface, phoneName) VALUES (<length>, <depth>, <thickness>, <horizontalResolution>, <verticalResolution>, <ram>, <storage>, <refreshRate>, <batteryLength>, <weight>, <interface>, <phoneName>)
    INSERT INTO MakesPhone(manufacturerID, phoneID)
    '''

@phones.route('/<phone_id>', methods=['POST'])
def favorite_phone(phone_id):
    return "This is where we will favorite the phone of phone_id"
    '''
    INSERT INTO FavoritePhone(userID, phoneID) VALUES (<userID>, <phone_id>)
    '''