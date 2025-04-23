class InsufficientFundException(Exception):
    def __init__(self, message="Insufficient funds in the account."):
        super().__init__(message)
