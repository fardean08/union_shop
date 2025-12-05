# Union Shop - Flutter Web Application

A responsive e-commerce web application built with Flutter for the University of Portsmouth Student Union Shop. This project demonstrates modern web development practices using Flutter's cross-platform framework with state management, responsive design, and a complete shopping cart implementation.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Installation and Setup](#installation-and-setup)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Page Descriptions](#page-descriptions)
- [State Management](#state-management)
- [Responsive Design](#responsive-design)
- [Academic Context](#academic-context)

## Overview

The Union Shop is a fully functional e-commerce web application I developed for the University of Portsmouth Student Union Shop. This project showcases my skills in modern web development using Flutter's cross-platform framework. The application allows users to browse products, manage their shopping cart with persistent storage, and complete a simulated checkout process. I implemented a responsive design that provides an optimal user experience across desktop, tablet, and mobile devices.

**Important Note**: This is a portfolio/coursework project. The checkout process simulates payment confirmation but does not process real transactions.

## Features

### Core Functionality
- **Product Browsing**: Browse products organized by collections (Shirts, Hoodies, Accessories)
- **Dynamic Product Pages**: View detailed product information with size and color selection
- **Shopping Cart**: Add, remove, and manage cart items with persistent storage
- **Checkout Simulation**: Complete checkout flow with confirmation (no real payment processing)
- **Search Functionality**: Search across all products
- **Sale Page**: View discounted items and special offers
- **User Authentication UI**: Login and signup pages (UI only, no backend)

### Technical Features
- **State Management**: Provider package for global cart state
- **Persistent Cart**: Cart data saved using SharedPreferences
- **Responsive Layout**: Mobile-first design with breakpoints for tablet and desktop
- **Navigation**: Named routes with proper argument passing
- **Reusable Components**: Modular widget architecture
- **Data Models**: Structured product and cart data models

## Technologies Used

- **Flutter** (SDK >=2.17.0 <4.0.0) - UI framework
- **Dart** - Programming language
- **Provider** (^6.1.1) - State management
- **SharedPreferences** (^2.2.2) - Local data persistence
- **UUID** (^4.0.0) - Unique identifier generation

## Project Structure

```
lib/
├── main.dart                          # Application entry point and home page
├── models/                            # Data models
│   ├── product.dart                   # Product data model
│   └── cart_variant.dart              # Cart item variant model
├── utils/                             # Utility classes
│   └── responsive.dart                # Responsive helper functions
├── widgets/                           # Reusable widgets
│   └── mobile_drawer.dart             # Mobile navigation drawer
├── cart_provider.dart                 # Cart state management
├── product_page.dart                  # Product detail page
├── cart_page.dart                     # Shopping cart page
├── collections_page.dart              # Collections overview page
├── collections_shirts_page.dart       # Shirts collection page
├── collections_hoodies_page.dart      # Hoodies collection page
├── collections_accessories_page.dart  # Accessories collection page
├── about_page.dart                    # About page
├── sale_page.dart                     # Sale/promotional page
├── print_shack_page.dart              # Custom printing service page
├── search_page.dart                   # Product search page
├── login_page.dart                    # Login page (UI only)
├── signup_page.dart                   # Signup page (UI only)
├── collection.dart                    # Collection data class
├── collection_page.dart               # Individual collection page template
└── sample_collections.dart            # Sample collection data

test/                                  # Test files
├── widget_test.dart                   # Widget tests
├── cart_provider_test.dart            # Cart provider tests
├── responsive_test.dart               # Responsive helper tests
├── navigation_test.dart               # Navigation tests
├── models_test.dart                   # Model tests
├── pages_test.dart                    # Page widget tests
└── integration_test.dart              # Integration tests

assets/
└── images/                            # Image assets
```

## Installation and Setup

### Prerequisites

- Flutter SDK (version 2.17.0 or higher)
- A web browser (Chrome recommended)
- Git (optional, for cloning)

### Setup Steps

1. **Navigate to the project directory**
   ```bash
   cd path/to/union_shop
   ```

2. **Clean the project** (removes previous build artifacts)
   ```bash
   flutter clean
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

## Running the Application

### Web (Chrome)

```bash
flutter run -d chrome
```

The application will launch in your default Chrome browser.

### Alternative Platforms

```bash
# Run on Edge
flutter run -d edge

# Run on Windows desktop
flutter run -d windows

# List all available devices
flutter devices
```

## Testing

The project includes a comprehensive test suite covering widgets, state management, navigation, and integration testing.

### Run All Tests

```bash
flutter test
```

### Run Specific Test Files

```bash
# Run cart provider tests
flutter test test/cart_provider_test.dart

# Run widget tests
flutter test test/widget_test.dart
```

### Generate Coverage Report

```bash
flutter test --coverage
```

## Page Descriptions

### Home Page (`main.dart`)
- Landing page with hero banner carousel
- Featured products section
- Navigation bar and footer
- Announcement bar for promotions

### Collections Page (`collections_page.dart`)
- Overview of all product collections
- Category cards with images
- Navigation to specific collection pages

### Collection Pages
- **Shirts** (`collections_shirts_page.dart`) - T-shirts and casual wear
- **Hoodies** (`collections_hoodies_page.dart`) - Hoodies and sweatshirts
- **Accessories** (`collections_accessories_page.dart`) - Bags, hats, and other items

### Product Page (`product_page.dart`)
- Product images and details
- Size and color selection dropdowns
- Add to cart functionality
- Price display with tax information

### Cart Page (`cart_page.dart`)
- View all cart items
- Adjust quantities or remove items
- View subtotal, tax, and total
- Proceed to checkout

### About Page (`about_page.dart`)
- Information about the Student Union
- Mission and values
- Contact information

### Sale Page (`sale_page.dart`)
- Promotional banners
- Discounted products
- Limited-time offers

### Search Page (`search_page.dart`)
- Search functionality across products
- Filter and sort options
- Results grid

### Print Shack Page (`print_shack_page.dart`)
- Custom printing services
- Request form for custom designs

### Login/Signup Pages
- User interface for authentication
- Form validation (UI only, no backend)

## State Management

The application uses the **Provider** package for state management, specifically for the shopping cart functionality.

### CartProvider (`cart_provider.dart`)

Key features:
- Add items to cart with selected variants (size, color)
- Remove items from cart
- Update item quantities
- Calculate totals (subtotal, tax, shipping)
- Persist cart data using SharedPreferences
- Restore cart on app launch

Example usage:
```dart
// Access cart in a widget
final cart = Provider.of<CartProvider>(context);

// Add item to cart
cart.addItem(product, selectedSize, selectedColor);

// Get item count
cart.itemCount
```

## Responsive Design

The application implements a responsive design system with three breakpoints:

- **Mobile**: < 600px width
- **Tablet**: 600px - 1024px width
- **Desktop**: > 1024px width

### Responsive Helper (`utils/responsive.dart`)

Provides utility methods for responsive values:
- `isMobile(context)` - Check if current viewport is mobile
- `isTablet(context)` - Check if current viewport is tablet
- `isDesktop(context)` - Check if current viewport is desktop
- `value()` - Return different values based on screen size
- `fontSize()` - Responsive font sizes
- `gridColumns()` - Responsive grid column counts

### Mobile Navigation

The `MobileDrawer` widget provides a hamburger menu navigation for mobile devices, replacing the horizontal navbar on smaller screens.

## Project Context

**Institution**: University of Portsmouth  
**Course**: Web Development / Computer Science  
**Project Type**: Coursework Assessment / Portfolio Project  
**Framework**: Flutter Web  
**Development Period**: 2024-2025  

### Skills & Technologies Demonstrated

Through this project, I have demonstrated proficiency in:

1. **Modern Web Development**: Built a full-featured web application using Flutter for cross-platform development
2. **State Management**: Implemented the Provider pattern for efficient global state management
3. **Responsive Design**: Created a mobile-first design with adaptive layouts for all screen sizes
4. **Data Modeling**: Designed and implemented structured data classes for products and cart items
5. **Navigation**: Developed a comprehensive routing system with proper argument passing
6. **Data Persistence**: Implemented local storage using SharedPreferences for cart state
7. **Testing**: Wrote comprehensive test coverage including unit, widget, and integration tests
8. **Code Organization**: Followed modular architecture principles with clear separation of concerns
9. **UI/UX Design**: Created an intuitive, modern user interface with attention to user experience

### Implementation Details

- **Frontend Only**: This project focuses on frontend development and does not include backend integration
- **Simulated Features**: Payment processing and user authentication are UI demonstrations
- **Static Data**: Product data is currently hard-coded for demonstration purposes
- **Production-Ready Code**: Despite being a coursework project, the code follows production-level best practices

## Future Enhancements

As I continue to develop my skills, potential improvements I would implement for production deployment include:

- **Backend Integration**: RESTful API or GraphQL backend for dynamic product data
- **Authentication System**: Secure user authentication with JWT or OAuth
- **Payment Gateway**: Integration with Stripe, PayPal, or similar payment processors
- **Database**: PostgreSQL or Firebase for persistent product and user data storage
- **User Features**: Order history, user profiles, and account management
- **Social Features**: Product reviews, ratings, and user-generated content
- **Enhanced Search**: Advanced filtering, sorting, and search with Algolia or similar
- **Additional Features**: Wishlist functionality, email notifications, and inventory management
- **Performance**: Image optimization, lazy loading, and CDN integration
- **Analytics**: User behavior tracking and conversion optimization

## About Me

I am a Computer Science student at the University of Portsmouth, passionate about web development and creating user-friendly applications. This project represents my journey in learning Flutter and modern web development practices. I'm constantly looking to improve my skills and take on new challenges in software development.

**Skills**: Flutter, Dart, State Management, Responsive Design, Testing, Git  
**Connect with me**: [Add your LinkedIn/GitHub/Portfolio links here]

---

**Developer**:Fardean Aymagh
**Institution**: University of Portsmouth  
**Project Date**:December 2025  
**Version**: 1.0.0  
**License**: Academic Project
