#  Analyzing Food Delivery Operations

## Overview

This repository presents a comprehensive case study analyzing the operations of a food delivery platform. Leveraging MySQL, I designed and implemented a database schema to capture essential data points across customers, restaurants, menu items, orders, and delivery partners. The database schema encompasses multiple tables, each precisely oragnised to facilitate efficient data management and analysis.

## Dataset Description

- `customers`: Stores information about Swiggy users, including their user IDs, names, email addresses, and passwords.
- `restaurants`: Contains details about partner restaurants, such as restaurant IDs, names, and cuisine types.
- `food`: Lists various food items available on the menu, along with their IDs and types.
- `menu`: Maps food items to specific restaurants and includes pricing information.
- `delivery_partner`: Records details of delivery partners, including their IDs and names.
- `orders`: Captures order-related information, such as order IDs, user IDs, restaurant IDs, delivery partner IDs, dates, delivery times, ratings, and amounts.
- `order_details`: Links orders to the food items ordered, facilitating a granular view of order contents.

## Key Features

- **Database Schema Design**: Developed a normalized schema to ensure data integrity and minimize redundancy, enabling efficient data storage and retrieval.
- **Data Import**: Imported relevant datasets into the MySQL database, ensuring seamless integration of real-world data for analysis.
- **Analysis and Insights**: Analyzed the Swiggy dataset to extract actionable insights, including customer preferences, restaurant performance, revenue trends, and growth patterns. Formulated SQL queries to address nine insightful questions, ranging from customer behavior analysis to revenue growth trends.

## Project Impact

- **Customer Insights**: Gain valuable insights into customer behavior, preferences, and ordering patterns, enabling targeted marketing campaigns and personalized customer engagement strategies.
- **Restaurant Performance Evaluation**: Evaluate the performance of partner restaurants based on order volumes, revenues, and customer satisfaction ratings, facilitating strategic decision-making and partnership management.
- **Revenue Growth Analysis**: Track month-over-month revenue growth trends at both the overall platform level and individual restaurant level, identifying opportunities for revenue optimization and business expansion.
- **Operational Efficiency**: Enhance operational efficiency by analyzing delivery partner performance, optimizing delivery routes, and streamlining order fulfillment processes.
- **Data-Driven Decision-Making**: Empower Swiggy stakeholders with data-driven insights to make informed decisions, drive business growth, and enhance customer satisfaction.

By leveraging MySQL and conducting comprehensive data analysis, this project offers valuable insights into the operations and performance of Swiggy, facilitating informed decision-making and strategic planning for business success.
