class PaymentValidationException(Exception):
    def __init__(self, message="Invalid payment amount or date."):
        super().__init__(message)
