from mongoengine import Document, connect
from mongoengine.fields import (
    DateTimeField, SequenceField, StringField, EmailField, ReferenceField, BooleanField
)
from datetime import datetime
import pymongo
from flask import Flask
import config
import json
from bson import json_util

connect('isos', host="mongodb://mongo/{}".format(config.ENV))

class Users(Document):
    meta = {'collection': 'users'}
    user_id = SequenceField()
    public_id = StringField(required=True)
    name = StringField(required=True)
    email = EmailField(required=True)
    password = StringField(required=True)
    address = StringField()
    profile_pic = StringField()
    create_date = StringField(default=datetime.now().strftime("%-d/%B/%Y %I:%M:%S"))

class Store(Document):
    meta = {'collection': 'store'}
    store_id = SequenceField()
    name = StringField(required=True)
    address = StringField(default="NA")
    public_id = StringField()
    create_date = StringField(default=datetime.now().strftime("%-d/%B/%Y %I:%M:%S"))

class Commodity(Document):
    meta = {'collection': 'commodity'}
    commodity_id = SequenceField()
    name = StringField(required=True)
    brand = StringField(default="NA")
    public_id = StringField()
    create_date = StringField(default=datetime.now().strftime("%-d/%B/%Y %I:%M:%S"))

class CommodityRequest(Document):
    meta = {'collection': 'commodity_request'}
    request_id = SequenceField()
    commodity = ReferenceField(Commodity)
    public_id = StringField(required=True)
    address = StringField(default=True)
    create_date = StringField(default=datetime.now().strftime("%-d/%B/%Y %I:%M:%S"))

class Comments(Document):
    meta = {'collection': 'comments'}
    comment_id = SequenceField()
    commodity = ReferenceField(Commodity, required=True)
    store = ReferenceField(Store, required=True)
    public_id = StringField(required=True)
    is_available = BooleanField(default=True)
    create_date = StringField(default=datetime.now().strftime("%-d/%B/%Y %I:%M:%S"))

def model(db_document):
    return json.loads(db_document)
