"""
This is the entry point of the application app
"""

from modules.module_a.arithmetic_operations import sum_values, multiply_values
from modules.module_b.identity_operations import identity

def main():
    """
    This is the main method for the app
    """
    print("Hello World!")
    value_a = 3
    value_b = 5

    value_c = sum_values(value_a, value_b)
    value_d = multiply_values(value_a, value_b)
    value_e = identity(value_a)

    print(f"The sum of {value_a} and {value_b} is {value_c}")
    print(f"The multiplication of {value_a} and {value_b} is {value_d}")
    print(f"value {value_a} is the same as {value_e}")

if __name__ == "__main__":
    main()
