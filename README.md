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
    <li><a href="#usage">Usage</a></li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#code-navigation">Code Nagivation</a></li>
    <li><a href="#contact">Contact</a></li>
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
2. Build and start Docker containers
   ```sh
   docker compose up --build
   ```
3. Create user seed data
   ```sh
   docker exec -it tablecheck_dpe-app-1 bash
   bundle exec rake db:seed
   ```
4. Verify if the Rails app is running by visiting http://localhost:3000 in your web browser.