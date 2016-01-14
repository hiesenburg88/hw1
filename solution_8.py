# solution_8.py HW 1 on 14 Jan 2016
# This program will take a Fahrenheit temperature and convert it to Celsius

def main():
  print("This program converts the temperature in Fahrenheit to Celsius")
  try:
      fahrenheit = eval(input("Enter the temperature in Fahrenheit: "))
      celsius = (fahrenheit - 32)*5/9
      celsius = round(celsius)
      print("The temperature is", celsius, "degrees Celsius.")

  except:
      print("Please enter the temperature as an integer")

main()
