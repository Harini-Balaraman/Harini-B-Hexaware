class OverdraftLimitExceededException(Exception):
    def __init__(self, message="Overdraft limit exceeded for the current account."):
        super().__init__(message)
