from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


articles = Blueprint('articles', __name__)

@articles.route('/')
def articles_pages():
    return "This is where a search bar will be and maybe below we will have recomended articles"

@articles.route('/<article_id>', methods=['GET'])
def display_article(article_id):
    return "This is where we will display the article of article_id"

@articles.route('/<article_id>', methods=['DELETE'])
def delete_article(article_id):
    return "This is where we will delete the article of article_id"

@articles.route('/write', methods=['POST'])
def add_article():
    return "This will add an article with the appropriate fields"