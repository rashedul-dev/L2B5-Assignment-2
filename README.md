# 📘 PostgreSQL Questions 

## 1. PostgreSQL কী?
PostgreSQL একটি শক্তিশালী, ওপেন সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি SQL (Structured Query Language) ব্যবহার করে ডেটা পরিচালনা করে এবং ACID (Atomicity, Consistency, Isolation, Durability) বৈশিষ্ট্য সমর্থন করে। PostgreSQL ডেভেলপারদের জটিল ডেটা টাইপ, ট্রাঞ্জেকশন, সাবকোয়েরি, ভিউ এবং এক্সটেনশন ব্যবহারে সহায়তা করে।

## 2. PostgreSQL-এ ডেটাবেস স্কিমার উদ্দেশ্য কী?
স্কিমা হলো একটি নির্দিষ্ট ডেটাবেসের মধ্যে অবজেক্ট যেমন টেবিল, ভিউ, ফাংশন ইত্যাদি সংগঠিত রাখার একটি উপায়। এটি ডেটাবেসে বিভিন্ন ব্যবহারকারী বা অ্যাপ্লিকেশনকে আলাদা আলাদা স্পেসে কাজ করতে সাহায্য করে।

**উদাহরণ:**
```sql
CREATE SCHEMA accounting;
CREATE TABLE accounting.invoices (...);
```

## 3. Primary Key এবং Foreign Key-এর ধারণা

### Primary Key:
একটি টেবিলে যেকোনো সারিকে ইউনিকভাবে চিহ্নিত করার জন্য ব্যবহৃত হয়। এটি কখনো null বা ডুপ্লিকেট হতে পারে না।

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

## 4. VARCHAR এবং CHAR-এর মধ্যে পার্থক্য

- `CHAR(n)`: নির্দিষ্ট দৈর্ঘ্যের স্ট্রিং সংরক্ষণ করে। ছোট স্ট্রিং হলে বাকিটা স্পেস দিয়ে পূরণ করে।
- `VARCHAR(n)`: সর্বোচ্চ দৈর্ঘ্য `n` পর্যন্ত হতে পারে, তবে সংরক্ষিত ডেটা যতটুকু দরকার ততটুকুই জায়গা নেয়।

**উদাহরণ:**
```sql
name CHAR(10)     -- 'Alex      '
name VARCHAR(10)  -- 'Alex'
```

## 5. SELECT স্টেটমেন্টে WHERE ক্লজের উদ্দেশ্য
`WHERE` ক্লজ ব্যবহার করে টেবিল থেকে নির্দিষ্ট শর্ত অনুযায়ী ডেটা নির্বাচন করা হয়।

**উদাহরণ:**
```sql
SELECT * FROM students WHERE id = 1;
```
এটি শুধু সেই ছাত্রকে দেখাবে যার `id = 1`।

## 6. LIMIT এবং OFFSET ক্লজ কী কাজে লাগে?
- `LIMIT`: কতটি রো ফেরত দেওয়া হবে তা নির্ধারণ করে।
- `OFFSET`: কতটি রো স্কিপ করা হবে তা নির্ধারণ করে।

**উদাহরণ:**
```sql
SELECT * FROM students LIMIT 5 OFFSET 10;
```
এটি ১১ থেকে শুরু করে ৫টি রেকর্ড দেখাবে।

## 7. UPDATE স্টেটমেন্ট দিয়ে কিভাবে ডেটা পরিবর্তন করা যায়?
`UPDATE` কমান্ড দিয়ে টেবিলের বিদ্যমান ডেটা পরিবর্তন করা হয়।

**উদাহরণ:**
```sql
UPDATE students SET name = 'Rahim' WHERE id = 1;
```
এটি `id = 1` এর নাম পরিবর্তন করে 'Rahim' করবে।

## 8. JOIN অপারেশনের গুরুত্ব এবং কাজ
`JOIN` ব্যবহৃত হয় একাধিক টেবিলের ডেটা যুক্ত করতে, তাদের মধ্যে সম্পর্ক অনুযায়ী।

**উদাহরণ:**
```sql
SELECT students.name, enrollments.course
FROM students
JOIN enrollments ON students.id = enrollments.student_id;
```
এখানে দুইটি টেবিল একসাথে মিলিয়ে ছাত্রের নাম এবং কোর্স দেখানো হয়েছে।

## 9. GROUP BY ক্লজ ও এর Aggregation-এ ব্যবহার
`GROUP BY` ব্যবহার করে নির্দিষ্ট কলামের উপর ভিত্তি করে রেকর্ডগুলো গ্রুপ করা হয়। এটি সাধারণত aggregate ফাংশনের সঙ্গে ব্যবহৃত হয়।

**উদাহরণ:**
```sql
SELECT course, COUNT(*)
FROM enrollments
GROUP BY course;
```
এটি প্রতিটি কোর্সে কতজন ছাত্র এনরোল করেছে তা দেখাবে।

## 10. Aggregate ফাংশনগুলো (COUNT, SUM, AVG) কিভাবে কাজ করে?

- `COUNT()`: মোট রো সংখ্যা গণনা করে।
- `SUM()`: একটি কলামের সব ভ্যালু যোগ করে।
- `AVG()`: একটি কলামের গড় মান বের করে।

**উদাহরণ:**
```sql
SELECT COUNT(*) FROM students;
SELECT SUM(marks) FROM results;
SELECT AVG(marks) FROM results;
```
এই কমান্ডগুলো মোট ছাত্র, মোট নম্বর, এবং গড় নম্বর বের করবে।
