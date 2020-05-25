from flask import Flask, flash, redirect, render_template, request, session, abort, send_from_directory, jsonify, Response
from flask_cors import CORS
from utils import *
from constants import *
import db_model
import json
from bson.json_util import dumps
import config
import boto3
import os
import jwt
import datetime
from werkzeug.utils import secure_filename
from functools import wraps
import uuid

UPLOAD_FOLDER = 'uploads/'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}
dpp_url = "https://isos-backend.s3.us-east-2.amazonaws.com/images/users/dpp.jpg"

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY']='Th1s1ss3cr3t'
    #app.config['MAX_CONTENT_LENGTH'] = 20 * 1024 * 1024
    app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
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

    def token_required(f):
       @wraps(f)
       def decorator(*args, **kwargs):

          token = None
          current_user = None

          if 'x-access-tokens' in request.headers:
             token = request.headers['x-access-tokens']

          print(token)

          if not token:
             return jsonify({'message': 'a valid token is missing'}), 403

          try:
             data = jwt.decode(token, app.config['SECRET_KEY'])
             current_user = db_model.Users.objects(public_id="{public_id}".format(public_id=data['public_id'])).exclude("id", "create_date", "password").first()
          except Exception as ex:
             print(ex)
             return jsonify({'message': 'token is invalid'}), 403
          return f(current_user, *args, **kwargs)
       return decorator

    def allowed_file(filename):
        return '.' in filename and \
               filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

    def upload_file(file_name, bucket):
        object_name = file_name
        s3_client = boto3.client('s3')
        response = s3_client.upload_file(file_name, bucket, object_name)
        return response

    @app.route("/isos/profile", strict_slashes=False, methods=["PUT", "GET", "PATCH"])
    @token_required
    def profile(current_user):

        if request.method == "PATCH":
            user_id = current_user.public_id
            if 'file' not in request.files:
                return jsonify(message=FIELD_MISSING.format("Profile Pic"), result="failed"), 400

            file = request.files['file']
            if file.filename == '':
                return jsonify(message=FIELD_MISSING.format("Profile Pic"), result="failed"), 400

            ext =file.filename.rsplit('.', 1)[1].lower()
            filename = "{public_id}.{ext}".format(public_id=current_user.public_id,ext=ext)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

            """
            conn = S3Connection(config.S3_KEY, config.S3_SECRET)
            bucket = conn.get_bucket(config.S3_BUCKET_NAME)
            k = Key(bucket)
            k.key = 'images/users/{user_id}.jpg'.format(user_id=user_id)
            k.set_contents_from_string(data_file.read())
            """
            db_model.Users.objects(email=current_user.email).update(profile_pic=app.config['UPLOAD_FOLDER']+filename)
            return jsonify(message=PROFILE_UPDATE_SUCCESS, result=API_SUCCESS_RESULT), 200

        elif request.method == "GET":
            email = current_user.email#request.args.get('email')
            if not validate_input(email):
                return jsonify(message=FIELD_MISSING.format("Email"), result="failed"), 400
            elif not validate_email(email):
                return jsonify(message=FIELD_NOT_VALID.format("Email"), result="failed"), 400

            check_user = db_model.Users.objects(email=email).exclude("id", "create_date", "password", "public_id").first()
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
            token = jwt.encode({'public_id': check_user.public_id, 'exp' : datetime.datetime.utcnow() + datetime.timedelta(days=30)}, app.config['SECRET_KEY'])
            return jsonify(token=token.decode('UTF-8'), message=LOGIN_SUCCESS, result=API_SUCCESS_RESULT), 200


    def create_commodity(public_id, name, brand=None):
        check_commodity = db_model.Commodity.objects(name=name.lower()).first()
        if check_commodity:
            return check_commodity
        else:
            db_model.Commodity(name=name.lower(), brand=brand, public_id=public_id).save()
            check_commodity = db_model.Commodity.objects(name=name.lower()).first()
            return check_commodity

    def create_store(public_id, name, address=None):
        check_store = db_model.Store.objects(name=name.lower()).first()
        if check_store:
            return check_store
        else:
            db_model.Store(name=name.lower(), address=address, public_id=public_id).save()
            check_store = db_model.Store.objects(name=name.lower()).first()
            return check_store

    @app.route("/isos/comments", strict_slashes=False, methods=["POST", "GET"])
    @token_required
    def comments(current_user):

        public_id = current_user.public_id

        if request.method == "POST":

            store_name = request.form.get('store_name')
            commodity_name = request.form.get('commodity_name')

            #Validate name input
            if not validate_input(store_name):
                return jsonify(message=FIELD_MISSING.format("Store Name"), result=API_SUCCESS_RESULT), 400

            #Validate name input
            if not validate_input(commodity_name):
                return jsonify(message=FIELD_MISSING.format("Commodity Name"), result=API_SUCCESS_RESULT), 400

            commodity = create_commodity(public_id, commodity_name)
            store = create_store(public_id, store_name)

            db_model.Comments(commodity=commodity, store=store, public_id=public_id).save()

            return jsonify(result=API_SUCCESS_RESULT), 200

        elif request.method == "GET":

            check_comments = db_model.Comments.objects.exclude("id").only("commodity", "store", "comment_id", "is_available")

            comment_model = {}
            for cc in check_comments:
                if not comment_model.get(cc.commodity.name):
                    comment_model[cc.commodity.name] = [{"store_name": cc.store.name, "store_address": cc.store.address, "is_available": cc.is_available , "cid":cc.comment_id, "create_date": cc.create_date}]
                else:
                    c_list = comment_model.get(cc.commodity.name)
                    c_list.append({"store_name": cc.store.name, "store_address": cc.store.address, "is_available": cc.is_available , "cid":cc.comment_id, "create_date": cc.create_date})

            if comment_model:
                return jsonify(data=comment_model, result=API_SUCCESS_RESULT), 200
            else:
                return jsonify(result=API_SUCCESS_RESULT, data=[]), 200


    @app.route("/isos/commodityrequest", strict_slashes=False, methods=["POST", "GET"])
    @token_required
    def commodity_request(current_user):

        public_id = current_user.public_id

        if request.method == "POST":
            name = request.form.get('name')
            address = request.form.get('address')

            #Validate name input
            if not validate_input(name):
                return jsonify(message=FIELD_MISSING.format("Name"), result=API_SUCCESS_RESULT), 400

            if not validate_input(address):
                return jsonify(message=FIELD_MISSING.format("Address"), result=API_SUCCESS_RESULT), 400

            commodity = create_commodity(public_id, name)
            db_model.CommodityRequest(commodity=commodity, address=address, public_id=public_id).save()
            return jsonify(result=API_SUCCESS_RESULT), 200

        elif request.method == "GET":

            check_cr = db_model.CommodityRequest.objects(public_id=public_id).exclude("id").only("commodity", "address", "request_id")

            cr_model = {}
            for cr in check_cr:
                if not cr_model.get(cr.commodity.name):
                    cr_model[cr.commodity.name] = [{"create_date": cr.create_date, "address": cr.address}]
                else:
                    c_list = cr_model.get(cr.commodity.name)
                    c_list.append({"create_date": cr.create_date, "address": cr.address})

            if cr_model:
                return jsonify(data=cr_model, result=API_SUCCESS_RESULT), 200
            else:
                return jsonify(result=API_SUCCESS_RESULT, data=[]), 200

    @app.route("/isos/commodity", strict_slashes=False, methods=["POST", "GET"])
    @token_required
    def commodity(current_user):

        public_id = current_user.public_id

        if request.method == "POST":
            name = request.form.get('name')
            brand = request.form.get('brand')

            #Validate name input
            if not validate_input(name):
                return jsonify(message=FIELD_MISSING.format("Name"), result=API_SUCCESS_RESULT), 400

            create_commodity(public_id, name, brand)
            return jsonify(result=API_SUCCESS_RESULT, message=COMMODITY_SUCCESS.format(name)), 200

        elif request.method == "GET":

            if request.args.get('action')=="search" and request.args.get('name'):
                name = request.args.get('name')
                check_commodity = db_model.Commodity.objects(name__contains=name.lower()).exclude("id").only("name", "brand", "commodity_id")
            else:
                check_commodity = db_model.Commodity.objects.exclude("id").only("name", "brand", "commodity_id")

            if check_commodity:
                commodity_model=db_model.model(check_commodity.to_json())
                return jsonify(data=commodity_model, result=API_SUCCESS_RESULT), 200
            else:
                return jsonify(result=API_SUCCESS_RESULT, data=[], message=NO_COMMODITY), 200

    @app.route("/isos/store", strict_slashes=False, methods=["POST", "GET"])
    @token_required
    def store(current_user):

        public_id = current_user.public_id

        if request.method == "POST":
            name = request.form.get('name')
            address = request.form.get('address')

            #Validate name input
            if not validate_input(name):
                return jsonify(message=FIELD_MISSING.format("Name"), result=API_SUCCESS_RESULT), 400

            if not validate_input(address):
                return jsonify(message=FIELD_MISSING.format("Address"), result=API_SUCCESS_RESULT), 400

            create_store(public_id, name, address)
            return jsonify(result=API_SUCCESS_RESULT), 200

        elif request.method == "GET":

            if request.args.get('action')=="search" and request.args.get('name'):
                name = request.args.get('name')
                check_store = db_model.Store.objects(name__contains=name.lower()).exclude("id").only("name", "address", "store_id")
            else:
                check_store = db_model.Store.objects.exclude("id").only("name", "address", "store_id")

            if check_store:
                store_model=db_model.model(check_store.to_json())
                return jsonify(data=store_model, result=API_SUCCESS_RESULT), 200
            else:
                return jsonify(result=API_SUCCESS_RESULT, data=[]), 200


    @app.route("/isos/register", strict_slashes=False, methods=["POST"])
    def register():
        name = request.form.get('name')
        email = request.form.get('email')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        public_id=str(uuid.uuid4())

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
            db_model.Users(profile_pic=dpp_url, name=name, email=email, password=hash_input(password), public_id=public_id).save()
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
