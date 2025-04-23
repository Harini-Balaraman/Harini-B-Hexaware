from abc import ABC, abstractmethod

class ICustomerServiceProvider(ABC):
    
    @abstractmethod
    def create_customer(self, customer):
        pass

    @abstractmethod
    def get_customer_by_id(self, customer_id):
        pass

    @abstractmethod
    def create_account(self, account):
        pass

    @abstractmethod
    def get_account_by_id(self, account_id):
        pass
