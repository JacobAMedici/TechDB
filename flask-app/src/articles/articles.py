from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

articles = Blueprint('articles', __name__)

@articles.route('/')
def articles_pages():
    return "This is where a search bar will be and maybe below we will have recomended articles"

@articles.route('/<title>', methods=['GET'])
def display_article(title):
    return "This is where we will display the article of title"

@articles.route('/<title>', methods=['DELETE'])
def delete_article(title):
    return "This is where we will delete the article of title"

@articles.route('/write', methods=['POST'])
def add_article():
    return "This will add an article with the appropriate fields"