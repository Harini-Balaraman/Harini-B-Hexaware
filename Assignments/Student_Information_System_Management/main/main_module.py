import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from dao.student_service_provider_impl import StudentServiceProviderImpl
from entity.student import Student
import datetime

def print_menu():
    print("\n🎓 STUDENT INFORMATION SYSTEM MENU 🎓")
    print("1. Add Student")
    print("2. View All Students")
    print("3. Enroll Student to Course")
    print("4. Make Payment")
    print("5. Generate Enrollment Report")
    print("6. Generate Payment Report")
    print("0. Exit")

def main():
    provider = StudentServiceProviderImpl()
    
    while True:
        print_menu()
        choice = input("Enter your choice: ")

        if choice == '1':
            print("\n👉 Enter Student Details:")
            first_name = input("First Name: ")
            last_name = input("Last Name: ")
            dob = input("Date of Birth (YYYY-MM-DD): ")
            email = input("Email: ")
            phone = input("Phone Number: ")

            student = Student(None, first_name, last_name, dob, email, phone)
            provider.add_student(student)

        elif choice == '2':
            students = provider.get_all_students()
            print("\n📋 All Students:")
            for s in students:
                print(s)

        elif choice == '3':
            print("\n📚 Enroll Student to Course")
            student_id = int(input("Enter Student ID: "))
            course_id = int(input("Enter Course ID: "))
            enrollment_date = input("Enrollment Date (YYYY-MM-DD): ")
            provider.enroll_student(student_id, course_id, enrollment_date)

        elif choice == '4':
            print("\n💸 Make a Payment")
            student_id = int(input("Enter Student ID: "))
            amount = float(input("Amount: "))
            payment_date = input("Payment Date (YYYY-MM-DD): ")
            provider.make_payment(student_id, amount, payment_date)

        elif choice == '5':
            print("\n📊 Generate Enrollment Report")
            course_id = int(input("Enter Course ID: "))
            report = provider.get_enrollment_report(course_id)
            for row in report:
                print(row)

        elif choice == '6':
            print("\n🧾 Generate Payment Report")
            student_id = int(input("Enter Student ID: "))
            report = provider.get_payment_report(student_id)
            for row in report:
                print(row)

        elif choice == '0':
            print("👋 Exiting the Student Info System. Peace out!")
            break

        else:
            print("⚠️ Invalid choice! Try again.")

if __name__ == "__main__":
    main()
