from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


peripherals = Blueprint('peripherals', __name__)

@peripherals.route('/')
def peripherals_pages():
    return "This will be a dropdown menu of peripheral options"

@peripherals.route('/mice')
def mice_page():
    return "This will be a search bar for mice"

@peripherals.route('/mice/<mouse_id>', methods=['GET'])
def display_mouse(mouse_id):
    return "This is where we will display the mouse of mouse_id"

@peripherals.route('/mice/<mouse_id>', methods=['DELETE'])
def delete_mouse(mouse_id):
    return "This is where we will delete the mouse of mouse_id"

@peripherals.route('/mice/add', methods=['POST'])
def add_mouse():
    return "This will add a mouse with the appropriate fields"

@peripherals.route('/keyboards')
def keyboards_page():
    return "This will be a search bar for keyboards"

@peripherals.route('/keyboards/<keyboard_id>', methods=['GET'])
def display_keyboard(keyboard_id):
    return "This is where we will display the keyboard of keyboard_id"

@peripherals.route('/keyboards/<keyboard_id>', methods=['DELETE'])
def delete_keyboard(keyboard_id):
    return "This is where we will delete the keyboard of keyboard_id"

@peripherals.route('/keyboards/add', methods=['POST'])
def add_keyboard():
    return "This will add a keyboard with the appropriate fields"

@peripherals.route('/headsets')
def headsets_page():
    return "This will be a search bar for headsets"

@peripherals.route('/headsets/<headset_id>', methods=['GET'])
def display_headset(headset_id):
    return "This is where we will display the headset of headset_id"

@peripherals.route('/headsets/<headset_id>', methods=['DELETE'])
def delete_headset(headset_id):
    return "This is where we will delete the headset of headset_id"

@peripherals.route('/headsets/add', methods=['POST'])
def add_headset():
    return "This will add a headset with the appropriate fields"

@peripherals.route('/tablets') 
def tablets_page():
    return "This will be a search bar for tablets"

@peripherals.route('/tablets/<tablet_id>', methods=['GET'])
def display_tablet(tablet_id):
    return "This is where we will display the tablet of tablet_id"

@peripherals.route('/tablets/<tablet_id>', methods=['DELETE'])
def delete_tablet(tablet_id):
    return "This is where we will delete the tablet of tablet_id"

@peripherals.route('/tablets/add', methods=['POST'])
def add_tablet():
    return "This will add a tablet with the appropriate fields"