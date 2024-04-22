from flask import Blueprint, request, jsonify, make_response, current_app, redirect
import json
from src import db

articles = Blueprint('articles', __name__)

@articles.route('/<userID>', methods=['GET', 'POST'])
def articles_page(userID):
    if request.method == 'GET':
        return "Articles Page With Search Bar"
    elif request.method == 'POST':
        title = request.form.get("title")
        return redirect(f"/articles/{userID}/{title}")

@articles.route('/<userID>/<title>', methods=['GET', 'POST'])
def display_article(userID, title):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("SELECT * FROM Post WHERE title = %s", (title))
    result = cursor.fetchone()
    article_data = {
            "title": result[0],
            "contents": result[2],      
        }
    the_response = make_response(jsonify(article_data))
    return the_response


@articles.route('/<userID>/<title>', methods=['DELETE'])
def delete_article(userID, title):
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("DELETE FROM Post WHERE title = %s", (title))
    return redirect("/articles")

@articles.route('/<userID>/write', methods=['GET'])
def articles_writing_page(userID):
    return "Article Writing Page"

@articles.route('/<userID>/write', methods=['POST'])
def add_article(userID):
    title = request.form.get("title")
    contents = request.form.get("contents")
    database = db.connect()
    cursor = database.cursor()
    cursor.execute("INSERT INTO Post (title, contents) VALUES (%s, %s)", (title, contents))
    cursor.execute("INSERT INTO UserPost (userID, title) VALUES (%i, %s)", (userID, title))
    return redirect(f"/articles/{userID}/{title}")