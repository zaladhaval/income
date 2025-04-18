package com.car.rental.config;

import com.car.rental.car.Car;
import com.car.rental.car.CarRepository;
import com.car.rental.customer.IncomeUser;
import com.car.rental.customer.IncomeUserRepository;
import com.car.rental.enums.CarStatus;
import com.car.rental.enums.FuleType;
import com.car.rental.enums.GearType;
import com.car.rental.enums.UserType;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    private final IncomeUserRepository userRepository;
    private final CarRepository carRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(IncomeUserRepository userRepository, CarRepository carRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.carRepository = carRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        // Create admin user if not exists
        if (userRepository.count() == 0) {
            createUsers();
        }

        // Create sample cars if not exists
        if (carRepository.count() == 0) {
            createCars();
        }
    }

    private void createUsers() {
        // Create admin user
        IncomeUser admin = new IncomeUser();
        admin.setName("Admin User");
        admin.setUserName("admin");
        admin.setEmail("admin@example.com");
        admin.setPassword(passwordEncoder.encode("admin123"));
        admin.setUserType(UserType.ADMIN);
        admin.setContactNumber("1234567890");

        // Create staff user
        IncomeUser staff = new IncomeUser();
        staff.setName("Staff User");
        staff.setUserName("staff");
        staff.setEmail("staff@example.com");
        staff.setPassword(passwordEncoder.encode("staff123"));
        staff.setUserType(UserType.STAFF);
        staff.setContactNumber("9876543210");

        // Create customer user
        IncomeUser customer = new IncomeUser();
        customer.setName("Customer User");
        customer.setUserName("customer");
        customer.setEmail("customer@example.com");
        customer.setPassword(passwordEncoder.encode("customer123"));
        customer.setUserType(UserType.CUSTOMER);
        customer.setContactNumber("5555555555");

        userRepository.saveAll(Arrays.asList(admin, staff, customer));
    }

    private void createCars() {
        List<Car> cars = Arrays.asList(
            createCar("Toyota Camry", "Toyota", "Camry", "Silver", "Comfortable sedan for family trips", "TYT-1234", 2000, FuleType.PETROL, GearType.AUTOMATIC, new BigDecimal("50.00"), "https://example.com/camry.jpg"),
            createCar("Honda Civic", "Honda", "Civic", "Blue", "Economical and reliable compact car", "HND-5678", 1800, FuleType.PETROL, GearType.MANUAL, new BigDecimal("45.00"), "https://example.com/civic.jpg"),
            createCar("Ford Mustang", "Ford", "Mustang", "Red", "Powerful sports car for an exciting drive", "FRD-9012", 5000, FuleType.PETROL, GearType.AUTOMATIC, new BigDecimal("120.00"), "https://example.com/mustang.jpg"),
            createCar("Tesla Model 3", "Tesla", "Model 3", "White", "Electric car with advanced features", "TSL-3456", 0, FuleType.ELECTRIC, GearType.AUTOMATIC, new BigDecimal("100.00"), "https://example.com/tesla.jpg"),
            createCar("BMW X5", "BMW", "X5", "Black", "Luxury SUV with spacious interior", "BMW-7890", 3000, FuleType.DIESEL, GearType.AUTOMATIC, new BigDecimal("150.00"), "https://example.com/bmw.jpg"),
            createCar("Audi A4", "Audi", "A4", "Gray", "Premium sedan with elegant design", "AUD-1234", 2000, FuleType.PETROL, GearType.AUTOMATIC, new BigDecimal("90.00"), "https://example.com/audi.jpg"),
            createCar("Mercedes-Benz C-Class", "Mercedes", "C-Class", "Silver", "Luxury sedan with advanced technology", "MRC-5678", 2200, FuleType.DIESEL, GearType.AUTOMATIC, new BigDecimal("110.00"), "https://example.com/mercedes.jpg"),
            createCar("Hyundai Tucson", "Hyundai", "Tucson", "Green", "Compact SUV with great fuel efficiency", "HYN-9012", 1600, FuleType.PETROL, GearType.MANUAL, new BigDecimal("60.00"), "https://example.com/tucson.jpg"),
            createCar("Nissan Altima", "Nissan", "Altima", "Blue", "Mid-size sedan with comfortable ride", "NSN-3456", 2500, FuleType.PETROL, GearType.AUTOMATIC, new BigDecimal("55.00"), "https://example.com/altima.jpg"),
            createCar("Jeep Wrangler", "Jeep", "Wrangler", "Orange", "Off-road vehicle for adventure seekers", "JEP-7890", 3600, FuleType.PETROL, GearType.MANUAL, new BigDecimal("85.00"), "https://example.com/wrangler.jpg")
        );

        carRepository.saveAll(cars);
    }

    private Car createCar(String name, String brand, String model, String color, String description, String carNumber, 
                         long engineCC, FuleType fuelType, GearType gearType, BigDecimal dailyRate, String imageUrl) {
        Car car = new Car();
        car.setName(name);
        car.setBrand(brand);
        car.setModel(model);
        car.setColor(color);
        car.setDescription(description);
        car.setCarNumber(carNumber);
        car.setEngineCC(engineCC);
        car.setFuelType(fuelType);
        car.setGearType(gearType);
        car.setStatus(CarStatus.AVAILABLE);
        car.setDailyRate(dailyRate);
        car.setImageUrl(imageUrl);
        car.setPurchaseDate(System.currentTimeMillis());
        return car;
    }
}
