from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

articles = Blueprint('articles', __name__)

@articles.route('/<userID>', methods=['POST'])
def articles_page(userID):
    title = request.form.get("title")
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Post WHERE title = %s", (title))
    result = cursor.fetchone()
    if result == None:
        blank_data = {
            "title": "",
            "contents": "",      
        }
        return make_response(jsonify(blank_data))
    article_data = {
            "title": result[0],
            "contents": result[2],      
        }
    the_response = make_response(jsonify(article_data))
    return the_response


@articles.route('/<userID>/delete', methods=['DELETE'])
def delete_article(userID):
    database = db.connect()
    cursor = database.cursor()
    title = request.form.get("title")
    cursor.execute("DELETE FROM Post WHERE title = %s", (title))
    database.commit()
    return jsonify('', 204)

@articles.route('/<userID>/write', methods=['POST'])
def add_article(userID):
    title = request.form.get("title")
    contents = request.form.get("contents")
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO Post (title, contents) VALUES (%s, %s)", (title, contents))
    cursor.execute("INSERT INTO UserPost (userID, title) VALUES (%s, %s)", (userID, title))
    database.commit()
    return jsonify('Added Post', 201)

@articles.route('/<userID>/edit', methods=['PUT'])
def edit_article(userID):
    title = request.form.get("title")
    contents = request.form.get("contents")
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("UPDATE Post SET contents = %s WHERE title = %s", (contents, title))
    database.commit()
    return jsonify('Updated Post', 206)