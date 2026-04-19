class JSONDatabase:
    def __init__(self):
        self.database = {}

    def create(self, key, value):
        self.database[key] = value

    def read(self, key):
        return self.database.get(key)

    def update(self, key, value):
        if key in self.database:
            self.database[key] = value
        else:
            raise KeyError(f"Key '{key}' not found")

    def delete(self, key):
        if key in self.database:
            del self.database[key]
        else:
            raise KeyError(f"Key '{key}' not found")

    def save_to_file(self, filename):
        import json
        with open(filename, 'w') as file:
            json.dump(self.database, file)

    def load_from_file(self, filename):
        import json
        try:
            with open(filename, 'r') as file:
                self.database = json.load(file)
        except FileNotFoundError:
            raise FileNotFoundError(f"File '{filename}' not found")

class JSONDatabaseSimulator:
    def __init__(self):
        self.database = JSONDatabase()

    def simulate(self):
        while True:
            print("\nJSON Database Simulator")
            print("1. Create")
            print("2. Read")
            print("3. Update")
            print("4. Delete")
            print("5. Save to file")
            print("6. Load from file")
            print("7. Exit")
            choice = input("Choose an option: ")
            if choice == '1':
                key = input("Enter key: ")
                value = input("Enter value: ")
                self.database.create(key, value)
            elif choice == '2':
                key = input("Enter key: ")
                print(self.database.read(key))
            elif choice == '3':
                key = input("Enter key: ")
                value = input("Enter value: ")
                try:
                    self.database.update(key, value)
                except KeyError as e:
                    print(e)
            elif choice == '4':
                key = input("Enter key: ")
                try:
                    self.database.delete(key)
                except KeyError as e:
                    print(e)
            elif choice == '5':
                filename = input("Enter filename: ")
                self.database.save_to_file(filename)
            elif choice == '6':
                filename = input("Enter filename: ")
                try:
                    self.database.load_from_file(filename)
                except FileNotFoundError as e:
                    print(e)
            elif choice == '7':
                break
            else:
                print("Invalid option")

if __name__ == "__main__":
    simulator = JSONDatabaseSimulator()
    simulator.simulate()