from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


login = Blueprint('login', __name__)

@login.route('/', methods=['GET'])
def login_pages():
    return "login"