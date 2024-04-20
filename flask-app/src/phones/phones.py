from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


phones = Blueprint('phones', __name__)

@phones.route('/', methods=['GET'])
def phones_pages():
    return "phones"