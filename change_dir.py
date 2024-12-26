import json

def read_json(file_path):
    with open(file_path,'r') as file:
        data=json.load (file)
    return data

def write_json(file_path, data):
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

def update_source_path(file_path):
    new_source_path = input("Enter new source path : ")
    data=read_json(file_path)

    if "source_path" in data:
        data["source_path"]=new_source_path

    else:
        print("source_path not found")
        return
    
    write_json(file_path, data)
    print(f"source_path '{new_source_path}' olarak güncellendi.")

file_path="config.json"
update_source_path(file_path)