--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.topics DROP CONSTRAINT activities_subject_id_fkey;
ALTER TABLE ONLY public.subjects DROP CONSTRAINT subjects_pkey;
ALTER TABLE ONLY public.subjects DROP CONSTRAINT subjects_name_key;
ALTER TABLE ONLY public.topics DROP CONSTRAINT activities_pkey;
ALTER TABLE public.topics ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.subjects ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.topics_id_seq;
DROP TABLE public.topics;
DROP SEQUENCE public.subjects_id_seq;
DROP TABLE public.subjects;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: Zach
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO "Zach";

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: Zach
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: subjects; Type: TABLE; Schema: public; Owner: Zach
--

CREATE TABLE subjects (
    id integer NOT NULL,
    name text NOT NULL,
    duration text
);


ALTER TABLE subjects OWNER TO "Zach";

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: Zach
--

CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subjects_id_seq OWNER TO "Zach";

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Zach
--

ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: Zach
--

CREATE TABLE topics (
    id integer NOT NULL,
    name text NOT NULL,
    time_elapsed text,
    subject_id integer NOT NULL
);


ALTER TABLE topics OWNER TO "Zach";

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: Zach
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE topics_id_seq OWNER TO "Zach";

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Zach
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Zach
--

ALTER TABLE ONLY subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Zach
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Zach
--

SELECT pg_catalog.setval('subjects_id_seq', 10, true);

--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Zach
--

SELECT pg_catalog.setval('topics_id_seq', 8, true);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: Zach
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: subjects_name_key; Type: CONSTRAINT; Schema: public; Owner: Zach
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_name_key UNIQUE (name);


--
-- Name: subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: Zach
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: activities_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Zach
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT activities_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES subjects(id);


--
-- PostgreSQL database dump complete
--

CREATE TABLE time_entries (
  id serial PRIMARY KEY,
  start_time timestamp DEFAULT now(),
  end_time timestamp,
  topic_id integer REFERENCES topics (id)
);

--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: Zach
--

INSERT INTO subjects VALUES (1, 'Javascript', NULL);
INSERT INTO subjects VALUES (2, 'Sinatra', NULL);
INSERT INTO subjects VALUES (3, 'Ruby', NULL);
INSERT INTO subjects VALUES (4, 'Kitchen Cabinets', NULL);
INSERT INTO subjects VALUES (5, 'C#', NULL);

--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: Zach
--

INSERT INTO topics VALUES (1, 'Loops', NULL, 1);
INSERT INTO topics VALUES (2, 'Variable Scope', NULL, 1);
INSERT INTO topics VALUES (3, 'Objects', NULL, 1);
INSERT INTO topics VALUES (4, 'Arrays', NULL, 1);
INSERT INTO topics VALUES (5, 'Instance Variables', NULL, 3);
INSERT INTO topics VALUES (6, 'MiniTest', NULL, 3);
INSERT INTO topics VALUES (7, 'Queries', NULL, 2);
INSERT INTO topics VALUES (8, 'Views', NULL, 2);




