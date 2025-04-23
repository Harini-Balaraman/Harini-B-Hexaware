class Customer:
    def __init__(self, first_name, last_name, dob, email, phone_number, address, customer_id=None):
        self.customer_id = customer_id
        self.first_name = first_name
        self.last_name = last_name
        self.dob = dob
        self.email = email
        self.phone_number = phone_number
        self.address = address

    def __str__(self):
        return f"Customer({self.customer_id}, {self.first_name}, {self.last_name}, {self.dob}, {self.email}, {self.phone_number}, {self.address})"
