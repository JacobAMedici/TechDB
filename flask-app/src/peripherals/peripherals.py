from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


peripherals = Blueprint('peripherals', __name__)

@peripherals.route('/', methods=['GET'])
def peripherals_pages():
    return "peripherals"