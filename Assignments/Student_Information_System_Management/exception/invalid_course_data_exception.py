class InvalidCourseDataException(Exception):
    def __init__(self, message="Provided course data is invalid."):
        super().__init__(message)
