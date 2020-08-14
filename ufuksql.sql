--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bosluk_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bosluk_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."adres" = LTRIM(NEW."adres");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.bosluk_sil() OWNER TO postgres;

--
-- Name: buyuk_il(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.buyuk_il() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."il_adi" = UPPER(NEW."il_adi");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.buyuk_il() OWNER TO postgres;

--
-- Name: message_stamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.message_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.adres IS NULL THEN
            RAISE EXCEPTION 'bos olamaz';
        END IF;
        IF NEW.maas_beklenti IS NULL THEN
            RAISE EXCEPTION '% Bos olamaz', NEW.maas_beklenti;
        END IF;


    END;
$$;


ALTER FUNCTION public.message_stamp() OWNER TO postgres;

--
-- Name: satis_hesaplama(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.satis_hesaplama() RETURNS real
    LANGUAGE plpgsql
    AS $$ -- Fonksiyon govdesinin (tanımının) başlangıcı
BEGIN
    RETURN 1.54 * gelis_fiyat;
END;
$$;


ALTER FUNCTION public.satis_hesaplama() OWNER TO postgres;

--
-- Name: toplam_kisi_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_kisi_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "kisi";
   RETURN a;
END;
$$;


ALTER FUNCTION public.toplam_kisi_sayisi() OWNER TO postgres;

--
-- Name: toplam_sube_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_sube_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "sube";
   RETURN a;
END;
$$;


ALTER FUNCTION public.toplam_sube_sayisi() OWNER TO postgres;

--
-- Name: toplam_urun_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_urun_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "urun";
   RETURN a;
END;
$$;


ALTER FUNCTION public.toplam_urun_sayisi() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adres (
    adres_id integer NOT NULL,
    adres character varying(2044) NOT NULL,
    ilce_id integer NOT NULL,
    posta_kodu integer NOT NULL,
    kisi_id integer
);


ALTER TABLE public.adres OWNER TO postgres;

--
-- Name: adres_adres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adres_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adres_adres_id_seq OWNER TO postgres;

--
-- Name: adres_adres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adres_adres_id_seq OWNED BY public.adres.adres_id;


--
-- Name: genel_bilgiler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genel_bilgiler (
    id integer NOT NULL,
    sube_id integer NOT NULL,
    toplam_calisan integer NOT NULL,
    toplam_urun integer NOT NULL,
    "aylık_ortalama_musteri" integer NOT NULL
);


ALTER TABLE public.genel_bilgiler OWNER TO postgres;

--
-- Name: genel_bilgiler_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genel_bilgiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genel_bilgiler_id_seq OWNER TO postgres;

--
-- Name: genel_bilgiler_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genel_bilgiler_id_seq OWNED BY public.genel_bilgiler.id;


--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    il_id integer NOT NULL,
    id_adi character varying(2044) NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: il_il_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.il_il_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.il_il_id_seq OWNER TO postgres;

--
-- Name: il_il_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.il_il_id_seq OWNED BY public.il.il_id;


--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    ilce_id integer NOT NULL,
    ilce_adi character varying(2044) NOT NULL,
    il_id integer NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: ilce_ilce_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ilce_ilce_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ilce_ilce_id_seq OWNER TO postgres;

--
-- Name: ilce_ilce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ilce_ilce_id_seq OWNED BY public.ilce.ilce_id;


--
-- Name: is_basvurusu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.is_basvurusu (
    basvuru_id integer NOT NULL,
    isim character varying(2044) NOT NULL,
    pozisyon character varying(2044) NOT NULL,
    maas_beklenti integer NOT NULL,
    tarih date NOT NULL,
    sube_id integer NOT NULL
);


ALTER TABLE public.is_basvurusu OWNER TO postgres;

--
-- Name: is_basvurusu_basvuru_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.is_basvurusu_basvuru_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.is_basvurusu_basvuru_id_seq OWNER TO postgres;

--
-- Name: is_basvurusu_basvuru_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.is_basvurusu_basvuru_id_seq OWNED BY public.is_basvurusu.basvuru_id;


--
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    kategori_id integer NOT NULL,
    kategori_adi character varying(2044) NOT NULL
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- Name: kategori_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategori_kategori_id_seq OWNER TO postgres;

--
-- Name: kategori_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategori_kategori_id_seq OWNED BY public.kategori.kategori_id;


--
-- Name: kategori_urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori_urun (
    urun_id integer NOT NULL,
    kategori_id integer NOT NULL
);


ALTER TABLE public.kategori_urun OWNER TO postgres;

--
-- Name: kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kisi (
    kisi_id integer NOT NULL,
    isim character varying(2044) NOT NULL
);


ALTER TABLE public.kisi OWNER TO postgres;

--
-- Name: kisi_kisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kisi_kisi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kisi_kisi_id_seq OWNER TO postgres;

--
-- Name: kisi_kisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kisi_kisi_id_seq OWNED BY public.kisi.kisi_id;


--
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    kisi_id integer NOT NULL,
    isim character varying(2044) NOT NULL,
    bonus_puan integer NOT NULL
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    kisi_id integer NOT NULL,
    isim character varying(2044) NOT NULL,
    sube_id integer NOT NULL,
    bolum character varying(2044) NOT NULL
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- Name: siparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siparis (
    siparis_id integer NOT NULL,
    urun_id integer NOT NULL,
    adres_id integer NOT NULL,
    adet integer NOT NULL,
    kisi_id integer
);


ALTER TABLE public.siparis OWNER TO postgres;

--
-- Name: siparis_siparis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.siparis_siparis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siparis_siparis_id_seq OWNER TO postgres;

--
-- Name: siparis_siparis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.siparis_siparis_id_seq OWNED BY public.siparis.siparis_id;


--
-- Name: sube; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sube (
    sube_id integer NOT NULL,
    ilce_id integer NOT NULL,
    sube_adi character varying(2044) NOT NULL,
    toplam_personel character varying(2044) NOT NULL
);


ALTER TABLE public.sube OWNER TO postgres;

--
-- Name: sube_sube_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sube_sube_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sube_sube_id_seq OWNER TO postgres;

--
-- Name: sube_sube_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sube_sube_id_seq OWNED BY public.sube.sube_id;


--
-- Name: tedarikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tedarikci (
    tedarikci_id integer NOT NULL,
    tedarikci_adi character varying(2044) NOT NULL,
    kategori_id integer NOT NULL
);


ALTER TABLE public.tedarikci OWNER TO postgres;

--
-- Name: tedarikci_tedarikci_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tedarikci_tedarikci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tedarikci_tedarikci_id_seq OWNER TO postgres;

--
-- Name: tedarikci_tedarikci_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tedarikci_tedarikci_id_seq OWNED BY public.tedarikci.tedarikci_id;


--
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    urun_id integer NOT NULL,
    urun_adi character varying(2044) NOT NULL,
    kategori_id integer NOT NULL,
    gelis_fiyat integer NOT NULL,
    satis_fiyat integer NOT NULL,
    tedarikci_id integer NOT NULL
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- Name: urun_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.urun_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urun_urun_id_seq OWNER TO postgres;

--
-- Name: urun_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.urun_urun_id_seq OWNED BY public.urun.urun_id;


--
-- Name: yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yonetici (
    kisi_id integer NOT NULL,
    isim character varying(2044) NOT NULL,
    pozisyon character varying(2044) NOT NULL
);


ALTER TABLE public.yonetici OWNER TO postgres;

--
-- Name: adres adres_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres ALTER COLUMN adres_id SET DEFAULT nextval('public.adres_adres_id_seq'::regclass);


--
-- Name: genel_bilgiler id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genel_bilgiler ALTER COLUMN id SET DEFAULT nextval('public.genel_bilgiler_id_seq'::regclass);


--
-- Name: il il_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il ALTER COLUMN il_id SET DEFAULT nextval('public.il_il_id_seq'::regclass);


--
-- Name: ilce ilce_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce ALTER COLUMN ilce_id SET DEFAULT nextval('public.ilce_ilce_id_seq'::regclass);


--
-- Name: is_basvurusu basvuru_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.is_basvurusu ALTER COLUMN basvuru_id SET DEFAULT nextval('public.is_basvurusu_basvuru_id_seq'::regclass);


--
-- Name: kategori kategori_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori ALTER COLUMN kategori_id SET DEFAULT nextval('public.kategori_kategori_id_seq'::regclass);


--
-- Name: kisi kisi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi ALTER COLUMN kisi_id SET DEFAULT nextval('public.kisi_kisi_id_seq'::regclass);


--
-- Name: siparis siparis_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis ALTER COLUMN siparis_id SET DEFAULT nextval('public.siparis_siparis_id_seq'::regclass);


--
-- Name: sube sube_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sube ALTER COLUMN sube_id SET DEFAULT nextval('public.sube_sube_id_seq'::regclass);


--
-- Name: tedarikci tedarikci_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci ALTER COLUMN tedarikci_id SET DEFAULT nextval('public.tedarikci_tedarikci_id_seq'::regclass);


--
-- Name: urun urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun ALTER COLUMN urun_id SET DEFAULT nextval('public.urun_urun_id_seq'::regclass);


--
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adres VALUES
	(1, 'adres 1', 1, 50, NULL),
	(2, 'adres 2', 3, 5060, NULL),
	(3, 'adres 3', 2, 4050, NULL);


--
-- Data for Name: genel_bilgiler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genel_bilgiler VALUES
	(1, 1, 12, 1700, 3000),
	(2, 2, 15, 1900, 3900),
	(3, 3, 18, 2400, 5000);


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il VALUES
	(1, 'İstanbul'),
	(2, 'Ankara'),
	(3, 'Antalya'),
	(4, 'İzmir');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce VALUES
	(1, 'Kadıköy', 1),
	(2, 'Çankaya', 2),
	(3, 'Lara', 3),
	(4, 'Çeşm', 4),
	(5, 'Beşiktaş', 1);


--
-- Data for Name: is_basvurusu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.is_basvurusu VALUES
	(1, 'Kemal Murtar', 'kasiyer', 2500, '2020-08-11', 1),
	(2, 'Murtar Kemal', 'Kasap', 4000, '2020-08-11', 2),
	(3, 'Serkan Serdar', 'Reyon Görevlisi', 2500, '2020-08-11', 1);


--
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategori VALUES
	(1, 'Süt Ürünleri'),
	(2, 'Et'),
	(3, 'Baklagil'),
	(4, 'Temizlik'),
	(5, 'Atıştırmalık'),
	(6, 'İçecek'),
	(7, 'Şekerleme');


--
-- Data for Name: kategori_urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategori_urun VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4);


--
-- Data for Name: kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kisi VALUES
	(1, 'Serpil Mutlu'),
	(2, 'Gurbet Kanneci'),
	(3, 'Emrecan Korkmaz'),
	(4, 'Aynur Yurtlu'),
	(5, 'Hasan Uludağ'),
	(6, 'Suna Görmeli');


--
-- Data for Name: musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri VALUES
	(1, ' Serpil Mtlu', 150),
	(2, 'Gurbet Kanneci', 100);


--
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel VALUES
	(3, 'Emrecan Korkmaz', 1, 'Tezgahtar'),
	(4, 'Aynur Yurtlu', 2, 'Kasiyer');


--
-- Data for Name: siparis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.siparis VALUES
	(1, 1, 1, 2, NULL),
	(2, 3, 2, 5, NULL),
	(3, 5, 1, 12, NULL);


--
-- Data for Name: sube; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sube VALUES
	(1, 1, 'Kadıköy Şube', '14'),
	(2, 2, 'Çankaya Şube', '12'),
	(3, 3, 'Lara Şube', '10');


--
-- Data for Name: tedarikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tedarikci VALUES
	(1, 'Kardeşler Tedarik', 1),
	(2, 'Kuzenler Tedarik', 2),
	(3, 'Akrabalar Tedarik', 3);


--
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.urun VALUES
	(1, 'Çikolata', 7, 5, 15, 1),
	(2, 'Et', 2, 50, 51, 2),
	(3, 'Mendil', 4, 15, 20, 3),
	(4, 'Soslu fıstık', 5, 5, 7, 1),
	(5, 'Baldo Pirinç', 3, 9, 14, 2);


--
-- Data for Name: yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yonetici VALUES
	(5, 'Hasan Uludağ', 'İnsan Kaynakları Müdürü'),
	(6, 'Suna Görmeli', 'Bölge Müdürü');


--
-- Name: adres_adres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adres_adres_id_seq', 3, true);


--
-- Name: genel_bilgiler_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genel_bilgiler_id_seq', 3, true);


--
-- Name: il_il_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.il_il_id_seq', 4, true);


--
-- Name: ilce_ilce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilce_ilce_id_seq', 5, true);


--
-- Name: is_basvurusu_basvuru_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.is_basvurusu_basvuru_id_seq', 3, true);


--
-- Name: kategori_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_kategori_id_seq', 7, true);


--
-- Name: kisi_kisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kisi_kisi_id_seq', 6, true);


--
-- Name: siparis_siparis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.siparis_siparis_id_seq', 3, true);


--
-- Name: sube_sube_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sube_sube_id_seq', 3, true);


--
-- Name: tedarikci_tedarikci_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tedarikci_tedarikci_id_seq', 3, true);


--
-- Name: urun_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urun_urun_id_seq', 8, true);


--
-- Name: adres adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY (adres_id);


--
-- Name: genel_bilgiler genel_bilgiler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genel_bilgiler
    ADD CONSTRAINT genel_bilgiler_pkey PRIMARY KEY (id);


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY (il_id);


--
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY (ilce_id);


--
-- Name: is_basvurusu is_basvurusu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.is_basvurusu
    ADD CONSTRAINT is_basvurusu_pkey PRIMARY KEY (basvuru_id);


--
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (kategori_id);


--
-- Name: kategori_urun kategori_urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_urun
    ADD CONSTRAINT kategori_urun_pkey PRIMARY KEY (urun_id, kategori_id);


--
-- Name: kisi kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT kisi_pkey PRIMARY KEY (kisi_id);


--
-- Name: musteri musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT musteri_pkey PRIMARY KEY (kisi_id);


--
-- Name: personel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (kisi_id);


--
-- Name: siparis siparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_pkey PRIMARY KEY (siparis_id);


--
-- Name: sube sube_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sube
    ADD CONSTRAINT sube_pkey PRIMARY KEY (sube_id);


--
-- Name: tedarikci tedarikci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT tedarikci_pkey PRIMARY KEY (tedarikci_id);


--
-- Name: urun urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY (urun_id);


--
-- Name: yonetici yonetici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT yonetici_pkey PRIMARY KEY (kisi_id);


--
-- Name: siparis lnk_adres_siparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT lnk_adres_siparis FOREIGN KEY (adres_id) REFERENCES public.adres(adres_id) MATCH FULL;


--
-- Name: ilce lnk_il_ilce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT lnk_il_ilce FOREIGN KEY (il_id) REFERENCES public.il(il_id) MATCH FULL;


--
-- Name: adres lnk_ilce_adres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT lnk_ilce_adres FOREIGN KEY (ilce_id) REFERENCES public.ilce(ilce_id) MATCH FULL;


--
-- Name: sube lnk_ilce_sube; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sube
    ADD CONSTRAINT lnk_ilce_sube FOREIGN KEY (ilce_id) REFERENCES public.ilce(ilce_id) MATCH FULL;


--
-- Name: kategori_urun lnk_kategori_kategori_urun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_urun
    ADD CONSTRAINT lnk_kategori_kategori_urun FOREIGN KEY (kategori_id) REFERENCES public.kategori(kategori_id) MATCH FULL;


--
-- Name: adres lnk_kisi_adres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT lnk_kisi_adres FOREIGN KEY (kisi_id) REFERENCES public.kisi(kisi_id) MATCH FULL;


--
-- Name: musteri lnk_kisi_musteri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT lnk_kisi_musteri FOREIGN KEY (kisi_id) REFERENCES public.kisi(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel lnk_kisi_personel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT lnk_kisi_personel FOREIGN KEY (kisi_id) REFERENCES public.kisi(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yonetici lnk_kisi_yonetici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT lnk_kisi_yonetici FOREIGN KEY (kisi_id) REFERENCES public.kisi(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: siparis lnk_musteri_siparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT lnk_musteri_siparis FOREIGN KEY (kisi_id) REFERENCES public.musteri(kisi_id) MATCH FULL;


--
-- Name: genel_bilgiler lnk_sube_genel_bilgiler; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genel_bilgiler
    ADD CONSTRAINT lnk_sube_genel_bilgiler FOREIGN KEY (sube_id) REFERENCES public.sube(sube_id) MATCH FULL;


--
-- Name: is_basvurusu lnk_sube_is_basvurusu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.is_basvurusu
    ADD CONSTRAINT lnk_sube_is_basvurusu FOREIGN KEY (sube_id) REFERENCES public.sube(sube_id) MATCH FULL;


--
-- Name: kategori_urun lnk_urun_kategori_urun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_urun
    ADD CONSTRAINT lnk_urun_kategori_urun FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: siparis lnk_urun_siparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT lnk_urun_siparis FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id) MATCH FULL;


--
-- PostgreSQL database dump complete
--

