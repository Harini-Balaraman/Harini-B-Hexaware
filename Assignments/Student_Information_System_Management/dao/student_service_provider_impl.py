import mysql.connector
from util.db_conn_util import DBConnUtil
from entity.student import Student

class StudentServiceProviderImpl:

    def __init__(self):
        self.conn = DBConnUtil.get_connection()
        self.cursor = self.conn.cursor()

    def add_student(self, student):
        sql = """INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
                 VALUES (%s, %s, %s, %s, %s)"""
        values = (student.first_name, student.last_name, student.date_of_birth, student.email, student.phone_number)
        self.cursor.execute(sql, values)
        self.conn.commit()
        print("✅ Student added successfully!")

    def get_all_students(self):
        self.cursor.execute("SELECT * FROM Students")
        return self.cursor.fetchall()

    def enroll_student(self, student_id, course_id, enrollment_date):
        sql = """INSERT INTO Enrollments (student_id, course_id, enrollment_date)
                 VALUES (%s, %s, %s)"""
        self.cursor.execute(sql, (student_id, course_id, enrollment_date))
        self.conn.commit()
        print("✅ Student enrolled successfully!")

    def make_payment(self, student_id, amount, payment_date):
        sql = """INSERT INTO Payments (student_id, amount, payment_date)
                 VALUES (%s, %s, %s)"""
        self.cursor.execute(sql, (student_id, amount, payment_date))
        self.conn.commit()
        print("💸 Payment recorded successfully!")

    def get_enrollment_report(self, course_id):
        sql = """SELECT s.first_name, s.last_name, e.enrollment_date
                 FROM Students s
                 JOIN Enrollments e ON s.student_id = e.student_id
                 WHERE e.course_id = %s"""
        self.cursor.execute(sql, (course_id,))
        return self.cursor.fetchall()

    def get_payment_report(self, student_id):
        sql = """SELECT amount, payment_date FROM Payments WHERE student_id = %s"""
        self.cursor.execute(sql, (student_id,))
        return self.cursor.fetchall()
