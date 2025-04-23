import mysql.connector
from util.db_property_util import DBPropertyUtil

class DBConnUtil:
    @staticmethod
    def get_connection():
        props = DBPropertyUtil.get_properties()
        conn = mysql.connector.connect(
            host=props['host'],
            user=props['user'],
            password=props['password'],
            database=props['database']
        )
        return conn
