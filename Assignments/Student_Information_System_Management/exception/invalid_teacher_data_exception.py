class InvalidTeacherDataException(Exception):
    def __init__(self, message="Provided teacher data is invalid."):
        super().__init__(message)
