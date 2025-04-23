class InsufficientFundsException(Exception):
    def __init__(self, message="Insufficient funds to complete enrollment."):
        super().__init__(message)
