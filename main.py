from flask import Flask, render_template, request, url_for, redirect, flash, session
import psycopg2
import psycopg2.extras
from psycopg2 import Error



app =Flask(__name__)
app.secret_key = "mada"


conn = psycopg2.connect(
    host = 'localhost',
    dbname = 'tabungan',
    user = 'postgres',
    password = 'wira1010',
    port = '5432'
) 



@app.route('/')
def index():
    display_error = session.pop('display_error', False)
    return render_template('login.html', display_error=display_error)


@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')

    try:
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        select_query = "SELECT * FROM login WHERE username = %s AND password = %s;"
        cur.execute(select_query, (username, password))
        user = cur.fetchone()
        if user:
            session['username'] = user[1]  # Store username in session
            return redirect(url_for('home'))
        else:
            session['display_error'] = True  # Set session variable to display error
            return redirect(url_for('index'))
    except (Exception, Error) as e:
        print("Error:", e)
        session['display_error'] = True  # Set session variable to display error
        return redirect(url_for('index'))



@app.route('/penyetoran/<id>', methods=['POST', 'GET'])
def penyetoran(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


    cur.execute("""
        SELECT * FROM data_pelanggan,login WHERE id = %s
    """,(id))
    data = cur.fetchall()
    cur.close() 
    if 'username' in session:
        pic_username = session['username']
        return render_template('penyetoran.html', data_pelanggan=data[0], login1=data[0], login2=data[1], login3=data[2], pic_username=pic_username)
    else:
        return redirect(url_for('login'))




@app.route('/home')
def home():
    if 'username' in session:
        return render_template('index.html', username=session['username'])
    else:
        return redirect(url_for('login'))



@app.route('/transaksi', methods=['POST', 'GET'])
def transaksi():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("""
        SELECT * FROM data_pelanggan
    """)
    
    list_pelanggan = cur.fetchall()
    return render_template('transaksi.html', list_pelanggan = list_pelanggan)











@app.route('/history', methods=['POST', 'GET'])
def history():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = """
        SELECT * FROM public.view1 
    """
    cur.execute(s)
    
    list_view_pelanggan = cur.fetchall() 
    return render_template('history.html', list_view_pelanggan = list_view_pelanggan,)







@app.route('/data_pengguna', methods=['POST', 'GET'])
def data_pengguna():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = """
        SELECT * FROM data_pelanggan
    """
    cur.execute(s)
    
    list_pelanggan = cur.fetchall()
    return render_template('data_pengguna.html', list_pelanggan = list_pelanggan)







@app.route('/penarikan/<id>', methods=['POST', 'GET'])
def penarikan(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute("""
        SELECT * FROM data_pelanggan,login WHERE id = %s
    """,(id))
    data = cur.fetchall()
    cur.close() 
    if 'username' in session:
        pic_username = session['username']
        return render_template('penarikan.html', data_pelanggan=data[0], login1=data[0], login2=data[1], login3=data[2], pic_username=pic_username)
    else:
        return redirect(url_for('login'))










@app.route('/setor/<id>', methods=['POST', 'GET'])
def setor(id):
    
    if request.method == 'POST':
        jumlah_penyetoran = request.form['jumlah_penyetoran']
        tanggal = request.form['tanggal']
        pelanggan_id = request.form.get('pelanggan_id')
        pic = request.form.get('pic')


        
        
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute(''' UPDATE data_pelanggan SET saldo = saldo + %s WHERE id = %s ''', (jumlah_penyetoran, pelanggan_id))
        cur.execute('''INSERT INTO history(pelanggan_id,jenis_transaksi,tgl_transaksi,jumlah_transaksi,pic) VALUES (%s, 'Penyetoran', %s, %s,%s)''',(pelanggan_id,tanggal,jumlah_penyetoran,pic))
            
        conn.commit()
        return redirect(url_for('transaksi'))






@app.route('/tarik/<id>', methods=['POST', 'GET'])
def tarik(id):
    
    if request.method == 'POST':
        jumlah_penyetoran = request.form['jumlah_penyetoran']
        tanggal = request.form['tanggal']
        pelanggan_id = request.form.get('pelanggan_id')
        pic = request.form.get('pic')

        
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute(''' UPDATE data_pelanggan SET saldo = saldo - %s WHERE id = %s ''', (jumlah_penyetoran, pelanggan_id))
        cur.execute('''INSERT INTO history(pelanggan_id,jenis_transaksi,tgl_transaksi,jumlah_transaksi,pic) VALUES (%s, 'Penarikan', %s, %s,%s)''',(pelanggan_id,tanggal,jumlah_penyetoran,pic))
            
        conn.commit()
        return redirect(url_for('transaksi'))
















        











#RUN FUNCTION================================

if __name__ == "__main__":
    app.run(debug=True)

