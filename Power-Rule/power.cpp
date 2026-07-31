#include <iostream>
#include <cmath>   // For std::pow
#include <string>  // For converting text arguments to numbers

int main(int argc, char* argv[]) {
    double exponent = 0.0;
    double x_value = 0.0;

    // Check if the user provided the right amount of arguments
    // argc is 1 if they just typed the program name.
    // argc is 3 if they typed: ./power [exponent] [x_value]
    if (argc == 3) {
        // --- AUTOMATED PIPELINE MODE ---
        // argv[1] and argv[2] are stored as text (strings). 
        // std::stod converts "string to double" so we can do math.
        exponent = std::stod(argv[1]);
        x_value = std::stod(argv[2]);
        std::cout << "[Pipeline Mode Active]" << std::endl;
    } 
    else {
        // --- INTERACTIVE MODE ---
        std::cout << "=== Calculus Power Rule Assistant ===" << std::endl;
        std::cout << "For a term x^n, enter the exponent (n): ";
        std::cin >> exponent;
        
        std::cout << "Enter the value of x to evaluate at: ";
        std::cin >> x_value;
    }

    // --- THE PROCESSING (The Power Rule Math) ---
    // Derivative of x^n is n * x^(n-1)
    double derivative_coefficient = exponent;
    double new_exponent = exponent - 1.0;
    double result = derivative_coefficient * std::pow(x_value, new_exponent);

    // --- THE OUTPUT ---
    std::cout << "\nFunction: f(x) = x^" << exponent << std::endl;
    std::cout << "Derivative: f'(x) = " << derivative_coefficient << " * x^" << new_exponent << std::endl;
    std::cout << "Evaluated at x = " << x_value << " is: " << result << std::endl;

    return 0;
}
