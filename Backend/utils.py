import hashlib
import re

def validate_input(value):
    if not value or value.strip()=="":
        return False
    else:
        return True

def validate_email(email):
    regex = '^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$'
    if(re.search(regex,email)):
        return True
    else:
        return False

def hash_input(value):
    hashed_data = hashlib.sha224(value.encode()).hexdigest()
    return hashed_data

def get_logger():
    logging.basicConfig(stream=sys.stdout, level="Info",
                            format="[%(asctime)s] %(levelname)s [%(threadName)s] [%(filename)s:%(funcName)s:%(lineno)s] %(message)s",
                            datefmt='%Y-%m-%dT%H:%M:%S')
    logger = logging.getLogger("isos")
    return logger
