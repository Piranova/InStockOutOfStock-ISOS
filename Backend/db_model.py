from mongoengine import Document, connect
from mongoengine.fields import (
    DateTimeField, SequenceField, StringField, EmailField, ReferenceField
)
from datetime import datetime
import pymongo
from flask import Flask
import constants
import json

connect('isos', host="mongodb://mongo/{}".format(constants.ENV))

class Users(Document):
    meta = {'collection': 'users'}
    user_id = SequenceField()
    name = StringField(required=True)
    email = EmailField(required=True)
    password = StringField(required=True)
    address = StringField()
    create_date = StringField(default=datetime.now().strftime("%-d/%B/%Y"))


def model(db_document):
    return json.loads(db_document)
