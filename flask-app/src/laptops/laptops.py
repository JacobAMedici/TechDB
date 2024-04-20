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

@laptops.route('/<laptop_id>', methods=['DELETE'])
def delete_laptop(laptop_id):
    return "This is where we will delete the laptop of laptop_id"

@laptops.route('/add', methods=['POST'])
def add_laptops():
    return "This will add an laptop with the appropriate fields"

@laptops.route('/<laptop_id>', methods=['GET'])
def favorite_laptop(laptop_id):
    return "This is where we will favorite the laptop of laptop_id"