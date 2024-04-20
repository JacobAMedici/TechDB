from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


register = Blueprint('register', __name__)

@register.route('/', methods=['GET'])
def register_pages():
    return "register"