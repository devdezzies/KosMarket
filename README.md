# E-Commerce Web Application
abiyoso danar panji
## Project Description
This is an e-commerce web application developed using JSP and Servlet technology, implementing the MVC (Model-View-Controller) design pattern. The application provides features for user account management, product browsing, cart management, and order logging. 

![KosMarket E-Commerce Application Screenshot](assets/class-d.jpg)

---

## Features
- User authentication (Admin, Member, Guest)
- Product browsing and search by category or name
- Order management (sold out product history)
- Bookmarking products for future reference
- Admin functionality for managing products and categories

---

## Todos
### Additional Todos

- [ ] **Design UI**  
    _Deadline: Tuesday, 20 May 2025_ — Upan & Hilmi
- [ ] **Update class diagram**  
    _Deadline: Sunday, 18 May 2025_ — Everyone
- [ ] **Create dummy data**  
    _Deadline: Monday, 19 May 2025_ — Abdullah
- [ ] **Develop views** (Start after dummy data is completed)  
    _Deadline: To be determined_ — Everyone

### Initial Setup
- [ ] Set up database connection (`DatabaseConnection.java`).

### Model Development
- [ ] Implement models: `Account`, `Member`, `Admin`, `Product`, `Order`, etc.

### Controller Development
- [ ] Develop `ProductController` for product-related actions.
- [ ] Develop `AccountController` for user authentication.
- [ ] Develop `OrderController` for order management.

### View Development
- [ ] Create JSP files for views: `index.jsp`, `product.jsp`, `cart.jsp`, etc.
- [ ] Add CSS and JavaScript for front-end styling and functionality.

### Testing
- [ ] Perform integration testing for servlets and views.

### Deployment
- [ ] Deploy the application to a server.


## Pembagian Tugas (View)

- **Abdullah:** Login, Register
- **Abi:** Product Info (Sell)
- **Fery:** Profile, Account
- **Beben:** Product Info (Buy)
- **Upan:** Beranda
- **Hilmi:** Admin

## Pembagian Tugas (Fitur)

- **Abdullah:** Database Connection, User Authentication (Admin, Member, Guest)
- **Abi:** _(Belum ditentukan)_
- **Fery:** _(Belum ditentukan)_
- **Beben:** _(Belum ditentukan)_
- **Upan:** _(Belum ditentukan)_
- **Hilmi:** _(Belum ditentukan)_
---

## Tailwind CSS Setup

This project uses Tailwind CSS for styling. Follow these steps to set up and build the CSS:

### Prerequisites

- Node.js and npm installed on your machine

### Installation

1. Install the required npm packages:

```bash
npm install
```

### Building CSS

To build the Tailwind CSS file:

```bash
npm run build:css
```

This will process the input CSS file at `src/main/webapp/css/input.css` and output the compiled Tailwind CSS to `src/main/webapp/css/tailwind.css`.

### Development Mode

To watch for changes and automatically rebuild the CSS during development:

```bash
npm run watch:css
```

### Usage

After building the CSS, the Tailwind styles will be available in all JSP pages that include the header:

```jsp
<%@ include file="/WEB-INF/includes/header.jsp" %>
```

The header includes a link to the compiled Tailwind CSS file.
