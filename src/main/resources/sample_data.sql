-- =====================================================
-- Student Enrollment Management System - Updated Sample Data
-- with Approval Workflow Support
-- =====================================================

-- Insert sample students
INSERT INTO students (first_name, last_name, email, dob, enrollment_date, phone, address) VALUES
('Resh', 'Tva', 'resh@gmail.com', '2002-05-15', '2024-09-01', '012-3456789', '123 Main St, Kuala Lumpur'),
('John', 'Doe', 'john.doe@student.edu', '2002-05-15', '2024-09-01', '012-3456789', '123 Main St, Kuala Lumpur'),
('Jane', 'Smith', 'jane.smith@student.edu', '2003-08-22', '2024-09-01', '012-9876543', '456 Park Ave, Petaling Jaya'),
('Michael', 'Johnson', 'michael.j@student.edu', '2002-11-30', '2024-09-01', '013-2345678', '789 Oak Rd, Shah Alam'),
('Emily', 'Williams', 'emily.w@student.edu', '2003-03-18', '2024-09-01', '014-8765432', '321 Pine St, Subang Jaya');

-- Insert sample courses with instructor and schedule
INSERT INTO courses (course_code, course_name, credits, department, capacity, semester, description, instructor, schedule) VALUES
('BCS2213', 'Object-Oriented Programming', 3, 'Computer Science', 35, 'Semester 1', 'Learn Java programming and OOP concepts', 'Dr. Ahmad Rahman', 'Mon/Wed 9:00 AM - 11:00 AM'),
('BCS1103', 'Introduction to Programming', 3, 'Computer Science', 40, 'Semester 1', 'Fundamentals of programming using Python', 'Prof. Sarah Lee', 'Tue/Thu 10:00 AM - 12:00 PM'),
('BCS2323', 'Data Structures and Algorithms', 4, 'Computer Science', 30, 'Semester 2', 'Advanced data structures and algorithm design', 'Dr. Michael Chen', 'Mon/Wed 2:00 PM - 4:00 PM'),
('BCS3413', 'Database Management Systems', 3, 'Computer Science', 35, 'Semester 2', 'Database design, SQL, and DBMS concepts', 'Prof. David Kumar', 'Tue/Thu 1:00 PM - 3:00 PM'),
('BCS3523', 'Web Development', 3, 'Computer Science', 30, 'Semester 2', 'Full-stack web development with modern frameworks', 'Dr. Lisa Wong', 'Mon/Fri 3:00 PM - 5:00 PM'),
('BMT2113', 'Calculus I', 3, 'Mathematics', 40, 'Semester 1', 'Differential and integral calculus', 'Prof. James Tan', 'Wed/Fri 10:00 AM - 12:00 PM'),
('BPH1113', 'Physics I', 3, 'Physics', 35, 'Semester 1', 'Mechanics and thermodynamics', 'Dr. Robert Singh', 'Tue/Thu 2:00 PM - 4:00 PM'),
('BEN1113', 'English Communication', 2, 'English', 50, 'Semester 1', 'Academic writing and presentation skills', 'Ms. Jennifer Park', 'Mon/Wed 11:00 AM - 1:00 PM');

-- Insert sample enrollments with new statuses (PENDING, APPROVED, REJECTED)
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status, rejection_reason) VALUES
-- Resh's enrollments (mix of statuses for testing)
(1, 1, '2024-09-05', NULL, 'APPROVED', NULL),
(1, 3, '2024-09-05', NULL, 'PENDING', NULL),
(1, 6, '2024-09-05', NULL, 'REJECTED', 'Course is full'),
-- John Doe's enrollments
(2, 1, '2024-09-05', 'A', 'APPROVED', NULL),
(2, 3, '2024-09-05', NULL, 'APPROVED', NULL),
(2, 6, '2024-09-05', 'B+', 'COMPLETED', NULL),
-- Jane Smith's enrollments  
(3, 1, '2024-09-06', NULL, 'APPROVED', NULL),
(3, 2, '2024-09-06', 'A', 'COMPLETED', NULL),
(3, 8, '2024-09-06', NULL, 'PENDING', NULL),
-- Michael Johnson's enrollments
(4, 1, '2024-09-07', NULL, 'APPROVED', NULL),
(4, 4, '2024-09-07', NULL, 'PENDING', NULL),
(4, 7, '2024-09-07', NULL, 'REJECTED', 'Prerequisites not met'),
-- Emily Williams's enrollments
(5, 2, '2024-09-08', NULL, 'APPROVED', NULL),
(5, 5, '2024-09-08', NULL, 'PENDING', NULL);

-- Insert users with properly hashed passwords
-- Password hashing: BCrypt with strength 10
-- Admin: username='admin', password='admin123' 
-- Resh: email='resh@gmail.com', password='resh123'
-- Other students: password='student123'

INSERT INTO users (username, password_hash, role, student_id, is_active) VALUES
-- Admin account (password: admin123)
('admin', '$2a$10$fZiB6Mzt7CLjzpSI.U5MIOEJJBbl.DVoCCs1wMNqGQjrc6hAISHT2', 'ADMIN', NULL, TRUE),
-- Resh's student account (email login, password: resh123)
('resh@gmail.com', '$2a$10$fJJSKTsqrcjuDpWv6cgSTeg2HcOYCVcaW.scFTAgAw0GFicx6/MMu', 'STUDENT', 1, TRUE),
-- Other student accounts (password: student123)
('john.doe@student.edu', '$2a$10$TuqeWx14XWe0DZ/fXxIu3OTbHL36QuLqNdsOOxDM.AXgXdrIxithy', 'STUDENT', 2, TRUE),
('jane.smith@student.edu', '$2a$10$TuqeWx14XWe0DZ/fXxIu3OTbHL36QuLqNdsOOxDM.AXgXdrIxithy', 'STUDENT', 3, TRUE),
('michael.j@student.edu', '$2a$10$TuqeWx14XWe0DZ/fXxIu3OTbHL36QuLqNdsOOxDM.AXgXdrIxithy', 'STUDENT', 4, TRUE),
('emily.w@student.edu', '$2a$10$TuqeWx14XWe0DZ/fXxIu3OTbHL36QuLqNdsOOxDM.AXgXdrIxithy', 'STUDENT', 5, TRUE);

-- Insert sample academic calendar events
INSERT INTO academic_calendar (semester, activity_name, start_date, end_date, description) VALUES
('Semester 1 2024/2025', 'Course Registration', '2024-08-15', '2024-08-30', 'Registration period for Semester 1'),
('Semester 1 2024/2025', 'Classes Begin', '2024-09-01', '2024-09-01', 'First day of classes'),
('Semester 1 2024/2025', 'Mid-term Break', '2024-10-15', '2024-10-22', 'One week break'),
('Semester 1 2024/2025', 'Final Exams', '2024-12-01', '2024-12-15', 'Final examination period'),
('Semester 1 2024/2025', 'Semester Break', '2024-12-16', '2025-01-15', 'End of semester break');

-- Insert sample system activities  
INSERT INTO system_activity (user_id, user_type, action_type, description) VALUES
(1, 'ADMIN', 'LOGIN', 'Admin logged into the system'),
(1, 'ADMIN', 'COURSE_CREATE', 'Created new course: Object-Oriented Programming'),
(2, 'STUDENT', 'LOGIN', 'Student resh@gmail.com logged in'),
(2, 'STUDENT', 'ENROLLMENT_REQUEST', 'Requested enrollment in BCS2213'),
(1, 'ADMIN', 'ENROLLMENT_APPROVE', 'Approved enrollment for student ID 1 in course BCS2213');

-- Display summary
SELECT 'Database populated successfully!' as Message;
SELECT COUNT(*) as Total_Students FROM students;
SELECT COUNT(*) as Total_Courses FROM courses;
SELECT COUNT(*) as Total_Enrollments FROM enrollments;
SELECT COUNT(*) as Total_Users FROM users;
SELECT COUNT(*) as Calendar_Events FROM academic_calendar;
SELECT COUNT(*) as System_Activities FROM system_activity;
