from abc import ABC, abstractmethod

class IStudentServiceProvider(ABC):

    @abstractmethod
    def add_student(self, student):
        pass

    @abstractmethod
    def get_all_students(self):
        pass

    @abstractmethod
    def enroll_student(self, student_id, course_id, enrollment_date):
        pass

    @abstractmethod
    def make_payment(self, student_id, amount, payment_date):
        pass

    @abstractmethod
    def get_enrollment_report(self, course_id):
        pass

    @abstractmethod
    def get_payment_report(self, student_id):
        pass
