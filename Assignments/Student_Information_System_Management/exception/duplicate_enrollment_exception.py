class DuplicateEnrollmentException(Exception):
    def __init__(self, message="Student is already enrolled in this course."):
        super().__init__(message)
