class StudentNotFoundException(Exception):
    def __init__(self, message="Student not found in the system."):
        super().__init__(message)
