from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

peripherals = Blueprint('peripherals', __name__)

@peripherals.route('/<userID>', methods=['GET', 'POST'])
def peripherals_page(userID):
    if request.method == 'GET':
        return "Get Peripherals Page"
    elif request.method == 'POST':
        peripheralID = request.form.get("peripheralID")
        return redirect(f'peripherals/{userID}/{peripheralID}')