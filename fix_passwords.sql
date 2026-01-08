-- Fix password hashes for admin and students
UPDATE users SET password_hash = '$2a$10$8PLYGNNhlD4TNFJh/F2G9ezgbNvoxLuXdm7cuYtVudB5GOpC2ynKG' WHERE username = 'admin';
UPDATE users SET password_hash = '$2a$10$kbQ0a7x8tSfHLfo1haiIx.cySOfP8ezgA8YxQGK4zV46jDK2JDRvu' WHERE username IN ('john.doe', 'jane.smith', 'michael.j', 'emily.w');

SELECT username, role, is_active FROM users;
