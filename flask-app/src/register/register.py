from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


register = Blueprint('register', __name__)

@register.route('/', methods=['GET'])
def register_pages():
    return "register"

@register.route('/add', methods=['POST'])
def add_user():
    return "This will add and validate a user with the appropriate fields"
    '''
    INSERT INTO Users (firstname, lastname, email, username, hash) VALUES (<firstname>, <lastname>, <email>, <username>, <hash>);
    '''