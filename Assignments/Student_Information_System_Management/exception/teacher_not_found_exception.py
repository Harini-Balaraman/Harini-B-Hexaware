class TeacherNotFoundException(Exception):
    def __init__(self, message="Teacher not found in the system."):
        super().__init__(message)
