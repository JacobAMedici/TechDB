from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

articles = Blueprint('articles', __name__)

@articles.route('/')
def articles_pages():
    return "This is where a search bar will be and maybe below we will have recomended articles"
    # What would the code look like for this? Would it just redirect when the form is submitted?

@articles.route('/<title>', methods=['GET'])
def display_article(title):
    return "This is where we will display the article of title"
    '''
    SELECT * FROM Post WHERE title = title;
    '''

@articles.route('/<title>', methods=['DELETE'])
def delete_article(title):
    return "This is where we will delete the article of title"
    '''
    DELETE FROM Post WHERE title = <title>;
    '''

@articles.route('/write', methods=['POST'])
def add_article():
    return "This will add an article with the appropriate fields"
    '''
    INSERT INTO Post (title, contents) VALUES (<title>, <contents>)
    INSERT INTO UserPost (userID, title) VALUES (<userID>, <title>)
    '''