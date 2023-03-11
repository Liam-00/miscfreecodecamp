--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    username character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('user_1678526033513', 2, 277);
INSERT INTO public.users VALUES ('user_1678526033514', 5, 390);
INSERT INTO public.users VALUES ('user_1678527191117', 2, 705);
INSERT INTO public.users VALUES ('user_1678527191118', 5, 322);
INSERT INTO public.users VALUES ('user_1678527228071', 2, 688);
INSERT INTO public.users VALUES ('user_1678527228072', 5, 123);
INSERT INTO public.users VALUES ('user_1678527384369', 2, 177);
INSERT INTO public.users VALUES ('user_1678527384370', 5, 349);
INSERT INTO public.users VALUES ('user_1678527389879', 2, 569);
INSERT INTO public.users VALUES ('user_1678527389880', 5, 316);
INSERT INTO public.users VALUES ('Liam', 4, 1);
INSERT INTO public.users VALUES ('user_1678527425661', 2, 684);
INSERT INTO public.users VALUES ('user_1678527425662', 5, 129);
INSERT INTO public.users VALUES ('Test', 1, 3);
INSERT INTO public.users VALUES ('user_1678527460350', 2, 516);
INSERT INTO public.users VALUES ('user_1678527460351', 5, 247);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- PostgreSQL database dump complete
--

