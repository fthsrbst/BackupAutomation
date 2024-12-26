import json

def read_json(file_path):
    with open(file_path,'r') as file:
        data=json.load (file)
    return data

def write_json(file_path, data):
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

def update_destination_path(file_path):
    new_destination_path = input("Enter new destination path : ")
    data=read_json(file_path)

    if "destination_path" in data:
        data["destination_path"]=new_destination_path

    else:
        print("destination_path not found")
        return
    
    write_json(file_path, data)
    print(f"destination_path '{new_destination_path}' olarak güncellendi.")

file_path="config.json"
update_destination_path(file_path)