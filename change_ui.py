import json
from tkinter import Tk, Label, Button, filedialog, messagebox

CONFIG_FILE = "config.json"

def read_json(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

def write_json(file_path, data):
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

def update_source_path():
    file_path = filedialog.askdirectory(title="Select Source Directory")
    if file_path:
        data = read_json(CONFIG_FILE)
        data["source_path"] = file_path
        write_json(CONFIG_FILE, data)
        messagebox.showinfo("Success", f"Source path updated to:\n{file_path}")

def update_destination_path():
    file_path = filedialog.askdirectory(title="Select Destination Directory")
    if file_path:
        data = read_json(CONFIG_FILE)
        data["destination_path"] = file_path
        write_json(CONFIG_FILE, data)
        messagebox.showinfo("Success", f"Destination path updated to:\n{file_path}")

def create_gui():
    root = Tk()
    root.title("Backup Configuration")

    # Başlık
    Label(root, text="Backup Configuration", font=("Arial", 16, "bold")).pack(pady=10)

    # Source path butonu
    Button(root, text="Change Source Path", command=update_source_path, width=30).pack(pady=10)

    # Destination path butonu
    Button(root, text="Change Destination Path", command=update_destination_path, width=30).pack(pady=10)

    # Çıkış butonu
    Button(root, text="Exit", command=root.quit, width=30).pack(pady=10)

    root.geometry("400x200")
    root.mainloop()

if __name__ == "__main__":
    create_gui()