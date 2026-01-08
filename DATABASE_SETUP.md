# Student Enrollment Management System - Database Initialization Guide

## Prerequisites
- MySQL Server 8.0+ installed and running
- MySQL command-line client or MySQL Workbench
- Database credentials (default: root with no password)

## Step 1: Create Database

Open MySQL command-line or MySQL Workbench and run:

```sql
CREATE DATABASE IF NOT EXISTS student_enrollment 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE student_enrollment;
```

## Step 2: Create Tables

Execute the schema creation script:

```bash
mysql -u root -p student_enrollment < src/main/resources/schema.sql
```

Or in MySQL client:

```sql
SOURCE /path/to/studentenrollment/src/main/resources/schema.sql;
```

This will create the following tables:
- **students**: Student information
- **courses**: Course catalog
- **enrollments**: Student-course enrollments
- **users**: User authentication

## Step 3: Load Sample Data

Execute the sample data script:

```bash
mysql -u root -p student_enrollment < src/main/resources/sample_data.sql
```

Or in MySQL client:

```sql
SOURCE /path/to/studentenrollment/src/main/resources/sample_data.sql;
```

This will populate the database with:
- 10 sample students
- 10 sample courses
- Multiple enrollments
- 5 user accounts (1 admin, 4 students)

## Step 4: Verify Installation

Check that tables were created:

```sql
SHOW TABLES;
```

Check record counts:

```sql
SELECT 'Students' as Table_Name, COUNT(*) as Count FROM students
UNION ALL
SELECT 'Courses', COUNT(*) FROM courses
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'Users', COUNT(*) FROM users;
```

## Step 5: Update Database Configuration

Edit `src/main/resources/database.properties` with your database credentials:

```properties
db.url=jdbc:mysql://localhost:3306/student_enrollment?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=YOUR_PASSWORD_HERE
db.driver=com.mysql.cj.jdbc.Driver
```

## Default User Accounts

After loading sample data, you can login with:

### Admin Account
- Username: `admin`
- Password: `admin123`

### Student Accounts
- Username: `john.doe` / Password: `student123`
- Username: `jane.smith` / Password: `student123`
- Username: `michael.j` / Password: `student123`
- Username: `emily.w` / Password: `student123`

**IMPORTANT**: Change these passwords in production!

## Troubleshooting

### Connection Refused
- Ensure MySQL server is running
- Check port number (default: 3306)
- Verify firewall settings

### Access Denied
- Check username and password in database.properties
- Verify MySQL user has appropriate permissions:
  ```sql
  GRANT ALL PRIVILEGES ON student_enrollment.* TO 'root'@'localhost';
  FLUSH PRIVILEGES;
  ```

### Character Encoding Issues
- Ensure MySQL is configured for UTF-8:
  ```sql
  SHOW VARIABLES LIKE 'char%';
  ```

## Database Backup

To backup the database:

```bash
mysqldump -u root -p student_enrollment > backup.sql
```

To restore from backup:

```bash
mysql -u root -p student_enrollment < backup.sql
```

## Schema Diagram

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│  students   │         │ enrollments  │         │   courses   │
├─────────────┤         ├──────────────┤         ├─────────────┤
│*student_id  │◄───────┤*enrollment_id│────────►│*course_id   │
│ first_name  │         │ student_id   │         │ course_code │
│ last_name   │         │ course_id    │         │ course_name │
│ email       │         │ enroll_date  │         │ credits     │
│ dob         │         │ grade        │         │ department  │
│ enroll_date │         │ status       │         │ capacity    │
│ phone       │         └──────────────┘         │ semester    │
│ address     │                                  └─────────────┘
└─────────────┘
       △
       │
       │
┌─────────────┐
│    users    │
├─────────────┤
│*user_id     │
│ username    │
│ password_hash│
│ role        │
│ student_id  │ (nullable)
│ is_active   │
└─────────────┘
```

Legend: * = Primary Key, ◄► = Foreign Key Relationship
