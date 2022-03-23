CREATE DATABASE profile;
CREATE DATABASE auth;

\connect profile;

-- Table: public.school

-- DROP TABLE public.school;

CREATE TABLE IF NOT EXISTS public.school
(
    id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    domains text[] COLLATE pg_catalog."default",
    CONSTRAINT school_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.school
    OWNER to postgres;

-- Table: public.student

-- DROP TABLE public.student;

CREATE TABLE IF NOT EXISTS public.student
(
    id character varying(64) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(64) COLLATE pg_catalog."default",
    last_name character varying(64) COLLATE pg_catalog."default",
    email character varying(64) COLLATE pg_catalog."default",
    current_classes text[] COLLATE pg_catalog."default",
    classes_taken text[] COLLATE pg_catalog."default",
    general_info character varying(1024) COLLATE pg_catalog."default",
    school character varying(64) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT student_pkey PRIMARY KEY (id),
    CONSTRAINT school_pkey FOREIGN KEY (school)
        REFERENCES public.school (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.student
    OWNER to postgres;

INSERT INTO public.student (id, first_name, last_name, email, general_info, created_at, updated_at)
VALUES ('234', 'Also Zubair', 'Nurie', 'mzznurie@msn.com', 'ballerr', now(), now());
INSERT INTO public.student (id, first_name, last_name, email, general_info, created_at, updated_at)
VALUES ('123', 'Zubair', 'Nurie', 'mznurie@msn.com', 'baller', now(), now());

-- Table: public.tag

-- DROP TABLE public.tag;

CREATE TABLE IF NOT EXISTS public.tag
(
    name text COLLATE pg_catalog."default" NOT NULL,
    positive boolean,
    CONSTRAINT tag_pkey PRIMARY KEY (name)
)

TABLESPACE pg_default;

ALTER TABLE public.tag
    OWNER to postgres;

INSERT INTO tag (name, positive) VALUES ('hardworking', true);
INSERT INTO tag (name, positive) VALUES ('diligent', true);
INSERT INTO tag (name, positive) VALUES ('creative', true);
INSERT INTO tag (name, positive) VALUES ('punctual', true);
INSERT INTO tag (name, positive) VALUES ('organized', true);
INSERT INTO tag (name, positive) VALUES ('problem solver', true);
INSERT INTO tag (name, positive) VALUES ('team player', true);
INSERT INTO tag (name, positive) VALUES ('helpful', true);
INSERT INTO tag (name, positive) VALUES ('slacker', false);
INSERT INTO tag (name, positive) VALUES ('leader', true);
INSERT INTO tag (name, positive) VALUES ('friendly', true);

CREATE TABLE review (
    id text PRIMARY KEY,
    reviewed text,
    reviewer text,
    created_at timestamp,
    FOREIGN KEY(reviewed)
        REFERENCES student(id),
    FOREIGN KEY(reviewer)
        REFERENCES student(id)
);

CREATE TABLE review_tag (
    review_id text,
    tag_name text,
    PRIMARY KEY (review_id, tag_name),
    FOREIGN KEY (review_id)
        REFERENCES review(id),
    FOREIGN KEY (tag_name)
        REFERENCES tag(name)
);

CREATE TABLE public.confirmation (
    token text PRIMARY KEY NOT NULL,
    st_id text not null REFERENCES student(id),
    sc_id text not null REFERENCES school(id),
    created_at timestamp
);

