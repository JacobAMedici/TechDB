from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db
from werkzeug.security import check_password_hash, generate_password_hash

login = Blueprint('login', __name__)

@login.route('/', methods=['POST'])
def login_user():
    # Ensure username was submitted
    if not request.form.get("username"):
        raise Exception("Must Provide Username")
    # Ensure password was submitted
    elif not request.form.get("password"):
        raise Exception("Must Provide Password")
    
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Users WHERE username = %s", (request.form.get("username"),))
    # Fetch one result
    row = cursor.fetchone()
    # Check if the row exists
    if row is None:
        raise Exception("Username Not Found")
    # Continue with your password check
    if not check_password_hash(row["hash"], request.form.get("password")):
        raise Exception("Invalid Password")

    # If everything is correct, remember which user has logged in
    userID = row["userID"]

    # Redirect user to home page
    return redirect(f"/{userID}")

@login.route('/', methods=['GET'])
def login_page():
    # TODO: Make this return the login page
    return "Login page"