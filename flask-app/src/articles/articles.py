from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


articles = Blueprint('articles', __name__)

@articles.route('/', methods=['GET'])
def articles_pages():
    return "Articles"