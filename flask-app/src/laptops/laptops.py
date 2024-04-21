from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

laptops = Blueprint('laptops', __name__)

@laptops.route('/')
def laptop_pages():
    return "Laptops"

@laptops.route('/<laptop_id>', methods=['GET'])
def display_laptop(laptop_id):
    return "This is where we will display the laptop of laptop_id"
    '''
    SELECT * FROM Laptop WHERE laptopID = <laptop_id>;
    '''

@laptops.route('/<laptop_id>', methods=['DELETE'])
def delete_laptop(laptop_id):
    return "This is where we will delete the laptop of laptop_id"
    '''
    DELETE FROM Laptop WHERE laptopID = <laptop_id>;
    '''

@laptops.route('/add', methods=['POST'])
def add_laptops():
    return "This will add an laptop with the appropriate fields"
    '''
    INSERT INTO Laptop (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batterySize, weight, backlitKeyboard, GPU, CPU, laptopName, operatingSystem)
    VALUES (<length>, <depth>, <thickness>, <horizontalResolution>, <verticalResolution>, <ram>, <storage>, <refreshRate>, <batterySize>, <weight>, <backlitKeyboard>, <GPU>, <CPU>, <laptopName>, <operatingSystem>)
    INSERT INTO MakesLaptop (manufacturerID, laptopID)
    '''

@laptops.route('/<laptop_id>', methods=['GET'])
def favorite_laptop(laptop_id):
    return "This is where we will favorite the laptop of laptop_id"
    '''
    INSERT INTO FavoriteLaptop (userID, laptopID) VALUES (<userID>, <laptop_id>)
    '''