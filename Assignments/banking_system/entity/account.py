class Account:
    def __init__(self, customer_id, account_type, balance=0.0, account_id=None):
        self.account_id = account_id
        self.customer_id = customer_id
        self.account_type = account_type
        self.balance = balance

    def __str__(self):
        return f"Account({self.account_id}, {self.customer_id}, {self.account_type}, {self.balance})"
