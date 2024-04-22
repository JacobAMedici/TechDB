from flask import Blueprint, request, jsonify, make_response, current_app, redirect, url_for
import json
from src import db
from werkzeug.security import check_password_hash, generate_password_hash

login = Blueprint('login', __name__)

@login.route('/', methods=['POST'])
def login_user():
    # Ensure username was submitted
    if not request.form.get("username"):
        return make_response(jsonify(message='Must Provide Username'), 400)
    # Ensure password was submitted
    elif not request.form.get("password"):
        return make_response(jsonify(message='Must Provide Password'), 400)
    
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Users WHERE username = %s", (request.form.get("username"),))
    # Fetch one result
    row = cursor.fetchone()
    row_headers = [x[0] for x in cursor.description]

    # Check if the row exists
    if row is None:
        return make_response(jsonify(message='Username Not Found'), 400)
    
    row_dict = dict(zip(row_headers, row))
    
    # Continue with your password check
    if not check_password_hash(row_dict["hash"], request.form.get("password")):
        return make_response(jsonify(message='Invalid Password'), 400)

    # If everything is correct, remember which user has logged in
    userID = row_dict["userID"]

    userInfo = {
        "userID" : userID
    }

    # Return the userID
    return jsonify(userInfo)