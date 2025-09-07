from flask import Flask, jsonify, request
import sqlite3

app = Flask(__name__)

# Function to connect to the SQLite database
def get_db_connection():
    conn = sqlite3.connect('clinic.db')  # Make sure this DB file exists
    conn.row_factory = sqlite3.Row       # So we can access columns by name
    return conn

# Home route
@app.route('/')
def home():
    return "✅ Clinic Appointment API is running. Try /patients"

# GET route to view all patients
@app.route('/patients', methods=['GET'])
def get_patients():
    conn = get_db_connection()
    patients = conn.execute('SELECT * FROM Patient').fetchall()
    conn.close()
    return jsonify([dict(row) for row in patients])  # Convert rows to dictionary format

if __name__ == '__main__':
    app.run(debug=True)
