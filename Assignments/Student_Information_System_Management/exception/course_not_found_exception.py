class CourseNotFoundException(Exception):
    def __init__(self, message="Course not found in the system."):
        super().__init__(message)
