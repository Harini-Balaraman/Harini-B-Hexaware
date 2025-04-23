import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dao.customer_service_provider_impl import CustomerServiceProviderImpl
from entity.customer import Customer
from entity.account import Account

def main():
    service = CustomerServiceProviderImpl()

    while True:
        print("\n--- HM Bank Main Menu ---")
        print("1. Create Customer")
        print("2. Create Account")
        print("3. View Customer by ID")
        print("4. View Account by ID")
        print("5. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            first_name = input("First Name: ")
            last_name = input("Last Name: ")
            dob = input("Date of Birth (YYYY-MM-DD): ")
            email = input("Email: ")
            phone = input("Phone Number: ")
            address = input("Address: ")

            customer = Customer(first_name, last_name, dob, email, phone, address)
            cid = service.create_customer(customer)
            print(f"✅ Customer created with ID: {cid}")

        elif choice == '2':
            customer_id = int(input("Enter Customer ID: "))
            account_type = input("Account Type (savings/current/zero_balance): ")
            balance = float(input("Initial Balance: "))

            account = Account(customer_id, account_type, balance)
            acc_id = service.create_account(account)
            print(f"✅ Account created with ID: {acc_id}")

        elif choice == '3':
            customer_id = int(input("Enter Customer ID to View: "))
            customer = service.get_customer_by_id(customer_id)
            if customer:
                print("👤 Customer Info:", customer)
            else:
                print("❌ Customer not found.")

        elif choice == '4':
            account_id = int(input("Enter Account ID to View: "))
            account = service.get_account_by_id(account_id)
            if account:
                print("🏦 Account Info:", account)
            else:
                print("❌ Account not found.")

        elif choice == '5':
            print("👋 Exiting the system. Goodbye!")
            break

        else:
            print("⚠️ Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
