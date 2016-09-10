CREATE TABLE subjects (
  id serial PRIMARY KEY,
  name text NOT NULL UNIQUE,
  duration integer
);

CREATE TABLE activities (
  id serial PRIMARY KEY,
  name text NOT NULL,
  start_time timestamp without time zone NOT NULL DEFAULT now(),
  end_time timestamp without time zone,
  subject_id integer NOT NULL REFERENCES subjects (id)
);