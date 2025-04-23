class InvalidStudentDataException(Exception):
    def __init__(self, message="Provided student data is invalid."):
        super().__init__(message)
