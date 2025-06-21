--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-21 11:02:15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 236 (class 1259 OID 16548)
-- Name: assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignments (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    max_score integer DEFAULT 100,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.assignments OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16547)
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assignments_id_seq OWNER TO postgres;

--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 235
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assignments_id_seq OWNED BY public.assignments.id;


--
-- TOC entry 242 (class 1259 OID 16697)
-- Name: attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachments (
    id integer NOT NULL,
    original_name character varying(100) NOT NULL,
    size integer NOT NULL,
    public_id character varying(255) NOT NULL,
    secure_url text NOT NULL,
    format character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    mime_type character varying(100) NOT NULL,
    lesson_id integer,
    submission_id integer
);


ALTER TABLE public.attachments OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16696)
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attachments_id_seq OWNER TO postgres;

--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 241
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attachments_id_seq OWNED BY public.attachments.id;


--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16404)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 219
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 240 (class 1259 OID 16597)
-- Name: course_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_reviews (
    id integer NOT NULL,
    user_id integer NOT NULL,
    course_id integer NOT NULL,
    rating integer,
    feedback text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT course_reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.course_reviews OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16596)
-- Name: course_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_reviews_id_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 239
-- Name: course_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_reviews_id_seq OWNED BY public.course_reviews.id;


--
-- TOC entry 222 (class 1259 OID 16413)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    instructor_id integer NOT NULL,
    category_id integer,
    thumbnail_url character varying(255),
    duration integer DEFAULT 0,
    status character varying(20) DEFAULT 'pending'::character varying,
    feedback text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT courses_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16412)
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_id_seq OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 221
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- TOC entry 224 (class 1259 OID 16437)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    course_id integer NOT NULL,
    enrolled_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone,
    progress integer DEFAULT 0
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16436)
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollments_id_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 223
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- TOC entry 230 (class 1259 OID 16493)
-- Name: lesson_completions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_completions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    lesson_id integer NOT NULL,
    completed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.lesson_completions OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16492)
-- Name: lesson_completions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_completions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_completions_id_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 229
-- Name: lesson_completions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_completions_id_seq OWNED BY public.lesson_completions.id;


--
-- TOC entry 228 (class 1259 OID 16475)
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    module_id integer NOT NULL,
    title character varying(255) NOT NULL,
    content_type character varying(50) NOT NULL,
    content_url character varying(255),
    duration integer DEFAULT 0,
    "order" integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT lessons_content_type_check CHECK (((content_type)::text = ANY ((ARRAY['video'::character varying, 'quiz'::character varying, 'text'::character varying])::text[])))
);


ALTER TABLE public.lessons OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16474)
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lessons_id_seq OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 227
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- TOC entry 226 (class 1259 OID 16458)
-- Name: modules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modules (
    id integer NOT NULL,
    course_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    "order" integer NOT NULL,
    duration integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.modules OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16457)
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modules_id_seq OWNER TO postgres;

--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 225
-- Name: modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modules_id_seq OWNED BY public.modules.id;


--
-- TOC entry 234 (class 1259 OID 16530)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    quiz_id integer NOT NULL,
    question text NOT NULL,
    options jsonb NOT NULL,
    correct_answer character varying(255) NOT NULL,
    score integer DEFAULT 1,
    "order" integer DEFAULT 1,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16529)
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 233
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- TOC entry 232 (class 1259 OID 16513)
-- Name: quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quizzes (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    max_score integer DEFAULT 10,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    title character varying(255) DEFAULT 'Untitled Quiz'::character varying NOT NULL
);


ALTER TABLE public.quizzes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16512)
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quizzes_id_seq OWNER TO postgres;

--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 231
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- TOC entry 238 (class 1259 OID 16565)
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submissions (
    id integer NOT NULL,
    assignment_id integer NOT NULL,
    user_id integer NOT NULL,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    grade integer,
    feedback text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    submission_url text,
    attachment_id integer
);


ALTER TABLE public.submissions OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16564)
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submissions_id_seq OWNER TO postgres;

--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 237
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255),
    avatar character varying(255),
    role character varying(50) NOT NULL,
    oauth_provider character varying(50),
    oauth_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    last_login timestamp without time zone,
    is_active boolean DEFAULT true,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['student'::character varying, 'instructor'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4836 (class 2604 OID 16551)
-- Name: assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments ALTER COLUMN id SET DEFAULT nextval('public.assignments_id_seq'::regclass);


--
-- TOC entry 4847 (class 2604 OID 16700)
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments ALTER COLUMN id SET DEFAULT nextval('public.attachments_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 16408)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4844 (class 2604 OID 16600)
-- Name: course_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews ALTER COLUMN id SET DEFAULT nextval('public.course_reviews_id_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 16416)
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- TOC entry 4813 (class 2604 OID 16440)
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 16496)
-- Name: lesson_completions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_completions ALTER COLUMN id SET DEFAULT nextval('public.lesson_completions_id_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 16478)
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 16461)
-- Name: modules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules ALTER COLUMN id SET DEFAULT nextval('public.modules_id_seq'::regclass);


--
-- TOC entry 4831 (class 2604 OID 16533)
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- TOC entry 4826 (class 2604 OID 16516)
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- TOC entry 4840 (class 2604 OID 16568)
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 16393)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5092 (class 0 OID 16548)
-- Dependencies: 236
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assignments (id, lesson_id, title, description, max_score, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5098 (class 0 OID 16697)
-- Dependencies: 242
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachments (id, original_name, size, public_id, secure_url, format, created_at, mime_type, lesson_id, submission_id) FROM stdin;
\.


--
-- TOC entry 5076 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, created_at) FROM stdin;
1	Programming	2025-06-11 19:43:33.874217
2	Design	2025-06-11 19:43:33.874217
4	Web Development	2025-06-12 02:21:21.144684
5	dddfasdfa	2025-06-12 02:23:49.308785
3	Business	2025-06-11 19:43:33.874217
90001	Programming	2025-06-14 02:02:27.057111
\.


--
-- TOC entry 5096 (class 0 OID 16597)
-- Dependencies: 240
-- Data for Name: course_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_reviews (id, user_id, course_id, rating, feedback, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5078 (class 0 OID 16413)
-- Dependencies: 222
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, title, description, instructor_id, category_id, thumbnail_url, duration, status, feedback, created_at, updated_at) FROM stdin;
1	JavaScript Fundamentals	Learn the basics of JavaScript programming	2	1	https://example.com/js-course.jpg	30	approved	\N	2025-06-11 19:44:09.24	2025-06-11 19:44:09.24
2	JS Basics Updated	Master advanced React concepts	3	1	https://example.com/react-course.jpg	45	approved	\N	2025-06-11 19:44:09.24	2025-06-11 22:24:25.185298
9	Test Course	A course for testing	2	\N	\N	0	pending	\N	2025-06-12 15:59:29.547904	2025-06-12 15:59:29.547904
10	Test Course	A course for testing	3	\N	\N	0	pending	\N	2025-06-12 15:59:45.354139	2025-06-12 15:59:45.354139
11	Full Stack Web Development	Learn full stack web development from scratch.	7	\N	https://example.com/thumb1.jpg	600	approved	\N	2025-06-12 18:02:18.592764	2025-06-12 18:02:18.592764
1001	Advanced JavaScript Mastery	Deep dive into JavaScript including ES6+, async patterns, and architecture.	3	\N	https://example.com/js-course.jpg	480	approved	\N	2025-06-12 18:49:38.115552	2025-06-12 18:49:38.115552
90001	JavaScript Basics	Learn JS from scratch	90001	90001	js.png	90	approved	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111
90002	Advanced Python	Deep dive into Python	90002	90001	python.png	120	approved	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111
90003	HTML & CSS	Build beautiful websites	90001	90001	htmlcss.png	60	approved	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111
8	sara Crash Course	Learn express.js from scratch.	3	1	https://example.com/node.jpg	20	rejected	\N	2025-06-11 22:05:59.079756	2025-06-20 16:09:01.940588
4	Node.js Crash Course	Learn Node.js from scratch.	3	1	https://example.com/node.jpg	20	approved	\N	2025-06-11 20:37:39.118426	2025-06-20 16:11:02.737257
15	HTML Crash Course	Learn Html from scratch.	3	1	https://example.com/html.jpg	30	pending	\N	2025-06-20 16:15:52.71511	2025-06-20 16:15:52.71511
\.


--
-- TOC entry 5080 (class 0 OID 16437)
-- Dependencies: 224
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (id, user_id, course_id, enrolled_at, completed_at, progress) FROM stdin;
1	4	1	2025-06-11 19:44:44.754418	\N	25
2	6	1	2025-06-12 16:00:10.544632	\N	0
5	90003	90001	2025-06-14 02:02:27.057111	\N	0
6	90004	90001	2025-06-14 02:02:27.057111	\N	0
7	90003	90002	2025-06-14 02:02:27.057111	\N	0
8	90004	90002	2025-06-14 02:02:27.057111	\N	0
9	90005	90002	2025-06-14 02:02:27.057111	\N	0
10	90006	90002	2025-06-14 02:02:27.057111	\N	0
11	90003	90003	2025-06-14 02:02:27.057111	\N	0
\.


--
-- TOC entry 5086 (class 0 OID 16493)
-- Dependencies: 230
-- Data for Name: lesson_completions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_completions (id, user_id, lesson_id, completed_at) FROM stdin;
\.


--
-- TOC entry 5084 (class 0 OID 16475)
-- Dependencies: 228
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lessons (id, module_id, title, content_type, content_url, duration, "order", created_at, updated_at) FROM stdin;
1	1	What is JavaScript?	video	https://example.com/videos/js-intro.mp4	5	1	2025-06-11 19:44:35.434166	2025-06-11 19:44:35.434166
2	1	Setting Up Your Environment	text	https://example.com/articles/setup	3	2	2025-06-11 19:44:35.434166	2025-06-11 19:44:35.434166
3	1	Intro to Testing	video	https://example.com/video.mp4	5	3	2025-06-12 16:00:50.390308	2025-06-12 16:00:50.390308
4	1	Lesson One: Introduction	video	https://example.com/intro.mp4	10	4	2025-06-12 17:34:06.804588	2025-06-12 17:34:06.804588
5	1	Lesson five: Introduction	video	https://example.com/intro.mp4	10	5	2025-06-12 17:35:12.30037	2025-06-12 17:35:12.30037
7	1	HTML Introduction	video	https://example.com/html-intro.mp4	60	8	2025-06-12 18:03:27.493298	2025-06-12 18:03:27.493298
8	1	CSS Fundamentals	video	https://example.com/css-fundamentals.mp4	60	9	2025-06-12 18:03:27.493298	2025-06-12 18:03:27.493298
9	2	Node.js Overview	video	https://example.com/nodejs-overview.mp4	60	8	2025-06-12 18:03:27.493298	2025-06-12 18:03:27.493298
10	2	Express Routing	video	https://example.com/express-routing.mp4	60	9	2025-06-12 18:03:27.493298	2025-06-12 18:03:27.493298
11	1	New Lesson on Flexbox	video	https://example.com/flexbox.mp4	50	6	2025-06-12 18:35:01.622794	2025-06-12 18:35:01.622794
3001	2001	Understanding Callbacks	video	https://example.com/callbacks.mp4	60	1	2025-06-12 18:49:56.855401	2025-06-12 18:49:56.855401
3003	2002	Factory Pattern Explained	video	https://example.com/factory.mp4	60	1	2025-06-12 18:49:56.855401	2025-06-12 18:49:56.855401
3004	2002	Observer Pattern in JS	video	https://example.com/observer.mp4	60	2	2025-06-12 18:49:56.855401	2025-06-12 18:49:56.855401
\.


--
-- TOC entry 5082 (class 0 OID 16458)
-- Dependencies: 226
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modules (id, course_id, title, description, "order", duration, created_at, updated_at) FROM stdin;
3	1	Functions and Scope	Understanding functions in JS	3	10	2025-06-11 19:44:18.875663	2025-06-11 19:44:18.875663
4	2	React Component Patterns	Advanced component techniques	1	15	2025-06-11 19:44:18.875663	2025-06-11 19:44:18.875663
1	1	Advanced JavaScript	Get started with JS basics	4	120	2025-06-11 19:44:18.875663	2025-06-12 05:05:53.316687
2	1	sasf	Learn about JS variables	6	120	2025-06-11 19:44:18.875663	2025-06-12 05:16:41.469333
16	1	Test Module	For lesson testing	1	10	2025-06-12 16:00:35.638002	2025-06-12 16:00:35.638002
18	1	Frontend Basics	Introduction to HTML, CSS, and JavaScript	8	300	2025-06-12 18:02:53.690378	2025-06-12 18:02:53.690378
19	1	Backend Basics	Introduction to Node.js, Express, and Databases	9	300	2025-06-12 18:02:53.690378	2025-06-12 18:02:53.690378
2001	1001	Asynchronous JavaScript	Master callbacks, promises, and async/await	1	240	2025-06-12 18:49:45.363356	2025-06-12 18:49:45.363356
2002	1001	JavaScript Design Patterns	Learn Module, Observer, Factory and more	2	240	2025-06-12 18:49:45.363356	2025-06-12 18:49:45.363356
\.


--
-- TOC entry 5090 (class 0 OID 16530)
-- Dependencies: 234
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, quiz_id, question, options, correct_answer, score, "order", created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5088 (class 0 OID 16513)
-- Dependencies: 232
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizzes (id, lesson_id, max_score, created_at, updated_at, title) FROM stdin;
\.


--
-- TOC entry 5094 (class 0 OID 16565)
-- Dependencies: 238
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submissions (id, assignment_id, user_id, submitted_at, grade, feedback, created_at, updated_at, submission_url, attachment_id) FROM stdin;
\.


--
-- TOC entry 5074 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password_hash, avatar, role, oauth_provider, oauth_id, created_at, updated_at, deleted_at, last_login, is_active) FROM stdin;
15	salam	salam22@gmail.com	$2b$12$3efARAWPGEVBsEq4COTe4.lyo62MIvPcHz5UfkeTZjehLJd4Gjn3W	https://ui-avatars.com/api/?name=salam&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-15 00:34:03.340746	2025-06-15 00:34:03.340746	\N	\N	t
2	leen	leen44@gmail.com	$2b$12$fjv9QQY/nnK7opiZANOpVO5uBjV3r4hRUU8c2pDk/n.LI4Wm5l.OO	\N	instructor	\N	\N	2025-06-11 19:23:47.619744	2025-06-11 19:23:47.619744	\N	2025-06-12 18:26:26.443257	t
19	GGG	user1G@user.com	$2b$12$iIfIDBs9vU0hvG8LQnnzGuqYCffQnIPMRu6JaUvH1/SXjDqtEQP1i	https://ui-avatars.com/api/?name=GGG&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-16 20:31:19.984751	2025-06-16 20:31:19.984751	\N	\N	t
90001	Alice Instructor	alice@lms.com	hashed_password1	\N	instructor	\N	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111	\N	\N	t
90002	Bob Instructor	bob@lms.com	hashed_password2	\N	instructor	\N	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111	\N	\N	t
90003	Charlie Student	charlie@lms.com	hashed_password3	\N	student	\N	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111	\N	\N	t
90004	Daisy Student	daisy@lms.com	hashed_password4	\N	student	\N	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111	\N	\N	t
6	Test Student	student@example.com	hashed_password	\N	student	\N	\N	2025-06-12 15:58:27.671461	2025-06-12 15:58:27.671461	\N	\N	t
25	GGG	GGG11@gmail.com	$2b$12$zd52h9TU9l/0REaTFUt4ZO5GGmZLQaJZMxKjGcUpnP6liX2a.Zx52	https://ui-avatars.com/api/?name=GGG&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-17 13:04:36.962372	2025-06-17 13:04:36.962372	\N	\N	t
90005	Eve Student	eve@lms.com	hashed_password5	\N	student	\N	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111	\N	\N	t
90006	Frank Student	frank@lms.com	hashed_password6	\N	student	\N	\N	2025-06-14 02:02:27.057111	2025-06-14 02:02:27.057111	\N	\N	t
22	Sara Salameh	sarasalameh192@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocKYPgLenJJTlnN86YB2bPQuVuVBcm5Jurf5tMzt-dSNfYBN_urZmg=s96-c	student	google	116843932510399391144	2025-06-17 11:58:56.746319	2025-06-17 11:58:56.746319	\N	2025-06-17 13:06:45.311526	t
4	Admin	admin11@gmail.com	$2b$12$Dsx2xH4M7NLgrjCEBueBgepMfwJufGeFiMaqOlL.dMT3jxjmK2XvK	\N	admin	\N	\N	2025-06-11 19:27:10.140303	2025-06-11 19:31:00.565394	\N	2025-06-20 21:15:08.972652	t
3	hussam	hussam22@gmail.com	$2b$12$2YKYjziRFYLPEhEqiYFMvObQ8FwhJQ65.Ks1nDmnOoeDcM9dmZsdK	\N	instructor	\N	\N	2025-06-11 19:26:10.8656	2025-06-11 20:20:34.162922	\N	2025-06-20 21:17:37.999306	t
26	sarasdasd	sarasdasD1@gmail.com	$2b$12$96r6wEXBWVOP4hvfXvMpleiRgmLDOjkbjTQe1SlPfvaJzHKu22lnO	https://ui-avatars.com/api/?name=sarasdasd&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-17 16:04:11.751048	2025-06-17 16:04:11.751048	\N	\N	t
14	avatar2	avatar2@gmail.com	$2b$12$nl/hKRrPo/QZum/w5fachetTrW23lSBT1IUQ1fIFssblNL9s25Raq	https://ui-avatars.com/api/?name=avatar2&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-14 03:08:12.957982	2025-06-14 03:08:12.957982	\N	\N	t
5	karla	karla11@gmail.com	$2b$12$XJIkHL9cM8GjVhsMurX1/ed95hPfmGWjNeWerlItPgdBeWQXB8aL.	\N	student	\N	\N	2025-06-12 01:54:31.750853	2025-06-12 01:54:31.750853	\N	2025-06-20 21:23:55.837608	t
7	instructor2	instructor2@gmail.com	$2b$12$RcKQnxOVrZBTTn4jVMjTX.uj24eqvOeeb54kKdSFdE6TYwTDB5mHm	\N	instructor	\N	\N	2025-06-12 17:52:56.336706	2025-06-12 17:52:56.336706	\N	2025-06-14 23:56:21.493202	t
23	daswW	daswW33@gmail.com	$2b$12$gurxtIZHiGLIopNcAkCHl.3EPebsWxQLnhyDoEfHV9ZC/lLETnZBS	https://ui-avatars.com/api/?name=daswW&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-17 12:17:51.992679	2025-06-17 12:17:51.992679	\N	\N	t
20	Osama	user1@useEEr.com	$2b$12$RI7w4mQ/YhJ74wd4AeVk4uSW32gXUqEb.24mxXJfnEryQfVK73NmG	https://ui-avatars.com/api/?name=Osama&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-17 11:36:44.284492	2025-06-17 11:36:44.284492	\N	2025-06-17 11:41:33.510994	t
24	feFo	feFo1@gmail.com	$2b$12$9lODQj7tqWRcrg5O0zK1C.LiDYB/Q3bcMkT2hkteYwwU4m912F1pq	https://ui-avatars.com/api/?name=feFo&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-17 12:23:22.809135	2025-06-17 12:23:22.809135	\N	\N	t
21	sawsan	sawsan11@gmail.com	$2b$12$YbgJaI7eSZ6HCU629o/nzeFiXeNSPHNcgjt8VNm522g8uyou76w8m	https://ui-avatars.com/api/?name=sawsan&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-17 11:52:49.257782	2025-06-17 11:52:49.257782	\N	\N	t
17	sdsad	user1@user.com	$2b$12$3s/4OFvCCql8Ds5PDmt/w.KSi7FNQUIrUDZAa34gqZI9iJHrTVXqS	https://ui-avatars.com/api/?name=sdsad&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-16 15:57:46.447441	2025-06-16 15:57:46.447441	\N	\N	t
18	hussam	hus@htu.com	$2b$12$kBFLTSwVx4qYFTFlbAee7umlh3YNH0WhxpqwdrmmP174A6Rr3f2ra	https://ui-avatars.com/api/?name=hussam&background=6c757d&color=fff&rounded=true&size=60	student	\N	\N	2025-06-16 15:58:36.581638	2025-06-16 15:58:36.581638	\N	\N	t
27	salem	salem22@gmail.com	$2b$12$dMH3EXNfQj4NbNOqEgwEke2bqUEgfGhA3WayYjZtKHNXZXzWIsywe	\N	student	\N	\N	2025-06-20 16:04:40.1087	2025-06-20 16:04:40.1087	\N	\N	t
\.


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 235
-- Name: assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assignments_id_seq', 1, false);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 241
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachments_id_seq', 1, false);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 219
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 239
-- Name: course_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_reviews_id_seq', 1, false);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 221
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 15, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 223
-- Name: enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollments_id_seq', 11, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 229
-- Name: lesson_completions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_completions_id_seq', 1, false);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 227
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lessons_id_seq', 11, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 225
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modules_id_seq', 19, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 233
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 1, false);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 231
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 1, false);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 237
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submissions_id_seq', 1, false);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 27, true);


--
-- TOC entry 4895 (class 2606 OID 16558)
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 4907 (class 2606 OID 16705)
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 16411)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4902 (class 2606 OID 16607)
-- Name: course_reviews course_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4904 (class 2606 OID 16609)
-- Name: course_reviews course_reviews_user_id_course_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_user_id_course_id_key UNIQUE (user_id, course_id);


--
-- TOC entry 4860 (class 2606 OID 16425)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 16444)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- TOC entry 4867 (class 2606 OID 16446)
-- Name: enrollments enrollments_user_id_course_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_user_id_course_id_key UNIQUE (user_id, course_id);


--
-- TOC entry 4884 (class 2606 OID 16499)
-- Name: lesson_completions lesson_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 16501)
-- Name: lesson_completions lesson_completions_user_id_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_user_id_lesson_id_key UNIQUE (user_id, lesson_id);


--
-- TOC entry 4879 (class 2606 OID 16486)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 16468)
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (id);


--
-- TOC entry 4893 (class 2606 OID 16541)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 16521)
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 16575)
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4874 (class 2606 OID 16644)
-- Name: modules unique_course_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT unique_course_order UNIQUE (course_id, "order");


--
-- TOC entry 4876 (class 2606 OID 16646)
-- Name: modules unique_course_title; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT unique_course_title UNIQUE (course_id, title);


--
-- TOC entry 4881 (class 2606 OID 16649)
-- Name: lessons unique_module_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT unique_module_order UNIQUE (module_id, "order");


--
-- TOC entry 4854 (class 2606 OID 16403)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4856 (class 2606 OID 16401)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 1259 OID 16592)
-- Name: idx_assignments_lesson; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assignments_lesson ON public.assignments USING btree (lesson_id);


--
-- TOC entry 4908 (class 1259 OID 16716)
-- Name: idx_attachments_lesson; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attachments_lesson ON public.attachments USING btree (lesson_id);


--
-- TOC entry 4909 (class 1259 OID 16717)
-- Name: idx_attachments_submission; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attachments_submission ON public.attachments USING btree (submission_id);


--
-- TOC entry 4905 (class 1259 OID 16636)
-- Name: idx_course_reviews_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_reviews_course ON public.course_reviews USING btree (course_id);


--
-- TOC entry 4861 (class 1259 OID 16586)
-- Name: idx_courses_instructor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_instructor ON public.courses USING btree (instructor_id);


--
-- TOC entry 4862 (class 1259 OID 16640)
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- TOC entry 4863 (class 1259 OID 16639)
-- Name: idx_courses_title_desc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_title_desc ON public.courses USING btree (title, description);


--
-- TOC entry 4868 (class 1259 OID 16588)
-- Name: idx_enrollments_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_course ON public.enrollments USING btree (course_id);


--
-- TOC entry 4869 (class 1259 OID 16587)
-- Name: idx_enrollments_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_user ON public.enrollments USING btree (user_id);


--
-- TOC entry 4882 (class 1259 OID 16647)
-- Name: idx_lesson_completions_user_lesson; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_completions_user_lesson ON public.lesson_completions USING btree (user_id, lesson_id);


--
-- TOC entry 4877 (class 1259 OID 16590)
-- Name: idx_lessons_module; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lessons_module ON public.lessons USING btree (module_id);


--
-- TOC entry 4870 (class 1259 OID 16589)
-- Name: idx_modules_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_modules_course ON public.modules USING btree (course_id);


--
-- TOC entry 4891 (class 1259 OID 16595)
-- Name: idx_questions_quiz; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_questions_quiz ON public.questions USING btree (quiz_id);


--
-- TOC entry 4887 (class 1259 OID 16591)
-- Name: idx_quizzes_lesson; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quizzes_lesson ON public.quizzes USING btree (lesson_id);


--
-- TOC entry 4888 (class 1259 OID 16528)
-- Name: idx_quizzes_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quizzes_title ON public.quizzes USING btree (title);


--
-- TOC entry 4897 (class 1259 OID 16593)
-- Name: idx_submissions_assignment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submissions_assignment ON public.submissions USING btree (assignment_id);


--
-- TOC entry 4898 (class 1259 OID 16594)
-- Name: idx_submissions_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submissions_user ON public.submissions USING btree (user_id);


--
-- TOC entry 4920 (class 2606 OID 16559)
-- Name: assignments assignments_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 4926 (class 2606 OID 16706)
-- Name: attachments attachments_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE SET NULL;


--
-- TOC entry 4927 (class 2606 OID 16711)
-- Name: attachments attachments_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.submissions(id) ON DELETE SET NULL;


--
-- TOC entry 4924 (class 2606 OID 16615)
-- Name: course_reviews course_reviews_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 4925 (class 2606 OID 16610)
-- Name: course_reviews course_reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4910 (class 2606 OID 16431)
-- Name: courses courses_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4911 (class 2606 OID 16426)
-- Name: courses courses_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.users(id);


--
-- TOC entry 4912 (class 2606 OID 16452)
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 4913 (class 2606 OID 16447)
-- Name: enrollments enrollments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4916 (class 2606 OID 16507)
-- Name: lesson_completions lesson_completions_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 4917 (class 2606 OID 16502)
-- Name: lesson_completions lesson_completions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4915 (class 2606 OID 16487)
-- Name: lessons lessons_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.modules(id);


--
-- TOC entry 4914 (class 2606 OID 16469)
-- Name: modules modules_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 4919 (class 2606 OID 16542)
-- Name: questions questions_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);


--
-- TOC entry 4918 (class 2606 OID 16522)
-- Name: quizzes quizzes_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 4921 (class 2606 OID 16576)
-- Name: submissions submissions_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignments(id);


--
-- TOC entry 4922 (class 2606 OID 16718)
-- Name: submissions submissions_attachment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_attachment_id_fkey FOREIGN KEY (attachment_id) REFERENCES public.attachments(id) ON DELETE SET NULL;


--
-- TOC entry 4923 (class 2606 OID 16581)
-- Name: submissions submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2025-06-21 11:02:15

--
-- PostgreSQL database dump complete
--

