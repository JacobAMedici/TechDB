from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db
from werkzeug.security import generate_password_hash

register = Blueprint('register', __name__)

@register.route('/', methods=['POST'])
def add_user():
    database = db.connect()
    cursor = database.cursor()

    c = 0 # Of special Chars
    s = '[@_!#$%^&*()<>?/}{~:]' # special character set
    for i in range(len(request.form.get("password"))):
    # checking if any special character is present in given string or not
        if request.form.get("password")[i] in s:
            c += 1
    didg = 0
    # Of nums
    for i in range(len(request.form.get("password"))):
        if request.form.get("password")[i].isdigit:
            didg += 1
            pass_len = len(request.form.get("password"))
    # Ensure firstName was submitted
    if not request.form.get("firstName"):
        return make_response(jsonify(message='Must Provide First Name'), 400)
    # Ensure lastName was submitted
    if not request.form.get("lastName"):
        return make_response(jsonify(message='Must Provide Last Name'), 400)
    # Ensure email was submitted
    if not request.form.get("email"):
        return make_response(jsonify(message='Must Provide Email'), 400)
    # Ensure username was submitted
    if not request.form.get("username"):
        return make_response(jsonify(message='Must Provide Username'), 400)
    # Check if username is taken
    elif len((cursor().execute("SELECT * FROM users WHERE username = %s", (request.form.get("username"),))).fetchall()) > 0:
        return make_response(jsonify(message='Username is Taken'), 400)
    elif c < 1 or didg < 1 or pass_len < 8:
        return make_response(jsonify(message='Password Must Fit Reqirements'), 400)
    # Ensure password was submitted
    elif not request.form.get("password"):
        return make_response(jsonify(message='Must Provide Password'), 400)
    # Ensure confirm was submitted
    elif not request.form.get("confirmation"):
        return make_response(jsonify(message='Must Confirm Password'), 400)
    # Make sure passwords match
    elif request.form.get("confirmation") != request.form.get("password"):
        return make_response(jsonify(message='Passwords Must Match'), 400)
    # Put it in the data base and return to the home page
    elif request.form.get("confirmation") == request.form.get("password"):
        firstName = request.form.get("firstName")
        lastName = request.form.get("lastName")
        email = request.form.get("email")
        user = request.form.get("username")
        # Code for the next two lines is inspired by DinoCoderSaurus at https://cs50.stackexchange.com/questions/34666/finance-pset-register-will-not-insert-user-data
        hashed_pass = generate_password_hash(request.form.get("password"))
        newUserInfo = ({"firstName" : firstName, "lastName" : lastName, "email" : email, "username" : user, "hash" : hashed_pass})

        # Get highest userID before
        cursor.execute("SELECT MAX(userID) FROM users")
        highestUserID = cursor.fetchone()[0] + 1

        cursor.execute("INSERT INTO users ('firstName', 'lastName', 'email', 'username', 'hash') VALUES (:firstName, :lastName, :email, :username, :hash)", newUserInfo)
        # Commit the transaction
        cursor.commit()
        cursor.execute("SELECT userID FROM users WHERE username = %s", (request.form.get("username"),))

        userData = {
            "userID" : highestUserID
        }

        return userData