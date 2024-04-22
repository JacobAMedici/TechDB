# Some set up for the application 
from flask import Flask, redirect, render_template, request, session, g
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)

    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'TechDB'

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def direct_to_login():
        return redirect("/login")
    
    @app.route("/<userID>")
    def welcome(userID):
        return "Welcome to the TechDB!"
    

    # Blueprint stuff
    from src.laptops.laptops import laptops
    from src.login.login import login
    from src.register.register import register
    from src.peripherals.peripherals import peripherals
    from src.phones.phones import phones
    from src.articles.articles import articles

    app.register_blueprint(laptops, url_prefix='/laptops')
    app.register_blueprint(login, url_prefix='/login')
    app.register_blueprint(register, url_prefix='/register')
    app.register_blueprint(peripherals, url_prefix='/peripherals')
    app.register_blueprint(phones, url_prefix='/phones')
    app.register_blueprint(articles, url_prefix='/articles')

    
    # Don't forget to return the app object
    return app

