CREATE TABLE pengguna(
    pengguna_id serial PRIMARY KEY,
    no_rek char(20),
    nama varchar(40),
    saldo int,
    alamat varchar(40),
    no_tlp char(20),
    tanggal date,
    riwayat_id int references riwayat(riwayat_id),
    unique(riwayat_id),
    login_id int references login(login_id),
    unique(login_id)
)
insert into pengguna (no_rek, nama, saldo, alamat, no_tlp, tanggal)
values (
        '2341235435',
        'johan',
        2000000,
        'Jakarta Utara',
        '081123132321',
        '2020-12-31'
    ),
    (
        '0234675098',
        'kaela',
        5000000,
        'Jakarta Utara',
        '081234543345',
        '2010-06-23'
    ) CREATE TABLE riwayat(
        riwayat_id serial PRIMARY KEY,
        jenis_transaksi varchar(40)
    )
insert into riwayat(jenis_transaksi)
values ('Penarikan'),
    ('Penyetoran') CREATE TABLE login(
        login_id serial PRIMARY KEY,
        username varchar(40),
        password char(10)
    )
insert into login(username, password)
values ('wira', 'wira123'),
    ('dewa', 'dewa123')