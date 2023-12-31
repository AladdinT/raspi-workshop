#include <iostream>
#include <fstream>
#include <cstdlib>
#include <csignal>
#include <unistd.h>

using namespace std;

int global_pin;
// Function to clean up and exit
void freePin() {
    cout << "Unexporting Pin " << global_pin << endl;

    ofstream valueFile("/sys/class/gpio/gpio" + to_string(global_pin) + "/value");
    valueFile << "0";
    valueFile.close();
    sleep(1); 
    ofstream unexportFile("/sys/class/gpio/unexport");
    unexportFile << global_pin;
    unexportFile.close();
    exit(0);
}

int main() {
    cout << "Welcome to led toggler" << endl;

    cout << "Enter GPIO pin number: ";
    cin >> global_pin;

    // GPIO pin init
    ofstream exportFile("/sys/class/gpio/export");
    exportFile << global_pin;
    exportFile.close();

    sleep(2); // Wait for file to be created


    ofstream directionFile("/sys/class/gpio/gpio" + to_string(global_pin) + "/direction");
    if (!directionFile) {
        // File doesn't exist
        freePin();
    }
    directionFile << "out";
    directionFile.close();
    
    sleep(2); // Wait for file to be created

        // Free GPIO pin before exiting
        signal(SIGINT, [](int) {
        freePin(); });

    // Toggle LED
    std::ofstream valueFile;
    valueFile.open("/sys/class/gpio/gpio" + to_string(global_pin) + "/value", std::ios::out | std::ios::app);
    cout << "Toggler is toggling" << endl;
    if (valueFile.is_open()) {
        while(1)
        {
            valueFile.write("1", 1);
            valueFile.flush();
            sleep(1);
            valueFile.write("0", 1);
            valueFile.flush();
            sleep(1);

        }
        valueFile.close();
    } else {
        std::cerr << "Unable to open the file." << std::endl;
    }
   
    return 0;
}

