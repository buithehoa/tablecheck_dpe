# README

<!-- PROJECT LOGO -->
<p>
  <h2>TableCheck Dynamic Pricing Engine</h2>
  <p>
    Build a simple e-commerce platform with a dynamic pricing engine that adjusts product prices in real-time based on demand, inventory levels, and competitor prices.
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#code-navigation">Code Nagivation</a></li>
    <li><a href="#platform-api-overview">Platform API Overview</a></li>
    <li><a href="#dynamic-product-pricing-logic">Dynamic Product Pricing Logic</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project
[TableCheck Dynamic Pricing Engine Specification](https://github.com/TableCheck-Labs/tablecheck-ruby-take-home/blob/main/README.md)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running, follow these steps.

### Prerequisites

[Docker 24](https://docs.docker.com/get-docker/)
<br/>
[Docker Compose 1.29](https://docs.docker.com/compose/install/)

### Installation

1. Clone the repo
   ```sh
   git clone git@github.com:buithehoa/tablecheck_dpe.git
   ```
2. Build and run Docker containers by navigating to the project's root directory and executing
   ```sh
   docker compose up --build
   ```
3. Create user seed data
   ```sh
   docker exec -it tablecheck_dpe-app-1 bash
   bundle exec rake db:seed
   ```
4. Verify if the Rails app is running by visiting http://localhost:3000 in your web browser.

## Testing
Run all specs with `bundle exec rspec`
```sh
$ bundle exec rspec
Finished in 1.13 seconds (files took 0.14603 seconds to load)
24 examples, 0 failures
```

## Code Navigation
1. [Competitor Price API](https://sinatra-pricing-api.fly.dev/docs) integration is implemented in 
   ```
   lib/competitor_product_fetcher.rb
   ```
2. Dynamic Pricing Engine is implemented in
   ```
   lib/dynamic_pricing_engine.rb
   ```
3. Sidekiq jobs which periodically sync competitor prices and adjust product prices are implemented in
   ```
   app/sidekiq/competitor_price_sync_job.rb
   app/sidekiq/dynamic_pricing_job.rb
   ```

# Platform API Overview
This Platform API offers a set of functionalities to manage products, orders, and user authentication.

Here's a breakdown of the key features:
* Product Management:
  * Retrieve detailed information about products, including attributes like name, description, price, and inventory.
* Order Management:
  * Create new orders for products available on the platform.
  * View the status of existing orders.
* Authentication:
  * Users are identified and authorized through secure API tokens.
* Versioning:
  * The API is versioned to facilitate updates and ensure compatibility with existing integrations.

Refer to the comprehensive [Platform API Documentation](https://github.com/buithehoa/tablecheck_dpe/blob/main/docs/api/v1/README.md) to learn more about all functionalities.

# Dynamic Product Pricing Logic
This outlines the logic used to dynamically adjust product prices based on several criteria:

* Inventory Level:
  * A predefined threshold (`INVENTORY_HIGH_THRESHOLD`) defines high inventory levels.
  * If the product inventory is higher than this threshold, the base price is decreased by a predefined percentage (`INVENTORY_HIGH_ADJUSTMENT`).
  * Conversely, if the inventory is lower than a predefined threshold (`INVENTORY_LOW_THRESHOLD`), the base price is increased by another predefined percentage (`INVENTORY_LOW_ADJUSTMENT`).

* Demand:
  * Demand is calculated as the sum of purchased quantity and added to cart quantity for the product in the recent past (e.g., last 7 days).
  * If the calculated demand is higher than a predefined threshold (`DEMAND_THRESHOLD`), the base price is increased by a predefined percentage (`DEMAND_ADJUSTMENT`).

* Competitor Price:
  * After applying the inventory and demand adjustments, the final adjusted price is compared to the competitor price obtained from [Competitor Price API](https://sinatra-pricing-api.fly.dev/docs).
  * The current strategy is to be price competitive, so the final price is set to the minimum between the adjusted price and the competitor price.

Competitor prices are fetched at regular intervals by `competitor_price_sync_job`. `dynamic_pricing_job` then uses this data to adjust product prices periodically. Configuration for both jobs is located in `config/schedule.yml`.