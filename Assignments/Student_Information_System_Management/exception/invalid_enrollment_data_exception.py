class InvalidEnrollmentDataException(Exception):
    def __init__(self, message="Enrollment data is missing or incorrect."):
        super().__init__(message)
