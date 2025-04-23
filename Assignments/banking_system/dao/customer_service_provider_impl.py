import mysql.connector
from util.db_conn_util import DBConnUtil
from entity.customer import Customer
from entity.account import Account

class CustomerServiceProviderImpl:

    def __init__(self):
        self.conn = DBConnUtil.get_connection()
        self.cursor = self.conn.cursor()

    def create_customer(self, customer: Customer):
        query = """
            INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = (customer.first_name, customer.last_name, customer.dob,
                  customer.email, customer.phone_number, customer.address)
        self.cursor.execute(query, values)
        self.conn.commit()
        return self.cursor.lastrowid

    def get_customer_by_id(self, customer_id: int):
        query = "SELECT * FROM Customers WHERE customer_id = %s"
        self.cursor.execute(query, (customer_id,))
        return self.cursor.fetchone()

    def create_account(self, account: Account):
        query = """
            INSERT INTO Accounts (customer_id, account_type, balance)
            VALUES (%s, %s, %s)
        """
        values = (account.customer_id, account.account_type, account.balance)
        self.cursor.execute(query, values)
        self.conn.commit()
        return self.cursor.lastrowid

    def get_account_by_id(self, account_id: int):
        query = "SELECT * FROM Accounts WHERE account_id = %s"
        self.cursor.execute(query, (account_id,))
        return self.cursor.fetchone()
