PGDMP     7    -    
            }            proyekdb    9.6.24    9.6.24 /               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16720    proyekdb    DATABASE     �   CREATE DATABASE proyekdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Indonesia.1252' LC_CTYPE = 'English_Indonesia.1252';
    DROP DATABASE proyekdb;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �           1247    16722 
   taskstatus    TYPE     U   CREATE TYPE public.taskstatus AS ENUM (
    'TODO',
    'IN_PROGRESS',
    'DONE'
);
    DROP TYPE public.taskstatus;
       public       postgres    false    3            �            1259    16744    blacklisted_tokens    TABLE     �   CREATE TABLE public.blacklisted_tokens (
    id integer NOT NULL,
    token character varying,
    blacklisted_on timestamp without time zone
);
 &   DROP TABLE public.blacklisted_tokens;
       public         postgres    false    3            �            1259    16742    blacklisted_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.blacklisted_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.blacklisted_tokens_id_seq;
       public       postgres    false    188    3            �           0    0    blacklisted_tokens_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.blacklisted_tokens_id_seq OWNED BY public.blacklisted_tokens.id;
            public       postgres    false    187            �            1259    16757    projects    TABLE     �   CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);
    DROP TABLE public.projects;
       public         postgres    false    3            �            1259    16755    projects_id_seq    SEQUENCE     x   CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.projects_id_seq;
       public       postgres    false    3    190            �           0    0    projects_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;
            public       postgres    false    189            �            1259    16775    tasks    TABLE     .  CREATE TABLE public.tasks (
    id integer NOT NULL,
    name character varying,
    description character varying,
    status public.taskstatus,
    deadline timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    project_id integer
);
    DROP TABLE public.tasks;
       public         postgres    false    485    3            �            1259    16773    tasks_id_seq    SEQUENCE     u   CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tasks_id_seq;
       public       postgres    false    192    3            �           0    0    tasks_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;
            public       postgres    false    191            �            1259    16731    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    hashed_password character varying,
    is_active boolean
);
    DROP TABLE public.users;
       public         postgres    false    3            �            1259    16729    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       postgres    false    3    186            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
            public       postgres    false    185            �           2604    16747    blacklisted_tokens id    DEFAULT     ~   ALTER TABLE ONLY public.blacklisted_tokens ALTER COLUMN id SET DEFAULT nextval('public.blacklisted_tokens_id_seq'::regclass);
 D   ALTER TABLE public.blacklisted_tokens ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    188    187    188            �           2604    16760    projects id    DEFAULT     j   ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);
 :   ALTER TABLE public.projects ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    190    189    190            �           2604    16778    tasks id    DEFAULT     d   ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);
 7   ALTER TABLE public.tasks ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    192    191    192            �           2604    16734    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    186    185    186            x          0    16744    blacklisted_tokens 
   TABLE DATA                     public       postgres    false    188   /       �           0    0    blacklisted_tokens_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.blacklisted_tokens_id_seq', 1, false);
            public       postgres    false    187            z          0    16757    projects 
   TABLE DATA                     public       postgres    false    190   "/       �           0    0    projects_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.projects_id_seq', 1, false);
            public       postgres    false    189            |          0    16775    tasks 
   TABLE DATA                     public       postgres    false    192   </       �           0    0    tasks_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);
            public       postgres    false    191            v          0    16731    users 
   TABLE DATA                     public       postgres    false    186   V/       �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
            public       postgres    false    185            �           2606    16752 *   blacklisted_tokens blacklisted_tokens_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.blacklisted_tokens
    ADD CONSTRAINT blacklisted_tokens_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.blacklisted_tokens DROP CONSTRAINT blacklisted_tokens_pkey;
       public         postgres    false    188    188            �           2606    16765    projects projects_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public         postgres    false    190    190            �           2606    16783    tasks tasks_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_pkey;
       public         postgres    false    192    192            �           2606    16739    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         postgres    false    186    186            �           1259    16753    ix_blacklisted_tokens_id    INDEX     U   CREATE INDEX ix_blacklisted_tokens_id ON public.blacklisted_tokens USING btree (id);
 ,   DROP INDEX public.ix_blacklisted_tokens_id;
       public         postgres    false    188            �           1259    16754    ix_blacklisted_tokens_token    INDEX     b   CREATE UNIQUE INDEX ix_blacklisted_tokens_token ON public.blacklisted_tokens USING btree (token);
 /   DROP INDEX public.ix_blacklisted_tokens_token;
       public         postgres    false    188            �           1259    16771    ix_projects_id    INDEX     A   CREATE INDEX ix_projects_id ON public.projects USING btree (id);
 "   DROP INDEX public.ix_projects_id;
       public         postgres    false    190            �           1259    16772    ix_projects_name    INDEX     E   CREATE INDEX ix_projects_name ON public.projects USING btree (name);
 $   DROP INDEX public.ix_projects_name;
       public         postgres    false    190            �           1259    16789    ix_tasks_id    INDEX     ;   CREATE INDEX ix_tasks_id ON public.tasks USING btree (id);
    DROP INDEX public.ix_tasks_id;
       public         postgres    false    192            �           1259    16790    ix_tasks_name    INDEX     ?   CREATE INDEX ix_tasks_name ON public.tasks USING btree (name);
 !   DROP INDEX public.ix_tasks_name;
       public         postgres    false    192            �           1259    16741    ix_users_id    INDEX     ;   CREATE INDEX ix_users_id ON public.users USING btree (id);
    DROP INDEX public.ix_users_id;
       public         postgres    false    186            �           1259    16740    ix_users_username    INDEX     N   CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);
 %   DROP INDEX public.ix_users_username;
       public         postgres    false    186            �           2606    16766    projects projects_user_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_user_id_fkey;
       public       postgres    false    190    2033    186            �           2606    16784    tasks tasks_project_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);
 E   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_project_id_fkey;
       public       postgres    false    2041    192    190            x   
   x���          z   
   x���          |   
   x���          v   {   x���v
Q���W((M��L�+-N-*Vs�	uV�0�QPOL���S2T��T�T¼ݒ�J�ҽ���*+���+�S�S�����̓���#
�B���݊ݍ����K�JS5���� k�#�     