# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

list of students, name, cohort_name, cohort_start_date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| students              | name, cohort_id
| cohort                | cohort_name, start_date

1. Name of the first table (always plural): `students`

    Column names: 'name' 'cohort_id'

2. Name of the second table (always plural): `cohorts`

    Column names: cohort_name, cohort_start_date

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
name: text
cohort_id: int

Table: cohorts
id: SERIAL
cohort_name: text
start_date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one students have many cohorts? (Yes/No) No
2. Can one cohorts have many students? (Yes/No) Yes

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:


-> Therefore, the foreign key is on the students table.


*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  cohort_name text,
  start_date date
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL,
  name text,
  cohort_id int,
-- The foreign key name is always {other_table_singular}_id
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```