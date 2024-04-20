from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


laptops = Blueprint('laptops', __name__)

@laptops.route('/', methods=['GET'])
def laptop_pages():
    return "Laptops"