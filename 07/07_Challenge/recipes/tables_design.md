# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
 As a social network user,
    So I can have my information registered,
    I'd like to have a user account with my email address.

    As a social network user,
    So I can have my information registered,
    I'd like to have a user account with my username.

    As a social network user,
    So I can write on my timeline,
    I'd like to create posts associated with my user account.

    As a social network user,
    So I can write on my timeline,
    I'd like each of my posts to have a title and a content.

    As a social network user,
    So I can know who reads my posts,
    I'd like each of my posts to have a number of views.
```

```
Nouns:

list of users, email, username, 
list of posts, title, content, views
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| Users                 | email, username
| Posts                 | title, content, views


1. Name of the first table (always plural): `Users`

    Column names: 'email' 'username'

2. Name of the second table (always plural): `Posts`

    Column names: title, content, views

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: Users
id: SERIAL 
email: text
username: text

Table: cohorts
id: SERIAL
title: text
content: text
views: int
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one user have many posts? (Yes/No) YES
2. Can one post have many users? (Yes/No) NO

You'll then be able to say that:

1. **[User] has many [Posts]**
2. And on the other side, **[Posts] belongs to [User]**
3. In that case, the foreign key is in the table [Posts]

Replace the relevant bits in this example with your own:


-> Therefore, the foreign key is on the Posts table.


*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
CREATE TABLE Users (
  id SERIAL PRIMARY KEY,
  email text,
  username text
);

-- Then the table with the foreign key first.
CREATE TABLE Posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  username_id int,
-- The foreign key name is always {other_table_singular}_id
  constraint fk_user foreign key(username_id)
    references Users(id)
    on delete cascade
);

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```