from flask import Flask, redirect, url_for, session, request, render_template
from database import save_user, get_staff

app = Flask(__name__)
app.secret_key = 'SECRET_KEY'

@app.route('/')
def index():
    return 'Welcome to the Staff Dashboard'

@app.route('/add_staff', methods=['GET', 'POST'])
def add_staff():
    if request.method == 'POST':
        discord_id = request.form['discord_id']
        username = request.form['username']
        role = request.form['role']

        save_user(discord_id, username, role)
        return redirect(url_for('staff_list'))
    
    return render_template('add_staff.html')

@app.route('/staff_list')
def staff_list():
    users = get_staff()
    return render_template('staff_list.html', users=users)

if __name__ == '__main__':
    app.run(debug=True)
