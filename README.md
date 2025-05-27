# 📘 PostgreSQL Questions 

## ১. PostgreSQL কী?
PostgreSQL একটি শক্তিশালী, ওপেন সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি SQL (Structured Query Language) ব্যবহার করে ডেটা পরিচালনা করে | PostgreSQL ডেভেলপারদের জটিল ডেটা টাইপ, ট্রাঞ্জেকশন, সাবকোয়েরি, ভিউ এবং এক্সটেনশন ব্যবহারে সহায়তা করে।

### ২. PostgreSQL-এ ডাটাবেস স্কিমার উদ্দেশ্য কী?

**স্কিমা (Schema)** হলো একটি ডেটাবেসের ভিতরে আলাদা ফোল্ডার যা টেবিল, ভিউ, ফাংশন ইত্যাদিকে গুছিয়ে রাখে। এটি ডেটাবেসে বিভিন্ন অংশ তৈরি করে যাতে একাধিক ইউজার বা অ্যাপ্লিকেশন একই ডেটাবেসে কাজ করতে পারে কোনো সমস্যা ছাড়া।

🔸 যেমন:

```sql
CREATE SCHEMA factory;
CREATE TABLE school.workers (...);
CREATE TABLE school.managers (...);
```

এখানে `factory` স্কিমার অধীনে `workers` এবং `managers` টেবিল দুইটি আলাদাভাবে সংরক্ষিত।

---

## ৩. Primary Key এবং Foreign Key-এর ধারণা

### Primary Key:
একটি টেবিলে যেকোনো সারি কে ইউনিকভাবে চিহ্নিত করার জন্য ব্যবহৃত হয়। এটি কখনো null বা ডুপ্লিকেট হতে পারে না।

**উদাহরণ:**
```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT
);
```

### Foreign Key:
এটি অন্য একটি টেবিলের Primary Key-কে রেফার করে, যা দুটি টেবিলের মধ্যে সম্পর্ক তৈরি করে।

**উদাহরণ:**
```sql
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(id),
    course TEXT
);
```

## ৪. VARCHAR এবং CHAR-এর মধ্যে পার্থক্য

- `CHAR(n)`: নির্দিষ্ট দৈর্ঘ্যের স্ট্রিং সংরক্ষণ করে। ছোট স্ট্রিং হলে বাকিটা স্পেস দিয়ে পূরণ করে।
- `VARCHAR(n)`: সর্বোচ্চ দৈর্ঘ্য `n` পর্যন্ত হতে পারে, তবে সংরক্ষিত ডেটা যতটুকু দরকার ততটুকুই জায়গা নেয়।

**উদাহরণ:**
```sql
name CHAR(10)     -- 'rashedul  '
name VARCHAR(10)  -- 'rashedul'
```

### ৫. SELECT স্টেটমেন্টে WHERE ক্লজের উদ্দেশ্য কী?

`WHERE` ক্লজ ব্যবহার করে নির্দিষ্ট শর্ত অনুযায়ী ডেটা ফিল্টার করতে পারা যায়।

🔹 উদাহরণ:

```sql
SELECT * FROM employees WHERE department = 'HR';
```

এখানে শুধু HR ডিপার্টমেন্টের এমপ্লয়িদের রেকর্ড দেখানো হবে।

`WHERE` ছাড়া `SELECT` করলে সব রেকর্ড দেখায়, কিন্তু শর্তযুক্ত ফিল্টারিং এর জন্য `WHERE` ব্যবহার করতে হবে।

---

## ৬. LIMIT এবং OFFSET ক্লজ কী কাজে লাগে?
- `LIMIT`: কতটি রো ফেরত দেওয়া হবে তা নির্ধারণ করে।
- `OFFSET`: কতটি রো স্কিপ করা হবে তা নির্ধারণ করে।

**উদাহরণ:**
```sql
SELECT * FROM students LIMIT 10 OFFSET 5;
```
এটি ৬ থেকে শুরু করে ১০টি রেকর্ড দেখাবে।

## ৭. UPDATE স্টেটমেন্ট দিয়ে কিভাবে ডেটা পরিবর্তন করা যায়?
`UPDATE` কমান্ড দিয়ে টেবিলের বিদ্যমান ডেটা পরিবর্তন করা হয়।

**উদাহরণ:**
```sql
UPDATE students SET name = 'Rashedul' WHERE id = 1;
```
এটি `id = 1` এর নাম পরিবর্তন করে 'Rashedul' করবে।

## ৮. JOIN অপারেশনের গুরুত্ব এবং কাজ
`JOIN` ব্যবহৃত হয় একাধিক টেবিলের ডেটা যুক্ত করতে এবং তাদের মধ্যের সম্পর্ক অনুযায়ী এই টেবিলটি যুক্ত করা হয়।

**উদাহরণ:**
```sql
SELECT students.name, enrollments.course
FROM students
JOIN enrollments ON students.id = enrollments.student_id;
```
এখানে দুইটি টেবিল একসাথে মিলিয়ে ছাত্রের নাম এবং কোর্স দেখানো হয়েছে।

## ৯. GROUP BY ক্লজ ও এর Aggregation-এ ব্যবহার
`GROUP BY` ব্যবহার করে নির্দিষ্ট কলামের উপর ভিত্তি করে রেকর্ডগুলো গ্রুপ করা হয়। এটি সাধারণত aggregate ফাংশনের সঙ্গে ব্যাবহার করা হয়।

**উদাহরণ:**
```sql
SELECT course, COUNT(*)
FROM enrollments
GROUP BY course;
```
এটি প্রতিটি কোর্সে কতজন ছাত্র এনরোল করেছে তা দেখাবে।

## ১০. Aggregate ফাংশনগুলো (COUNT, SUM, AVG) কিভাবে কাজ করে?

- `COUNT()`: মোট রো সংখ্যা গণনা করে।
- `SUM()`: একটি কলামের সব ভ্যালু যোগ করে।
- `AVG()`: একটি কলামের গড় মান বের করে।

**উদাহরণ:**
```sql
SELECT COUNT(*) FROM workers;
SELECT SUM(marks) FROM salary;
SELECT AVG(marks) FROM salary;
```
এই কমান্ডগুলো মোট শ্রমিক, মোট বেতন, এবং গড় বেতন বের করে দেখাবে।
