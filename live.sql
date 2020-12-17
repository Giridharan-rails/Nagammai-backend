--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: _HOW_TO_RECOVER; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_HOW_TO_RECOVER" (
    id integer NOT NULL,
    message character varying
);


ALTER TABLE public."_HOW_TO_RECOVER" OWNER TO postgres;

--
-- Name: _HOW_TO_RECOVER_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."_HOW_TO_RECOVER_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."_HOW_TO_RECOVER_id_seq" OWNER TO postgres;

--
-- Name: _HOW_TO_RECOVER_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."_HOW_TO_RECOVER_id_seq" OWNED BY public."_HOW_TO_RECOVER".id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id bigint NOT NULL,
    appoint_date date,
    appoint_time character varying,
    contacts_ids character varying,
    appoint_note character varying,
    app_contact_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    app_contact_type character varying
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointments_id_seq OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: cfa_titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfa_titles (
    id bigint NOT NULL,
    job_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.cfa_titles OWNER TO postgres;

--
-- Name: cfa_titles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfa_titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cfa_titles_id_seq OWNER TO postgres;

--
-- Name: cfa_titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfa_titles_id_seq OWNED BY public.cfa_titles.id;


--
-- Name: claim_issues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_issues (
    id bigint NOT NULL,
    description character varying,
    cut_off_date date,
    status character varying,
    notes character varying,
    contact_id bigint,
    appointment_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    approval boolean
);


ALTER TABLE public.claim_issues OWNER TO postgres;

--
-- Name: claim_issues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.claim_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.claim_issues_id_seq OWNER TO postgres;

--
-- Name: claim_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.claim_issues_id_seq OWNED BY public.claim_issues.id;


--
-- Name: claim_mails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_mails (
    id bigint NOT NULL,
    email character varying,
    claim_no character varying,
    status character varying,
    claim_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.claim_mails OWNER TO postgres;

--
-- Name: claim_mails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.claim_mails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.claim_mails_id_seq OWNER TO postgres;

--
-- Name: claim_mails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.claim_mails_id_seq OWNED BY public.claim_mails.id;


--
-- Name: claim_syns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_syns (
    id bigint NOT NULL,
    p_code integer,
    describtion character varying,
    packing character varying,
    batch_desc character varying,
    expiry_date date,
    quantity integer,
    bill_date date,
    bill_number character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.claim_syns OWNER TO postgres;

--
-- Name: claim_syns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.claim_syns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.claim_syns_id_seq OWNER TO postgres;

--
-- Name: claim_syns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.claim_syns_id_seq OWNED BY public.claim_syns.id;


--
-- Name: claims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claims (
    id bigint NOT NULL,
    claim_no character varying,
    type_of_claim character varying,
    claim_date date,
    product_code character varying,
    expiry_date date,
    quantity integer,
    claim_amount double precision,
    settled_amount double precision,
    bill_date date,
    bill_number character varying,
    status character varying,
    supplier_code character varying,
    supplier_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description character varying
);


ALTER TABLE public.claims OWNER TO postgres;

--
-- Name: claims_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.claims_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.claims_id_seq OWNER TO postgres;

--
-- Name: claims_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.claims_id_seq OWNED BY public.claims.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    phone_number bigint,
    address character varying,
    jobs_name_type character varying,
    jobs_name_id integer,
    sub_contact_type character varying,
    sub_contact_id integer,
    mail_allocation character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: division_syns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_syns (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    phone_number bigint,
    address character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.division_syns OWNER TO postgres;

--
-- Name: division_syns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_syns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.division_syns_id_seq OWNER TO postgres;

--
-- Name: division_syns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_syns_id_seq OWNED BY public.division_syns.id;


--
-- Name: divisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.divisions (
    id bigint NOT NULL,
    div_name character varying,
    div_code character varying,
    mfr_code character varying,
    div_abb character varying,
    address_one character varying,
    address_two character varying,
    address_three character varying,
    city character varying,
    state character varying,
    country character varying,
    manufacturer_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_id character varying
);


ALTER TABLE public.divisions OWNER TO postgres;

--
-- Name: divisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.divisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.divisions_id_seq OWNER TO postgres;

--
-- Name: divisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.divisions_id_seq OWNED BY public.divisions.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emails (
    id bigint NOT NULL,
    from_mail character varying,
    to_mail character varying,
    subject character varying,
    message character varying,
    attachment character varying,
    date date,
    supplier_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.emails OWNER TO postgres;

--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emails_id_seq OWNER TO postgres;

--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emails_id_seq OWNED BY public.emails.id;


--
-- Name: expiry_damage_emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expiry_damage_emails (
    id bigint NOT NULL,
    claim_no character varying,
    claim_date date,
    email character varying,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.expiry_damage_emails OWNER TO postgres;

--
-- Name: expiry_damage_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expiry_damage_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expiry_damage_emails_id_seq OWNER TO postgres;

--
-- Name: expiry_damage_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expiry_damage_emails_id_seq OWNED BY public.expiry_damage_emails.id;


--
-- Name: expiry_damages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expiry_damages (
    id bigint NOT NULL,
    supplier_code character varying,
    claim_no character varying,
    ack_date date,
    courier_lr_number character varying,
    courier_date date,
    courier_weight character varying,
    ref_no character varying,
    product_code character varying,
    item_desc character varying,
    packing character varying,
    quantity character varying,
    free_quantity character varying,
    batch_desc character varying,
    expiry_date date,
    mrp double precision,
    rate double precision,
    claim_amount character varying,
    settled_amount character varying,
    supplier_id bigint,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.expiry_damages OWNER TO postgres;

--
-- Name: expiry_damages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expiry_damages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expiry_damages_id_seq OWNER TO postgres;

--
-- Name: expiry_damages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expiry_damages_id_seq OWNED BY public.expiry_damages.id;


--
-- Name: free_discount_emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.free_discount_emails (
    id bigint NOT NULL,
    claim_no character varying,
    claim_date date,
    email character varying,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.free_discount_emails OWNER TO postgres;

--
-- Name: free_discount_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.free_discount_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.free_discount_emails_id_seq OWNER TO postgres;

--
-- Name: free_discount_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.free_discount_emails_id_seq OWNED BY public.free_discount_emails.id;


--
-- Name: free_discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.free_discounts (
    id bigint NOT NULL,
    claim_no character varying,
    ack_date date,
    supplier_code character varying,
    customer_name character varying,
    product_code character varying,
    product_name character varying,
    total_quantity character varying,
    rate character varying,
    overall_discount_percentage character varying,
    overall_discount_amount character varying,
    bill_number character varying,
    bill_date date,
    claim_amount character varying,
    settled_amount character varying,
    supplier_id bigint,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.free_discounts OWNER TO postgres;

--
-- Name: free_discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.free_discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.free_discounts_id_seq OWNER TO postgres;

--
-- Name: free_discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.free_discounts_id_seq OWNED BY public.free_discounts.id;


--
-- Name: goods_receipts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goods_receipts (
    id bigint NOT NULL,
    gr_no character varying,
    gr_date date,
    invoice_no character varying,
    amount double precision,
    quantity integer,
    purchase_order_code character varying,
    product_code character varying,
    supplier_code character varying,
    status character varying,
    product_id bigint,
    supplier_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.goods_receipts OWNER TO postgres;

--
-- Name: goods_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goods_receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goods_receipts_id_seq OWNER TO postgres;

--
-- Name: goods_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goods_receipts_id_seq OWNED BY public.goods_receipts.id;


--
-- Name: manufacturer_syns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturer_syns (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    phone_number bigint,
    address character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.manufacturer_syns OWNER TO postgres;

--
-- Name: manufacturer_syns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturer_syns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manufacturer_syns_id_seq OWNER TO postgres;

--
-- Name: manufacturer_syns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturer_syns_id_seq OWNED BY public.manufacturer_syns.id;


--
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id bigint NOT NULL,
    manufacturer_name character varying,
    manufacturer_code character varying,
    manufacturer_abb character varying,
    address_one character varying,
    addrsss_two character varying,
    addrsss_three character varying,
    city character varying,
    state character varying,
    country character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_id character varying
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manufacturers_id_seq OWNER TO postgres;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- Name: marketing_titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marketing_titles (
    id bigint NOT NULL,
    job_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.marketing_titles OWNER TO postgres;

--
-- Name: marketing_titles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marketing_titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marketing_titles_id_seq OWNER TO postgres;

--
-- Name: marketing_titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marketing_titles_id_seq OWNED BY public.marketing_titles.id;


--
-- Name: non_moving_stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.non_moving_stocks (
    id bigint NOT NULL,
    product_code character varying,
    product_name character varying,
    batch_description character varying,
    received_date date,
    last_sale_date date,
    cost_val character varying,
    invoice_number character varying,
    uuu character varying,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.non_moving_stocks OWNER TO postgres;

--
-- Name: non_moving_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.non_moving_stocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.non_moving_stocks_id_seq OWNER TO postgres;

--
-- Name: non_moving_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.non_moving_stocks_id_seq OWNED BY public.non_moving_stocks.id;


--
-- Name: payment_terms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_terms (
    id bigint NOT NULL,
    job_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.payment_terms OWNER TO postgres;

--
-- Name: payment_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_terms_id_seq OWNER TO postgres;

--
-- Name: payment_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_terms_id_seq OWNED BY public.payment_terms.id;


--
-- Name: po_emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.po_emails (
    id bigint NOT NULL,
    order_no character varying,
    order_date date,
    email character varying,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.po_emails OWNER TO postgres;

--
-- Name: po_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.po_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.po_emails_id_seq OWNER TO postgres;

--
-- Name: po_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.po_emails_id_seq OWNED BY public.po_emails.id;


--
-- Name: po_syns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.po_syns (
    id bigint NOT NULL,
    order_no integer,
    order_date date,
    supplier_name character varying,
    total_item integer,
    quantity integer,
    net_amount numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.po_syns OWNER TO postgres;

--
-- Name: po_syns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.po_syns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.po_syns_id_seq OWNER TO postgres;

--
-- Name: po_syns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.po_syns_id_seq OWNED BY public.po_syns.id;


--
-- Name: pogr_mismatches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pogr_mismatches (
    id bigint NOT NULL,
    po_number character varying,
    gr_number character varying,
    product_code character varying,
    product_name character varying,
    supplier_code character varying,
    supplier_name character varying,
    po_quantity character varying,
    gr_quantity character varying,
    excess_quantity character varying,
    status character varying,
    contact_ids character varying,
    failed_ids character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.pogr_mismatches OWNER TO postgres;

--
-- Name: pogr_mismatches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pogr_mismatches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pogr_mismatches_id_seq OWNER TO postgres;

--
-- Name: pogr_mismatches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pogr_mismatches_id_seq OWNED BY public.pogr_mismatches.id;


--
-- Name: pogr_syns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pogr_syns (
    id bigint NOT NULL,
    gr_no character varying,
    date date,
    invoice_no character varying,
    supplier_name character varying,
    gross_amount numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.pogr_syns OWNER TO postgres;

--
-- Name: pogr_syns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pogr_syns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pogr_syns_id_seq OWNER TO postgres;

--
-- Name: pogr_syns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pogr_syns_id_seq OWNED BY public.pogr_syns.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    product_name character varying,
    product_code character varying,
    division_code character varying,
    supplier_code character varying,
    packing character varying,
    hsn_code character varying,
    gst_tax character varying,
    purchase_price double precision,
    sales_price double precision,
    mrp double precision,
    last_sale_date date,
    last_receive_date date,
    total_stock character varying,
    division_id bigint,
    supplier_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_id character varying
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
    id bigint NOT NULL,
    order_no character varying,
    order_date date,
    free_qty character varying,
    quantity character varying,
    amount character varying,
    status character varying,
    product_code character varying,
    product_name character varying,
    old_id character varying,
    supplier_code character varying,
    mfr_code character varying,
    div_code character varying,
    supplier_id bigint,
    manufacturer_id bigint,
    division_id bigint,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_orders_id_seq OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_orders_id_seq OWNED BY public.purchase_orders.id;


--
-- Name: rate_change_emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rate_change_emails (
    id bigint NOT NULL,
    claim_no character varying,
    claim_date date,
    email character varying,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rate_change_emails OWNER TO postgres;

--
-- Name: rate_change_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rate_change_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rate_change_emails_id_seq OWNER TO postgres;

--
-- Name: rate_change_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rate_change_emails_id_seq OWNED BY public.rate_change_emails.id;


--
-- Name: rate_changes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rate_changes (
    id bigint NOT NULL,
    claim_number character varying,
    ack_date date,
    supplier_code character varying,
    div_code character varying,
    product_code character varying,
    product_name character varying,
    quantity character varying,
    batch character varying,
    sales_price character varying,
    rate character varying,
    bill_number character varying,
    bill_date date,
    claim_amount character varying,
    settled_amount character varying,
    supplier_id bigint,
    division_id bigint,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rate_changes OWNER TO postgres;

--
-- Name: rate_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rate_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rate_changes_id_seq OWNER TO postgres;

--
-- Name: rate_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rate_changes_id_seq OWNED BY public.rate_changes.id;


--
-- Name: receive_mails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receive_mails (
    id bigint NOT NULL,
    job_name character varying,
    schedule character varying,
    schedule_period character varying,
    schedule_time character varying,
    last_sync timestamp without time zone,
    path_setting character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.receive_mails OWNER TO postgres;

--
-- Name: receive_mails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.receive_mails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.receive_mails_id_seq OWNER TO postgres;

--
-- Name: receive_mails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.receive_mails_id_seq OWNED BY public.receive_mails.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: send_mails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.send_mails (
    id bigint NOT NULL,
    job_name character varying,
    schedule character varying,
    schedule_period character varying,
    schedule_time character varying,
    send_items character varying,
    last_sync timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.send_mails OWNER TO postgres;

--
-- Name: send_mails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.send_mails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.send_mails_id_seq OWNER TO postgres;

--
-- Name: send_mails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.send_mails_id_seq OWNED BY public.send_mails.id;


--
-- Name: settled_claims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settled_claims (
    id bigint NOT NULL,
    settled_claim_no character varying,
    claim_no character varying,
    settled_date date,
    settled_qty integer,
    settled_amount double precision,
    supplier_code character varying,
    product_code character varying,
    supplier_id bigint,
    claim_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.settled_claims OWNER TO postgres;

--
-- Name: settled_claims_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settled_claims_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settled_claims_id_seq OWNER TO postgres;

--
-- Name: settled_claims_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settled_claims_id_seq OWNED BY public.settled_claims.id;


--
-- Name: sops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sops (
    id bigint NOT NULL,
    order_type character varying,
    payment_term character varying,
    special_offer character varying,
    claims_offer character varying,
    expiry_broken_settlement character varying,
    delivery_order_schedule character varying,
    monthly_appoinment1 date,
    monthly_appoinment2 date,
    monthly_appoinment3 date,
    dispatch_mode character varying,
    current_ns double precision,
    current_ms double precision,
    image character varying,
    division_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.sops OWNER TO postgres;

--
-- Name: sops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sops_id_seq OWNER TO postgres;

--
-- Name: sops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sops_id_seq OWNED BY public.sops.id;


--
-- Name: supplier_syns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier_syns (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    phone_number bigint,
    address character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.supplier_syns OWNER TO postgres;

--
-- Name: supplier_syns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_syns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supplier_syns_id_seq OWNER TO postgres;

--
-- Name: supplier_syns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_syns_id_seq OWNED BY public.supplier_syns.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id bigint NOT NULL,
    supplier_name character varying,
    supplier_code character varying,
    supplier_abb character varying,
    address_one character varying,
    addrsss_two character varying,
    addrsss_three character varying,
    gst_no character varying,
    order_copy_format character varying,
    phone_number character varying,
    city character varying,
    state character varying,
    country character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_id character varying
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: sync_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sync_settings (
    id bigint NOT NULL,
    job_name character varying,
    schedule character varying,
    schedule_period character varying,
    schedule_time character varying,
    last_sync timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.sync_settings OWNER TO postgres;

--
-- Name: sync_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sync_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sync_settings_id_seq OWNER TO postgres;

--
-- Name: sync_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sync_settings_id_seq OWNED BY public.sync_settings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    user_name character varying,
    password character varying,
    email character varying,
    role character varying,
    supplier_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wonder_softs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wonder_softs (
    id bigint NOT NULL,
    user_name character varying,
    password character varying,
    database_name character varying,
    server_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    manual_sync_time integer
);


ALTER TABLE public.wonder_softs OWNER TO postgres;

--
-- Name: wonder_softs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wonder_softs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wonder_softs_id_seq OWNER TO postgres;

--
-- Name: wonder_softs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wonder_softs_id_seq OWNED BY public.wonder_softs.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_HOW_TO_RECOVER" ALTER COLUMN id SET DEFAULT nextval('public."_HOW_TO_RECOVER_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cfa_titles ALTER COLUMN id SET DEFAULT nextval('public.cfa_titles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_issues ALTER COLUMN id SET DEFAULT nextval('public.claim_issues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_mails ALTER COLUMN id SET DEFAULT nextval('public.claim_mails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_syns ALTER COLUMN id SET DEFAULT nextval('public.claim_syns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claims ALTER COLUMN id SET DEFAULT nextval('public.claims_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_syns ALTER COLUMN id SET DEFAULT nextval('public.division_syns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divisions ALTER COLUMN id SET DEFAULT nextval('public.divisions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emails ALTER COLUMN id SET DEFAULT nextval('public.emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expiry_damage_emails ALTER COLUMN id SET DEFAULT nextval('public.expiry_damage_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expiry_damages ALTER COLUMN id SET DEFAULT nextval('public.expiry_damages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.free_discount_emails ALTER COLUMN id SET DEFAULT nextval('public.free_discount_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.free_discounts ALTER COLUMN id SET DEFAULT nextval('public.free_discounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts ALTER COLUMN id SET DEFAULT nextval('public.goods_receipts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer_syns ALTER COLUMN id SET DEFAULT nextval('public.manufacturer_syns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketing_titles ALTER COLUMN id SET DEFAULT nextval('public.marketing_titles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.non_moving_stocks ALTER COLUMN id SET DEFAULT nextval('public.non_moving_stocks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_terms ALTER COLUMN id SET DEFAULT nextval('public.payment_terms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.po_emails ALTER COLUMN id SET DEFAULT nextval('public.po_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.po_syns ALTER COLUMN id SET DEFAULT nextval('public.po_syns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pogr_mismatches ALTER COLUMN id SET DEFAULT nextval('public.pogr_mismatches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pogr_syns ALTER COLUMN id SET DEFAULT nextval('public.pogr_syns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders ALTER COLUMN id SET DEFAULT nextval('public.purchase_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_change_emails ALTER COLUMN id SET DEFAULT nextval('public.rate_change_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_changes ALTER COLUMN id SET DEFAULT nextval('public.rate_changes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receive_mails ALTER COLUMN id SET DEFAULT nextval('public.receive_mails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.send_mails ALTER COLUMN id SET DEFAULT nextval('public.send_mails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settled_claims ALTER COLUMN id SET DEFAULT nextval('public.settled_claims_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sops ALTER COLUMN id SET DEFAULT nextval('public.sops_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_syns ALTER COLUMN id SET DEFAULT nextval('public.supplier_syns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_settings ALTER COLUMN id SET DEFAULT nextval('public.sync_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wonder_softs ALTER COLUMN id SET DEFAULT nextval('public.wonder_softs_id_seq'::regclass);


--
-- Data for Name: _HOW_TO_RECOVER; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_HOW_TO_RECOVER" (id, message) FROM stdin;
1	Hello,\n\nI am a security researcher from Sweden,\nhaving interest on web security and other focus areas.\n\nYour PostgreSQL server(version 9.5.19), database "nagammai_live_devlopment"\nwas breached by a 3rd party and database files were backed up to their cloud hosting storage.\n\nMost likely this database will be sold for private information.\nThe short-term consequences of this data leak could be fines and frustration.\n\nI accidently discovered this dedicated cloud storage and was able to secure the files.\nIt contains full database dump file "nagammai_live_devlopment.sql.gz", created with postgresql pg_dump.\n\nTo restore the database or download this dump file\nplease email me: Linus.RedAlert@pm.me\n\nPS: Make sure to copy/paste this incident ID: 6ed49f4f-f8eb-4648-867b-9f391ae88dd9\n    in email subject line,\n    this help me to verify you as the data owner.\n\nIf your database containes sensitive, financial or personal information,\nupon successfull restore, i can shred remove all the backup \ndump files from remote cloud hosting to prevent information leak.\n\nmy email: Linus.RedAlert@pm.me\nincidentId: 6ed49f4f-f8eb-4648-867b-9f391ae88dd9\n* please copy/paste this incident ID in email subject line
2	I quickly looked through the dump file headers(database "nagammai_live_devlopment"):\n\nIt contains about 295K personal emails,\n  such as duraidp@gmail.com, raveendran38@yahoo.co.in, vivekifn09@gmail.com, raj.mano@gmail.com, asar420ma@gmail.com, jdhanarrajan@lupin.com and others,\n  which will be exploited, their owners will notice the data were compromised.\n\nemail me: Linus.RedAlert@pm.me\nincidentId: 6ed49f4f-f8eb-4648-867b-9f391ae88dd9\n* please include this incident ID in email subject line
3	database summary:\n\n* total tables count: 57\n* total approx. documents count for all tables: 4,5M\n\ntable: "excess_stocks" => 3,2M documents\ntable: "goods_received_notes" => 568K documents\ntable: "excess_stock_emails" => 244K documents\ntable: "excess_stock_logs" => 169K documents\ntable: "expiry_damages" => 111K documents\ntable: "purchase_orders" => 56K documents\ntable: "products" => 38K documents\ntable: "expiry_damage_emails" => 27K documents\ntable: "grn_logs" => 22K documents\ntable: "po_emails" => 16K documents\n.......................\n  \nfull database dump file: nagammai_live_devlopment.sql.gz, about 642.10 MB.\n\n* system/stat/views/functions/triggers or other special tables not counted.\n  these numbers for reference only.\n\nemail me: Linus.RedAlert@pm.me\nincidentId: 6ed49f4f-f8eb-4648-867b-9f391ae88dd9\n* please include this incident ID in email subject line
\.


--
-- Name: _HOW_TO_RECOVER_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."_HOW_TO_RECOVER_id_seq"', 3, true);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, appoint_date, appoint_time, contacts_ids, appoint_note, app_contact_id, created_at, updated_at, app_contact_type) FROM stdin;
\.


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 1, false);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cfa_titles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cfa_titles (id, job_name, created_at, updated_at) FROM stdin;
\.


--
-- Name: cfa_titles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cfa_titles_id_seq', 1, false);


--
-- Data for Name: claim_issues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_issues (id, description, cut_off_date, status, notes, contact_id, appointment_id, created_at, updated_at, approval) FROM stdin;
\.


--
-- Name: claim_issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.claim_issues_id_seq', 1, false);


--
-- Data for Name: claim_mails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_mails (id, email, claim_no, status, claim_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: claim_mails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.claim_mails_id_seq', 1, false);


--
-- Data for Name: claim_syns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_syns (id, p_code, describtion, packing, batch_desc, expiry_date, quantity, bill_date, bill_number, created_at, updated_at) FROM stdin;
\.


--
-- Name: claim_syns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.claim_syns_id_seq', 1, false);


--
-- Data for Name: claims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claims (id, claim_no, type_of_claim, claim_date, product_code, expiry_date, quantity, claim_amount, settled_amount, bill_date, bill_number, status, supplier_code, supplier_id, created_at, updated_at, description) FROM stdin;
\.


--
-- Name: claims_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.claims_id_seq', 1, false);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, name, email, phone_number, address, jobs_name_type, jobs_name_id, sub_contact_type, sub_contact_id, mail_allocation, created_at, updated_at) FROM stdin;
\.


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, false);


--
-- Data for Name: division_syns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_syns (id, name, email, phone_number, address, created_at, updated_at) FROM stdin;
\.


--
-- Name: division_syns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_syns_id_seq', 1, false);


--
-- Data for Name: divisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.divisions (id, div_name, div_code, mfr_code, div_abb, address_one, address_two, address_three, city, state, country, manufacturer_id, created_at, updated_at, old_id) FROM stdin;
\.


--
-- Name: divisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.divisions_id_seq', 1, false);


--
-- Data for Name: emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emails (id, from_mail, to_mail, subject, message, attachment, date, supplier_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emails_id_seq', 1, false);


--
-- Data for Name: expiry_damage_emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expiry_damage_emails (id, claim_no, claim_date, email, status, created_at, updated_at) FROM stdin;
\.


--
-- Name: expiry_damage_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expiry_damage_emails_id_seq', 1, false);


--
-- Data for Name: expiry_damages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expiry_damages (id, supplier_code, claim_no, ack_date, courier_lr_number, courier_date, courier_weight, ref_no, product_code, item_desc, packing, quantity, free_quantity, batch_desc, expiry_date, mrp, rate, claim_amount, settled_amount, supplier_id, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: expiry_damages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expiry_damages_id_seq', 1, false);


--
-- Data for Name: free_discount_emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.free_discount_emails (id, claim_no, claim_date, email, status, created_at, updated_at) FROM stdin;
\.


--
-- Name: free_discount_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.free_discount_emails_id_seq', 1, false);


--
-- Data for Name: free_discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.free_discounts (id, claim_no, ack_date, supplier_code, customer_name, product_code, product_name, total_quantity, rate, overall_discount_percentage, overall_discount_amount, bill_number, bill_date, claim_amount, settled_amount, supplier_id, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: free_discounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.free_discounts_id_seq', 1, false);


--
-- Data for Name: goods_receipts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goods_receipts (id, gr_no, gr_date, invoice_no, amount, quantity, purchase_order_code, product_code, supplier_code, status, product_id, supplier_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: goods_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goods_receipts_id_seq', 1, false);


--
-- Data for Name: manufacturer_syns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturer_syns (id, name, email, phone_number, address, created_at, updated_at) FROM stdin;
\.


--
-- Name: manufacturer_syns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturer_syns_id_seq', 1, false);


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturers (id, manufacturer_name, manufacturer_code, manufacturer_abb, address_one, addrsss_two, addrsss_three, city, state, country, created_at, updated_at, old_id) FROM stdin;
\.


--
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 1, false);


--
-- Data for Name: marketing_titles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marketing_titles (id, job_name, created_at, updated_at) FROM stdin;
\.


--
-- Name: marketing_titles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marketing_titles_id_seq', 1, false);


--
-- Data for Name: non_moving_stocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.non_moving_stocks (id, product_code, product_name, batch_description, received_date, last_sale_date, cost_val, invoice_number, uuu, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: non_moving_stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.non_moving_stocks_id_seq', 1, false);


--
-- Data for Name: payment_terms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_terms (id, job_name, created_at, updated_at) FROM stdin;
\.


--
-- Name: payment_terms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_terms_id_seq', 1, false);


--
-- Data for Name: po_emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.po_emails (id, order_no, order_date, email, status, created_at, updated_at) FROM stdin;
\.


--
-- Name: po_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.po_emails_id_seq', 1, false);


--
-- Data for Name: po_syns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.po_syns (id, order_no, order_date, supplier_name, total_item, quantity, net_amount, created_at, updated_at) FROM stdin;
\.


--
-- Name: po_syns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.po_syns_id_seq', 1, false);


--
-- Data for Name: pogr_mismatches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pogr_mismatches (id, po_number, gr_number, product_code, product_name, supplier_code, supplier_name, po_quantity, gr_quantity, excess_quantity, status, contact_ids, failed_ids, created_at, updated_at) FROM stdin;
\.


--
-- Name: pogr_mismatches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pogr_mismatches_id_seq', 1, false);


--
-- Data for Name: pogr_syns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pogr_syns (id, gr_no, date, invoice_no, supplier_name, gross_amount, created_at, updated_at) FROM stdin;
\.


--
-- Name: pogr_syns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pogr_syns_id_seq', 1, false);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, product_name, product_code, division_code, supplier_code, packing, hsn_code, gst_tax, purchase_price, sales_price, mrp, last_sale_date, last_receive_date, total_stock, division_id, supplier_id, created_at, updated_at, old_id) FROM stdin;
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_orders (id, order_no, order_date, free_qty, quantity, amount, status, product_code, product_name, old_id, supplier_code, mfr_code, div_code, supplier_id, manufacturer_id, division_id, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_orders_id_seq', 1, false);


--
-- Data for Name: rate_change_emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rate_change_emails (id, claim_no, claim_date, email, status, created_at, updated_at) FROM stdin;
\.


--
-- Name: rate_change_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rate_change_emails_id_seq', 1, false);


--
-- Data for Name: rate_changes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rate_changes (id, claim_number, ack_date, supplier_code, div_code, product_code, product_name, quantity, batch, sales_price, rate, bill_number, bill_date, claim_amount, settled_amount, supplier_id, division_id, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: rate_changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rate_changes_id_seq', 1, false);


--
-- Data for Name: receive_mails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receive_mails (id, job_name, schedule, schedule_period, schedule_time, last_sync, path_setting, created_at, updated_at) FROM stdin;
\.


--
-- Name: receive_mails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.receive_mails_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20171118072623
20171118072733
20171118072902
20171118072945
20171118073903
20171118073947
20171118074022
20171118074043
20171118074102
20171118074114
20171121061557
20171121061627
20171121071516
20171121071646
20171121071741
20171121071953
20171121072036
20171124060310
20171124072451
20171124101809
20171124104455
20171124104601
20171124104636
20171124105028
20171124105100
20171124105313
20171129094652
20171205061141
20171205071822
20171205114631
20171211065337
20171211122123
20171213133745
20171213134152
20171213134556
20171213135101
20171214084201
20171214125910
20171214125940
20171214125954
20171215044849
20171216054535
\.


--
-- Data for Name: send_mails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.send_mails (id, job_name, schedule, schedule_period, schedule_time, send_items, last_sync, created_at, updated_at) FROM stdin;
\.


--
-- Name: send_mails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.send_mails_id_seq', 1, false);


--
-- Data for Name: settled_claims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settled_claims (id, settled_claim_no, claim_no, settled_date, settled_qty, settled_amount, supplier_code, product_code, supplier_id, claim_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: settled_claims_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settled_claims_id_seq', 1, false);


--
-- Data for Name: sops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sops (id, order_type, payment_term, special_offer, claims_offer, expiry_broken_settlement, delivery_order_schedule, monthly_appoinment1, monthly_appoinment2, monthly_appoinment3, dispatch_mode, current_ns, current_ms, image, division_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: sops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sops_id_seq', 1, false);


--
-- Data for Name: supplier_syns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier_syns (id, name, email, phone_number, address, created_at, updated_at) FROM stdin;
\.


--
-- Name: supplier_syns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_syns_id_seq', 1, false);


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, supplier_name, supplier_code, supplier_abb, address_one, addrsss_two, addrsss_three, gst_no, order_copy_format, phone_number, city, state, country, created_at, updated_at, old_id) FROM stdin;
\.


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 1, false);


--
-- Data for Name: sync_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sync_settings (id, job_name, schedule, schedule_period, schedule_time, last_sync, created_at, updated_at) FROM stdin;
\.


--
-- Name: sync_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sync_settings_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, user_name, password, email, role, supplier_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Data for Name: wonder_softs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wonder_softs (id, user_name, password, database_name, server_name, created_at, updated_at, manual_sync_time) FROM stdin;
\.


--
-- Name: wonder_softs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wonder_softs_id_seq', 1, false);


--
-- Name: appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cfa_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cfa_titles
    ADD CONSTRAINT cfa_titles_pkey PRIMARY KEY (id);


--
-- Name: claim_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_issues
    ADD CONSTRAINT claim_issues_pkey PRIMARY KEY (id);


--
-- Name: claim_mails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_mails
    ADD CONSTRAINT claim_mails_pkey PRIMARY KEY (id);


--
-- Name: claim_syns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_syns
    ADD CONSTRAINT claim_syns_pkey PRIMARY KEY (id);


--
-- Name: claims_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: division_syns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_syns
    ADD CONSTRAINT division_syns_pkey PRIMARY KEY (id);


--
-- Name: divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (id);


--
-- Name: emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: expiry_damage_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expiry_damage_emails
    ADD CONSTRAINT expiry_damage_emails_pkey PRIMARY KEY (id);


--
-- Name: expiry_damages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expiry_damages
    ADD CONSTRAINT expiry_damages_pkey PRIMARY KEY (id);


--
-- Name: free_discount_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.free_discount_emails
    ADD CONSTRAINT free_discount_emails_pkey PRIMARY KEY (id);


--
-- Name: free_discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.free_discounts
    ADD CONSTRAINT free_discounts_pkey PRIMARY KEY (id);


--
-- Name: goods_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT goods_receipts_pkey PRIMARY KEY (id);


--
-- Name: manufacturer_syns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer_syns
    ADD CONSTRAINT manufacturer_syns_pkey PRIMARY KEY (id);


--
-- Name: manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- Name: marketing_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketing_titles
    ADD CONSTRAINT marketing_titles_pkey PRIMARY KEY (id);


--
-- Name: non_moving_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.non_moving_stocks
    ADD CONSTRAINT non_moving_stocks_pkey PRIMARY KEY (id);


--
-- Name: payment_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_terms
    ADD CONSTRAINT payment_terms_pkey PRIMARY KEY (id);


--
-- Name: po_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.po_emails
    ADD CONSTRAINT po_emails_pkey PRIMARY KEY (id);


--
-- Name: po_syns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.po_syns
    ADD CONSTRAINT po_syns_pkey PRIMARY KEY (id);


--
-- Name: pogr_mismatches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pogr_mismatches
    ADD CONSTRAINT pogr_mismatches_pkey PRIMARY KEY (id);


--
-- Name: pogr_syns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pogr_syns
    ADD CONSTRAINT pogr_syns_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- Name: rate_change_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_change_emails
    ADD CONSTRAINT rate_change_emails_pkey PRIMARY KEY (id);


--
-- Name: rate_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_changes
    ADD CONSTRAINT rate_changes_pkey PRIMARY KEY (id);


--
-- Name: receive_mails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receive_mails
    ADD CONSTRAINT receive_mails_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: send_mails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.send_mails
    ADD CONSTRAINT send_mails_pkey PRIMARY KEY (id);


--
-- Name: settled_claims_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settled_claims
    ADD CONSTRAINT settled_claims_pkey PRIMARY KEY (id);


--
-- Name: sops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sops
    ADD CONSTRAINT sops_pkey PRIMARY KEY (id);


--
-- Name: supplier_syns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_syns
    ADD CONSTRAINT supplier_syns_pkey PRIMARY KEY (id);


--
-- Name: suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: sync_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_settings
    ADD CONSTRAINT sync_settings_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wonder_softs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wonder_softs
    ADD CONSTRAINT wonder_softs_pkey PRIMARY KEY (id);


--
-- Name: index_claim_issues_on_appointment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_claim_issues_on_appointment_id ON public.claim_issues USING btree (appointment_id);


--
-- Name: index_claim_issues_on_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_claim_issues_on_contact_id ON public.claim_issues USING btree (contact_id);


--
-- Name: index_claim_mails_on_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_claim_mails_on_claim_id ON public.claim_mails USING btree (claim_id);


--
-- Name: index_claims_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_claims_on_supplier_id ON public.claims USING btree (supplier_id);


--
-- Name: index_divisions_on_manufacturer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_divisions_on_manufacturer_id ON public.divisions USING btree (manufacturer_id);


--
-- Name: index_expiry_damages_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_expiry_damages_on_product_id ON public.expiry_damages USING btree (product_id);


--
-- Name: index_expiry_damages_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_expiry_damages_on_supplier_id ON public.expiry_damages USING btree (supplier_id);


--
-- Name: index_free_discounts_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_free_discounts_on_product_id ON public.free_discounts USING btree (product_id);


--
-- Name: index_free_discounts_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_free_discounts_on_supplier_id ON public.free_discounts USING btree (supplier_id);


--
-- Name: index_goods_receipts_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_goods_receipts_on_product_id ON public.goods_receipts USING btree (product_id);


--
-- Name: index_goods_receipts_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_goods_receipts_on_supplier_id ON public.goods_receipts USING btree (supplier_id);


--
-- Name: index_non_moving_stocks_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_non_moving_stocks_on_product_id ON public.non_moving_stocks USING btree (product_id);


--
-- Name: index_products_on_division_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_products_on_division_id ON public.products USING btree (division_id);


--
-- Name: index_products_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_products_on_supplier_id ON public.products USING btree (supplier_id);


--
-- Name: index_purchase_orders_on_division_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_purchase_orders_on_division_id ON public.purchase_orders USING btree (division_id);


--
-- Name: index_purchase_orders_on_manufacturer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_purchase_orders_on_manufacturer_id ON public.purchase_orders USING btree (manufacturer_id);


--
-- Name: index_purchase_orders_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_purchase_orders_on_product_id ON public.purchase_orders USING btree (product_id);


--
-- Name: index_purchase_orders_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_purchase_orders_on_supplier_id ON public.purchase_orders USING btree (supplier_id);


--
-- Name: index_rate_changes_on_division_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rate_changes_on_division_id ON public.rate_changes USING btree (division_id);


--
-- Name: index_rate_changes_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rate_changes_on_product_id ON public.rate_changes USING btree (product_id);


--
-- Name: index_rate_changes_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rate_changes_on_supplier_id ON public.rate_changes USING btree (supplier_id);


--
-- Name: index_settled_claims_on_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_settled_claims_on_claim_id ON public.settled_claims USING btree (claim_id);


--
-- Name: index_settled_claims_on_supplier_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_settled_claims_on_supplier_id ON public.settled_claims USING btree (supplier_id);


--
-- Name: index_sops_on_division_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_sops_on_division_id ON public.sops USING btree (division_id);


--
-- Name: fk_rails_069332d2d9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settled_claims
    ADD CONSTRAINT fk_rails_069332d2d9 FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_17eb0bd503; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.free_discounts
    ADD CONSTRAINT fk_rails_17eb0bd503 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: fk_rails_1841b6c8e6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT fk_rails_1841b6c8e6 FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id);


--
-- Name: fk_rails_1aa9b0116b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_1aa9b0116b FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_1d67bb2d7b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fk_rails_1d67bb2d7b FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_46bb1f3749; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_46bb1f3749 FOREIGN KEY (division_id) REFERENCES public.divisions(id);


--
-- Name: fk_rails_5addc81cf8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_issues
    ADD CONSTRAINT fk_rails_5addc81cf8 FOREIGN KEY (contact_id) REFERENCES public.contacts(id);


--
-- Name: fk_rails_65557b48d7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT fk_rails_65557b48d7 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: fk_rails_820141c2a2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fk_rails_820141c2a2 FOREIGN KEY (division_id) REFERENCES public.divisions(id);


--
-- Name: fk_rails_8a998555a2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settled_claims
    ADD CONSTRAINT fk_rails_8a998555a2 FOREIGN KEY (claim_id) REFERENCES public.claims(id);


--
-- Name: fk_rails_8b49f507d8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_changes
    ADD CONSTRAINT fk_rails_8b49f507d8 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: fk_rails_96ffb37b9e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_issues
    ADD CONSTRAINT fk_rails_96ffb37b9e FOREIGN KEY (appointment_id) REFERENCES public.appointments(id);


--
-- Name: fk_rails_a0f16c68b8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expiry_damages
    ADD CONSTRAINT fk_rails_a0f16c68b8 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: fk_rails_a3256751bc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fk_rails_a3256751bc FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: fk_rails_a982921bb2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sops
    ADD CONSTRAINT fk_rails_a982921bb2 FOREIGN KEY (division_id) REFERENCES public.divisions(id);


--
-- Name: fk_rails_acff7693fa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT fk_rails_acff7693fa FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_b9742c3aa6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expiry_damages
    ADD CONSTRAINT fk_rails_b9742c3aa6 FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_bef552ee7e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.free_discounts
    ADD CONSTRAINT fk_rails_bef552ee7e FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_c7553c7f6e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_changes
    ADD CONSTRAINT fk_rails_c7553c7f6e FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: fk_rails_ca23eb03eb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.non_moving_stocks
    ADD CONSTRAINT fk_rails_ca23eb03eb FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: fk_rails_cd1707b1be; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fk_rails_cd1707b1be FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id);


--
-- Name: fk_rails_cfad41a305; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_mails
    ADD CONSTRAINT fk_rails_cfad41a305 FOREIGN KEY (claim_id) REFERENCES public.claims(id);


--
-- Name: fk_rails_d8acccf8f4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_changes
    ADD CONSTRAINT fk_rails_d8acccf8f4 FOREIGN KEY (division_id) REFERENCES public.divisions(id);


--
-- Name: fk_rails_df6450b6dd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT fk_rails_df6450b6dd FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

