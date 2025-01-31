PGDMP         3                {            tabungan    15.3    15.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    25129    tabungan    DATABASE        CREATE DATABASE tabungan WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
    DROP DATABASE tabungan;
                postgres    false            �            1259    25130    data_pelanggan    TABLE     �   CREATE TABLE public.data_pelanggan (
    id integer NOT NULL,
    nama character varying(255),
    alamat character varying(255),
    no_telp character varying(20),
    no_rek character varying(30),
    saldo money,
    tanggal date
);
 "   DROP TABLE public.data_pelanggan;
       public         heap    postgres    false            �            1259    25135    data_pelanggan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.data_pelanggan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.data_pelanggan_id_seq;
       public          postgres    false    214                       0    0    data_pelanggan_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.data_pelanggan_id_seq OWNED BY public.data_pelanggan.id;
          public          postgres    false    215            �            1259    25136    history    TABLE     �   CREATE TABLE public.history (
    id_history integer NOT NULL,
    pelanggan_id integer,
    jenis_transaksi character varying(50),
    tgl_transaksi date,
    jumlah_transaksi money,
    pic character varying
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    25141    history_id_history_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_history_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.history_id_history_seq;
       public          postgres    false    216                       0    0    history_id_history_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.history_id_history_seq OWNED BY public.history.id_history;
          public          postgres    false    217            �            1259    25142    login    TABLE     �   CREATE TABLE public.login (
    id_login integer NOT NULL,
    username character varying(50),
    password character varying(100),
    pelanggan_id integer
);
    DROP TABLE public.login;
       public         heap    postgres    false            �            1259    25145    login_id_login_seq    SEQUENCE     �   CREATE SEQUENCE public.login_id_login_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.login_id_login_seq;
       public          postgres    false    218                       0    0    login_id_login_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.login_id_login_seq OWNED BY public.login.id_login;
          public          postgres    false    219            �            1259    25177    view1    VIEW     q  CREATE VIEW public.view1 AS
 SELECT dp.nama AS pelanggan_nama,
    dp.no_rek AS pelanggan_no_rek,
    h.jenis_transaksi AS history_jenis_transaksi,
    h.jumlah_transaksi AS history_jumlah_transaksi,
    h.tgl_transaksi AS history_tgl_transaksi,
    h.pic AS history_pic
   FROM (public.data_pelanggan dp
     LEFT JOIN public.history h ON ((dp.id = h.pelanggan_id)));
    DROP VIEW public.view1;
       public          postgres    false    216    216    214    214    214    216    216    216            s           2604    25150    data_pelanggan id    DEFAULT     v   ALTER TABLE ONLY public.data_pelanggan ALTER COLUMN id SET DEFAULT nextval('public.data_pelanggan_id_seq'::regclass);
 @   ALTER TABLE public.data_pelanggan ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214            t           2604    25151    history id_history    DEFAULT     x   ALTER TABLE ONLY public.history ALTER COLUMN id_history SET DEFAULT nextval('public.history_id_history_seq'::regclass);
 A   ALTER TABLE public.history ALTER COLUMN id_history DROP DEFAULT;
       public          postgres    false    217    216            u           2604    25152    login id_login    DEFAULT     p   ALTER TABLE ONLY public.login ALTER COLUMN id_login SET DEFAULT nextval('public.login_id_login_seq'::regclass);
 =   ALTER TABLE public.login ALTER COLUMN id_login DROP DEFAULT;
       public          postgres    false    219    218                      0    25130    data_pelanggan 
   TABLE DATA           [   COPY public.data_pelanggan (id, nama, alamat, no_telp, no_rek, saldo, tanggal) FROM stdin;
    public          postgres    false    214   �!                 0    25136    history 
   TABLE DATA           r   COPY public.history (id_history, pelanggan_id, jenis_transaksi, tgl_transaksi, jumlah_transaksi, pic) FROM stdin;
    public          postgres    false    216   \"                 0    25142    login 
   TABLE DATA           K   COPY public.login (id_login, username, password, pelanggan_id) FROM stdin;
    public          postgres    false    218   �"                  0    0    data_pelanggan_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.data_pelanggan_id_seq', 6, true);
          public          postgres    false    215                       0    0    history_id_history_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.history_id_history_seq', 15, true);
          public          postgres    false    217                        0    0    login_id_login_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.login_id_login_seq', 6, true);
          public          postgres    false    219            w           2606    25154 "   data_pelanggan data_pelanggan_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.data_pelanggan
    ADD CONSTRAINT data_pelanggan_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.data_pelanggan DROP CONSTRAINT data_pelanggan_pkey;
       public            postgres    false    214            y           2606    25156    history history_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id_history);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    216            {           2606    25158    login login_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pkey PRIMARY KEY (id_login);
 :   ALTER TABLE ONLY public.login DROP CONSTRAINT login_pkey;
       public            postgres    false    218            }           2606    25160    login login_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.login DROP CONSTRAINT login_username_key;
       public            postgres    false    218            ~           2606    25161 !   history history_pelanggan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pelanggan_id_fkey FOREIGN KEY (pelanggan_id) REFERENCES public.data_pelanggan(id);
 K   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pelanggan_id_fkey;
       public          postgres    false    216    214    3191                       2606    25166    login login_pelanggan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pelanggan_id_fkey FOREIGN KEY (pelanggan_id) REFERENCES public.data_pelanggan(id);
 G   ALTER TABLE ONLY public.login DROP CONSTRAINT login_pelanggan_id_fkey;
       public          postgres    false    3191    214    218               �   x�e��
�@�s�Yl�d7����D�R*[)�ۻ�If �|���~�v�j�������3�����@�	 �� nq�����<^uZZ;��c�)*,�M��O��@�y3�f��m��5q���*}����yv��9�ŀ+�         {   x���;
�0E�z������B�mRj �`����~���Δ$������kK"OQ�BR3)d �Fg�HmT��|H*��r���D{��`EL�ힱ���ǈ��}X>��
�Ъ^��6c��,�W@         0   x�3������FƜ1~\���E%�*fƙ�X��!�b1z\\\ HoO     