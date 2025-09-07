from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import sqlite3

app = Flask(__name__)
CORS(app, supports_credentials=True)

# Initialize the database
def init_db():
    conn = sqlite3.connect('patients.db')
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS Patient (
            patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            age INTEGER NOT NULL,
            gender TEXT NOT NULL,
            phone TEXT NOT NULL,
            appointment_time TEXT NOT NULL,
            dob TEXT
        )
    ''')
    conn.commit()
    conn.close()

init_db()

# Add new patient
@app.route('/add_patient', methods=['POST'])
def add_patient():
    data = request.get_json()
    conn = sqlite3.connect('patients.db')
    c = conn.cursor()
    c.execute('''
        INSERT INTO Patient (name, age, gender, phone, appointment_time, dob)
        VALUES (?, ?, ?, ?, ?, ?)
    ''', (
        data['name'],
        data['age'],
        data['gender'],
        data['phone'],
        data['appointment_time'],
        data['dob']
    ))
    conn.commit()
    conn.close()
    return jsonify({'message': 'Patient added successfully'}), 201

# Get all patients
@app.route('/patients', methods=['GET'])
def get_patients():
    conn = sqlite3.connect('patients.db')
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    c.execute('SELECT * FROM Patient')
    rows = c.fetchall()
    conn.close()
    patients = [dict(row) for row in rows]
    return jsonify(patients)

# Optional: Route to render patients in an HTML page
@app.route('/view-patients')
def view_patients():
    conn = sqlite3.connect('patients.db')
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    c.execute('SELECT * FROM Patient')
    rows = c.fetchall()
    conn.close()
    return render_template('view_patients.html', patients=rows)

if __name__ == '__main__':
    app.run(debug=True)
