# Car Rental Management System

A comprehensive car rental management system built with Spring Boot, JSP, and PostgreSQL.

## Features

### User Management & Authentication
- **Role-based Access Control**: Admin, Technical, and Customer roles
- **Spring Security Integration**: Form-based authentication with BCrypt password encoding
- **Session Management**: HTTP sessions with timeout configuration

### Dashboard Analytics (Admin/Technical Only)
- **Total Earnings**: Sum of all booking earnings (all time)
- **Monthly Earnings**: Current month's booking earnings
- **Net Monthly Profit**: Monthly earnings minus monthly expenses
- **Earnings by Car**: Bar chart showing total earnings per car
- **Monthly Car Performance**: Current month earnings by car
- **Recent Bookings**: Last 5 bookings with status
- **System Overview**: Total cars, customers, bookings, and utilization rate

### Car Management
- **CRUD Operations**: Create, read, update, delete cars
- **Search & Filters**: By name, company, fuel type, gear type, availability
- **Pagination**: Configurable page sizes (10, 25, 50)
- **Sorting**: By any column (ascending/descending)
- **Availability Management**: Toggle car availability for bookings
- **Validation**: Required fields, unique listing ID, date validation

### Booking Management
- **CRUD Operations**: Create, read, update, delete bookings
- **Date Range Validation**: End date must be after start date
- **Car Availability Checking**: Prevents overlapping bookings
- **Status Management**: Pending → Confirmed → Completed/Cancelled
- **Search & Filters**: By car, customer, booking ID, date range
- **Earnings Tracking**: Automatic calculation of total earnings

### Customer Management (Admin Only)
- **Customer List**: View all customers with search functionality
- **Customer Details**: View customer profile with booking history
- **Account Management**: Activate/deactivate customer accounts
- **Export Options**: CSV download capability

### Expense Management
- **CRUD Operations**: Create, read, update, delete expenses
- **Category Management**: Predefined and custom categories
- **Date Filtering**: Filter by date range or month/year
- **Search**: By name, description, category
- **Reporting**: Expense summary by category

## Technology Stack

- **Backend**: Spring Boot 3.5.4, Maven
- **Frontend**: JSP with JSTL, Bootstrap 5.3.2
- **Database**: PostgreSQL 15+
- **ORM**: Spring Data JPA with Hibernate
- **Security**: Spring Security with BCrypt
- **Styling**: Bootstrap 5.3+ with Font Awesome icons
- **Architecture**: Layered MVC (Controller → Service → Repository → Entity)

## Database Schema

### Users Table
- id, name, contact, email, userType, password, createdDate, isActive

### Cars Table
- id, name, company, color, dateOfPurchase, fuelType, gearType, listingId, description, isAvailable, createdDate

### Bookings Table
- bookingId, carId, customerId, startDate, endDate, earningAmount, totalEarning, amountCreditedDate, bookingStatus, createdDate

### Expenses Table
- id, name, description, expenseDate, amount, category, createdDate

## Setup Instructions

### Prerequisites
- Java 17+
- PostgreSQL 15+
- Maven 3.6+

### Database Setup
1. Create a PostgreSQL database named `rental_db`
2. Update database credentials in `application.properties`
3. The application will automatically create tables and insert sample data

### Running the Application
```bash
# Clone the repository
git clone <repository-url>
cd rental

# Run the application
mvn spring-boot:run
```

The application will be available at `http://localhost:8080`

### Default Login Credentials

**Admin User:**
- Email: admin@rental.com
- Password: password123

**Technical User:**
- Email: tech@rental.com
- Password: password123

**Customer User:**
- Email: john.smith@email.com
- Password: password123

## Configuration

### Application Properties
```properties
# Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/rental_db
spring.datasource.username=postgres
spring.datasource.password=password

# JPA Configuration
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true

# JSP Configuration
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp

# Session Configuration
server.servlet.session.timeout=30m
```

## Sample Data

The application includes sample data:
- 3 users (1 admin, 1 technical, 3 customers)
- 10 cars with varied specifications
- 15 bookings across different date ranges
- 16 expense records for current and previous months

## API Endpoints

### Authentication
- `GET /login` - Login page
- `POST /login` - Process login
- `POST /logout` - Logout

### Dashboard
- `GET /dashboard` - Main dashboard

### Cars
- `GET /cars` - List cars with pagination and search
- `GET /cars/new` - New car form
- `POST /cars` - Create car
- `GET /cars/{id}/edit` - Edit car form
- `POST /cars/{id}` - Update car
- `POST /cars/{id}/delete` - Delete car

### Bookings
- `GET /bookings` - List bookings with pagination and search
- `GET /bookings/new` - New booking form
- `POST /bookings` - Create booking
- `GET /bookings/{id}/edit` - Edit booking form
- `POST /bookings/{id}` - Update booking
- `POST /bookings/{id}/status` - Update booking status

### Customers (Admin Only)
- `GET /customers` - List customers
- `GET /customers/{id}` - Customer details
- `POST /customers/{id}/activate` - Activate customer
- `POST /customers/{id}/deactivate` - Deactivate customer

### Expenses
- `GET /expenses` - List expenses with pagination and search
- `GET /expenses/new` - New expense form
- `POST /expenses` - Create expense
- `GET /expenses/{id}/edit` - Edit expense form
- `POST /expenses/{id}` - Update expense

## Security Features

- **CSRF Protection**: Disabled for demo purposes
- **Password Encoding**: BCrypt with strength 10
- **Session Security**: HTTP-only cookies, secure flags
- **Role-based Authorization**: Method-level security
- **Input Validation**: Server-side validation with Bean Validation

## Validation Rules

- **Email**: Format validation and uniqueness
- **Phone**: Format validation
- **Date Range**: End date must be after start date
- **Positive Amounts**: For bookings and expenses
- **Car Availability**: Checking before booking
- **Password Strength**: Minimum 8 characters

## Error Handling

- **Global Exception Handler**: Centralized error handling
- **User-friendly Messages**: Clear error messages
- **Proper HTTP Status Codes**: RESTful error responses
- **Logging**: SLF4J with configurable levels

## Future Enhancements

- **Email Notifications**: Booking confirmations and reminders
- **Payment Integration**: Online payment processing
- **Mobile App**: React Native or Flutter app
- **Advanced Reporting**: PDF reports and charts
- **Multi-tenancy**: Support for multiple rental companies
- **Real-time Updates**: WebSocket integration
- **File Upload**: Car images and documents
- **Calendar Integration**: Google Calendar sync

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
