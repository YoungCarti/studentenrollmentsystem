# Student Enrollment Management System - Backend Implementation

## Overview

This project implements a complete three-tier backend architecture for a Student Enrollment Management System following Java EE best practices.

## Architecture

### 1. Data Access Layer (DAO)
**Location**: `src/main/java/com/sems/dao/`

- **StudentDAO**: Student CRUD operations
- **CourseDAO**: Course management with capacity tracking  
- **EnrollmentDAO**: Enrollment operations with JOIN queries
- **UserDAO**: User authentication and management

**Features**:
- HikariCP connection pooling for performance
- Prepared statements for SQL injection prevention
- Comprehensive error handling

### 2. Business Logic Layer (Service)
**Location**: `src/main/java/com/sems/service/`

- **StudentService**: Student registration and validation
- **CourseService**: Course creation with capacity management
- **EnrollmentService**: Enrollment with business rules
  - Capacity checking
  - Conflict detection
  - Grade management
- **AuthenticationService**: Security and authentication
  - BCrypt password hashing
  - Role-based authorization
  - Session management

### 3. Controller Layer (Servlets)
**Location**: `src/main/java/com/sems/controller/`

- **LoginServlet**: User authentication
- **LogoutServlet**: Session termination
- **RegisterServlet**: Student self-registration
- **AdminDashboardServlet**: Admin statistics
- **StudentDashboardServlet**: Student profile and courses
- **EnrollCourseServlet**: Course enrollment/drop

### 4. Security
**Location**: `src/main/java/com/sems/filter/`

- **AuthenticationFilter**: Protects secured pages
- **RoleAuthorizationFilter**: Enforces role-based access

## Database Schema

The system uses 4 main tables:

1. **students**: Student information
2. **courses**: Course catalog with capacity
3. **enrollments**: Student-course relationships
4. **users**: Authentication data

See `DATABASE_SETUP.md` for detailed setup instructions.

## Configuration

### Database Configuration
Edit `src/main/resources/database.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/student_enrollment
db.username=root
db.password=YOUR_PASSWORD
```

### Dependencies (pom.xml)
- Jakarta EE 9.1
- MySQL Connector 8.0.33
- BCrypt 0.4
- HikariCP 5.0.1
- JSTL 2.0.0

## Build and Deploy

### Build with Maven
```bash
mvn clean package
```

This creates `target/studentenrollment.war`

### Deploy to GlassFish
1. Start GlassFish server
2. Deploy WAR file through Admin Console or:
```bash
asadmin deploy target/studentenrollment.war
```

### Access Application
```
http://localhost:8080/studentenrollment/
```

## Default Credentials

**Admin**:
- Username: `admin`
- Password: `admin123`

**Students**:
- Username: `john.doe`
- Password: `student123`

## Key Features Implemented

✅ **Security**
- BCrypt password hashing
- SQL injection prevention (prepared statements)
- XSS protection (input sanitization)
- Session management with timeouts
- Role-based access control

✅ **Business Logic**
- Enrollment capacity validation
- Duplicate enrollment prevention  
- Grade management
- Student age validation
- Email format validation

✅ **Database**
- Connection pooling (HikariCP)
- Proper foreign key relationships
- Indexed columns for performance
- Transaction support

✅ **Error Handling**
- Custom exception hierarchy
- Comprehensive logging
- User-friendly error messages
- Error page configuration

## Project Structure

```
src/main/
├── java/com/sems/
│   ├── controller/       # Servlets
│   │   ├── admin/        # Admin servlets
│   │   └── student/      # Student servlets
│   ├── dao/              # Data Access Objects
│   ├── exception/        # Custom exceptions
│   ├── filter/           # Security filters
│   ├── model/            # Entity classes
│   ├── service/          # Business logic
│   └── util/             # Utilities
├── resources/
│   ├── schema.sql        # Database schema
│   ├── sample_data.sql   # Test data
│   └── database.properties
└── webapp/
    ├── admin/            # Admin JSP pages
    ├── auth/             # Login/Register pages
    ├── student/          # Student JSP pages
    ├── css/              # Stylesheets
    └── WEB-INF/
        └── web.xml       # Deployment descriptor
```

## Testing

### Database Connection Test
The `DatabaseConnection` class includes a `testConnection()` method.

### Manual Testing
1. Register a new student
2. Login with student credentials
3. Browse and enroll in courses
4. Login as admin
5. View dashboard statistics
6. Manage students and courses

## Troubleshooting

**ClassNotFound: mysql.jdbc.Driver**
- Ensure MySQL connector is in pom.xml
- Rebuild with `mvn clean package`

**Authentication Filter blocking everything**
- Check PUBLIC_URLS list in filter
- Verify session is being created

**Database connection errors**
- Verify MySQL is running
- Check credentials in database.properties
- Ensure database exists

## Code Quality

- ✅ Java naming conventions
- ✅ Comprehensive Javadoc comments
- ✅ Exception handling throughout
- ✅ Logging implementation
- ✅ Proper resource management (try-with-resources)

## Future Enhancements

- Unit tests for DAOs and Services
- RESTful API layer
- Advanced reporting features
- Email notifications
- Password reset functionality

## Authors

SEMS Team
Student Enrollment Management System  
Version 1.0
