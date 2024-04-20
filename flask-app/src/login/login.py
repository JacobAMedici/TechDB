from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


login = Blueprint('login', __name__)

@login.route('/')
def login_pages():
    return "login"

@login.route('/<username>', methods=['GET'])
def sign_in(username):
    return "This will start the session of the user with that username and validate their login"