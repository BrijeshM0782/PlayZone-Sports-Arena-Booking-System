
# 🏟️ PlayZone – Smart Arena Booking System

PlayZone is a web-based sports arena booking application developed using **Java J2EE technologies**. It allows users to explore sports arenas, check available booking options, reserve time slots, and manage their bookings.

The system also provides an administrator dashboard to manage sports arenas and monitor platform statistics.

---

## 🚀 Features

### 👤 User Module
- User registration and login.
- Secure password hashing.
- Session-based authentication.
- Browse available sports arenas.
- Book sports arenas for selected time slots.
- View personal booking history.
- Cancel confirmed bookings.
- Logout functionality.

### 🛠️ Admin Module
- Admin login with role-based access.
- Admin dashboard with platform statistics.
- View total registered users.
- View active arenas and total bookings.
- Add new sports arenas.
- Edit existing arena details.
- Deactivate and reactivate arenas.

### 📅 Booking Management
- Select an arena and booking date.
- Choose an available time slot.
- Automatically calculate booking price.
- Prevent duplicate confirmed bookings for the same arena and time slot.
- Cancel existing bookings.

---

## 🧰 Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend programming |
| JSP | Dynamic web pages |
| Servlets | Request processing |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML | Web page structure |
| CSS | User interface styling |
| Apache Tomcat 10.1 | Web application server |
| Eclipse IDE | Development environment |
| JDK 17 | Java development kit |

---

## 🏗️ Project Architecture

The application follows a layered architecture:

1. **Presentation Layer:** JSP pages display the user interface.
2. **Controller Layer:** Java Servlets handle HTTP requests and responses.
3. **DAO Layer:** Data Access Objects execute database operations using JDBC.
4. **Model Layer:** Java classes represent application entities.
5. **Database Layer:** MySQL stores users, arenas, and bookings.

---

## 📂 Project Structure

```text
Play_Arena/
│
├── src/main/java/
│   └── com/playzone/
│       │
│       ├── controller/
│       │   ├── RegisterServlet.java
│       │   ├── LoginServlet.java
│       │   ├── LogoutServlet.java
│       │   ├── ArenaServlet.java
│       │   ├── BookingServlet.java
│       │   ├── MyBookingsServlet.java
│       │   ├── CancelBookingServlet.java
│       │   ├── AdminDashboardServlet.java
│       │   ├── AdminArenaServlet.java
│       │   └── ArenaActionServlet.java
│       │
│       ├── dao/
│       │   ├── UserDAO.java
│       │   ├── ArenaDAO.java
│       │   ├── BookingDAO.java
│       │   └── AdminDAO.java
│       │
│       ├── model/
│       │   ├── User.java
│       │   ├── Arena.java
│       │   └── Booking.java
│       │
│       └── util/
│           ├── DBConnection.java
│           └── PasswordUtil.java
│
├── WebContent/
│   ├── css/
│   │   └── style.css
│   │
│   ├── index.jsp
│   ├── register.jsp
│   ├── login.jsp
│   ├── dashboard.jsp
│   ├── arenas.jsp
│   ├── booking.jsp
│   ├── my-bookings.jsp
│   ├── admin-dashboard.jsp
│   ├── admin-arenas.jsp
│   │
│   └── WEB-INF/
│       ├── web.xml
│       └── lib/
│
└── README.md
```

*Note: The structure above is illustrative. Your actual Eclipse Dynamic Web Project may use `src` and `WebContent` rather than Maven's `src/main/java` layout.*

---

## ⚙️ Installation and Setup

### 1. Prerequisites

Install the following software:

- JDK 17
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 10.1
- MySQL Server
- MySQL Workbench

### 2. Clone the Repository

```bash
git clone https://github.com/your-username/PlayZone.git
```

Open the project in Eclipse.

### 3. Create the Database

Open MySQL Workbench and execute:

```sql
CREATE DATABASE playzone_db;

USE playzone_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('USER', 'ADMIN') DEFAULT 'USER'
);

CREATE TABLE arenas (
    arena_id INT PRIMARY KEY AUTO_INCREMENT,
    arena_name VARCHAR(100) NOT NULL,
    sport_type VARCHAR(50) NOT NULL,
    location VARCHAR(150) NOT NULL,
    price_per_hour DECIMAL(10,2) NOT NULL,
    description VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    arena_id INT NOT NULL,
    booking_date DATE NOT NULL,
    time_slot VARCHAR(30) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('CONFIRMED', 'CANCELLED')
        DEFAULT 'CONFIRMED',
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    active_slot_key VARCHAR(255)
    GENERATED ALWAYS AS (
        CASE
            WHEN status = 'CONFIRMED'
            THEN CONCAT(
                arena_id, '-',
                booking_date, '-',
                time_slot
            )
            ELSE NULL
        END
    ) STORED,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (arena_id) REFERENCES arenas(arena_id),

    UNIQUE KEY uq_active_slot (active_slot_key)
);
```

### 4. Configure Database Connection

Open:

`DBConnection.java`

Update your MySQL credentials:

```java
private static final String URL =
    "jdbc:mysql://localhost:3306/playzone_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata";

private static final String USERNAME = "root";

private static final String PASSWORD = "your_mysql_password";
```

**Important:** Replace the password with your local MySQL password. Do not upload real credentials to GitHub.

### 5. Add MySQL Connector

Download MySQL Connector/J and add its JAR file to:

```text
WebContent/WEB-INF/lib/
```

Also ensure it is available on the Eclipse project build path.

### 6. Configure Apache Tomcat

1. Add Apache Tomcat 10.1 to Eclipse.
2. Set JDK 17 as the project JRE.
3. Add the project to the Tomcat server.
4. Start the server.

The project uses `jakarta.servlet.*` imports, compatible with Tomcat 10.1.

### 7. Run the Application

Open your browser:

```text
http://localhost:8080/Play_Arena/
```

---

## 🗄️ Database Tables

| Table | Description |
|---|---|
| users | Stores user and admin account details |
| arenas | Stores sports arena information |
| bookings | Stores booking details and reservation status |

### User Roles

- `USER` – Can browse arenas and manage personal bookings.
- `ADMIN` – Can manage arenas and view dashboard statistics.

To grant admin access to an existing registered account:

```sql
UPDATE users
SET role = 'ADMIN'
WHERE email = 'admin@example.com';
```

Log in again to access the admin dashboard.

---

## 🔐 Security Features

- Passwords are stored as salted PBKDF2 hashes.
- Session-based user authentication.
- Role-based access control for admin pages.
- PreparedStatement used for database operations.
- Server-side validation of booking details.
- Database constraint prevents duplicate active bookings.

---

## 📸 Application Modules

Add your project screenshots in a `screenshots/` directory and update the paths below.

| Module | Screenshot |
|---|---|
| Homepage | `screenshots/homepage.png` |
| Registration | `screenshots/register.png` |
| Login | `screenshots/login.png` |
| Arena Listing | `screenshots/arenas.png` |
| Booking Page | `screenshots/booking.png` |
| User Dashboard | `screenshots/dashboard.png` |
| My Bookings | `screenshots/my-bookings.png` |
| Admin Dashboard | `screenshots/admin-dashboard.png` |
| Arena Management | `screenshots/admin-arenas.png` |

---

## 🔮 Future Enhancements

- Online payment gateway integration.
- Email confirmation after successful booking.
- Admin booking management.
- Search and filter arenas by sport and location.
- Real-time slot availability.
- User profile management.
- Booking analytics and reports.
- Mobile-responsive UI improvements.

---

## 🎯 Project Objective

The main objective of PlayZone is to simplify sports arena reservations through a centralized online platform. It reduces manual booking effort, improves arena management, and provides users with a convenient way to reserve sports facilities.

---

## 👨‍💻 Author

**Your Name**

Java | J2EE | JSP | Servlets | JDBC | MySQL

---

## 📄 License

This project was developed for educational and academic purposes.
