from flask import Flask, flash, redirect, render_template, request, session, abort, send_from_directory, jsonify, Response
from flask_cors import CORS
from utils import *
from constants import *
import db_model
import json
from bson.json_util import dumps

def create_app():
    app = Flask(__name__)
    CORS(app)

    @app.errorhandler(404)
    def not_found(e):
        #wlogger.info("Resource not found while processing the request : {}".format(str(e)))
        return jsonify(message="Server could not find the resource to process the request", result=API_FAILED_RESULT)

    @app.errorhandler(Exception)
    def all_exception_handler(error):
        #wlogger.info("Error occured while processing the request : {}".format(str(error)))
        return jsonify(message="Server failed to process the request {}".format(error), result=API_FAILED_RESULT)

    @app.route("/", strict_slashes=False,)
    @app.route("/isos", strict_slashes=False,)
    def index():
        return jsonify(message="InStockOutofStock-ISOS App is running!", result=API_SUCCESS_RESULT), 200


    @app.route("/isos/profile", strict_slashes=False, methods=["PUT", "GET"])
    def profile():

        if request.method == "GET":
            email = request.args.get('email')

            if not validate_input(email):
                return jsonify(message=FIELD_MISSING.format("Email"), result="failed"), 400
            elif not validate_email(email):
                return jsonify(message=FIELD_NOT_VALID.format("Email"), result="failed"), 400

            check_user = db_model.Users.objects(email=email).exclude("id", "create_date", "password").first()
            if not check_user:
                return jsonify(message=USER_NOT_FOUND.format(email), result=API_SUCCESS_RESULT), 200
            else:
                user_model=db_model.model(check_user.to_json())
                return jsonify(user=user_model, result=API_SUCCESS_RESULT), 200

        elif request.method == "PUT":
            try:
                email = request.form.get('email')
                if not validate_input(email):
                    return jsonify(message=FIELD_MISSING.format("Email"), result="failed"), 400
                elif not validate_email(email):
                    return jsonify(message=FIELD_NOT_VALID.format("Email"), result="failed"), 400

                check_user = db_model.Users.objects(email=email).exclude("id", "create_date").first()
                if not check_user:
                    return jsonify(message=USER_NOT_FOUND.format(email), result=API_SUCCESS_RESULT), 403
                else:
                    user_model = db_model.model(check_user.to_json())
                    address = request.form.get('address')
                    name = request.form.get('name')
                    current_password = request.form.get('current_password')
                    new_password = request.form.get('new_password')
                    confirm_password = request.form.get('confirm_password')
                    if confirm_password and new_password and new_password!=confirm_password:
                        return jsonify(message=PASSWORD_MISSMATCH, result=API_SUCCESS_RESULT), 403
                    elif new_password and confirm_password and current_password:
                        check_user = db_model.Users.objects(email=email, password=hash_input(current_password)).exclude("id", "create_date").first()
                        if not check_user:
                            return jsonify(message=LOGIN_FAILED, result=API_SUCCESS_RESULT), 403
                        db_model.Users.objects(email=email).update(password=hash_input(new_password))
                    if address and address!=user_model.get('address'):
                        db_model.Users.objects(email=email).update(address=address)
                    if name:
                        db_model.Users.objects(email=email).update(name=name)
                    return jsonify(message=PROFILE_UPDATE_SUCCESS, result=API_SUCCESS_RESULT), 200
            except Exception as e:
                print(str(e))
                return jsonify(message=PROFILE_UPDATE_FAILED, result=API_FAILED_RESULT), 500



    @app.route("/isos/login", strict_slashes=False, methods=["POST"])
    def login():
        email = request.form.get('email')
        password = request.form.get('password')

        #Validate email input
        if not validate_input(email):
            return jsonify(message=FIELD_MISSING.format("Email"), result="failed"), 400
        elif not validate_email(email):
            return jsonify(message=FIELD_NOT_VALID.format("Email"), result="failed"), 400

        #Validate password input
        if not validate_input(password):
            return jsonify(message=FIELD_MISSING.format("Password"), result="failed"), 400

        #check if user exist!
        check_user = db_model.Users.objects(email=email, password=hash_input(password)).first()
        if not check_user:
            return jsonify(message=LOGIN_FAILED, result=API_SUCCESS_RESULT), 403
        else:
            return jsonify(message=LOGIN_SUCCESS, result=API_SUCCESS_RESULT), 200


    @app.route("/isos/register", strict_slashes=False, methods=["POST"])
    def register():
        name = request.form.get('name')
        email = request.form.get('email')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')

        #Validate name input
        if not validate_input(name):
            return jsonify(message=FIELD_MISSING.format("Name"), result=API_SUCCESS_RESULT), 400

        #Validate email input
        if not validate_input(email):
            return jsonify(message=FIELD_MISSING.format("Email"), result=API_SUCCESS_RESULT), 400
        elif not validate_email(email):
            return jsonify(message=FIELD_NOT_VALID.format("Email"), result=API_SUCCESS_RESULT), 400

        #Validate password input
        if not validate_input(password):
            return jsonify(message=FIELD_MISSING.format("Password"), result=API_SUCCESS_RESULT), 400

        #Validate confirm_password input
        if not validate_input(confirm_password):
            return jsonify(message=FIELD_MISSING.format("Confirm Password"), result=API_SUCCESS_RESULT), 400

        #Validate confirm_password==password input
        if password!=confirm_password:
            return jsonify(message=PASSWORD_MISSMATCH, result=API_SUCCESS_RESULT), 400

        #check if user not registerd!
        check_user = db_model.Users.objects(email=email).first()
        if check_user:
            return jsonify(message=EMAIl_EXIST.format(email), result=API_SUCCESS_RESULT), 400

        try:
            db_model.Users(name=name, email=email, password=hash_input(password)).save()
            return jsonify(result=API_SUCCESS_RESULT, title=REG_SUCCESS_TITLE, message=REG_SUCCESS_MESSAGE.format(email)), 200
        except Exception as e:
            print("Error saving email {}, got error: {}".format(email, str(e)))
            return jsonify(result=API_FAILED_RESULT, error=REG_ERROR_MESSAGE.format(email, str(e))), 400

    return app

if __name__ == '__main__':
    app = create_app()
    app.jinja_env.auto_reload = True
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    app.config['PROPAGATE_EXCEPTIONS'] = True
    app.run(host="0.0.0.0", port=5000)
