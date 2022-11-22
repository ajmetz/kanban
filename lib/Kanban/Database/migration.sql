-- 1 up

-- Create Tables

PRAGMA foreign_keys = ON;

create table tickets (
    id integer primary key autoincrement,
    content text,
);

-- Initial Population of Tables with Default values:

INSERT INTO
    tickets 
        (content)
    VALUES 
        ('Dummy Content One'),
        ('Dummy Content Two'),
        ('Dummy Content Three');

-- 1 down

PRAGMA foreign_keys = OFF;

drop table if exists tickets;