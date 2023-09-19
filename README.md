https://github.com/Antoine-Aube/little-shop-7
https://github.com/users/Antoine-Aube/projects/3/views/2
https://miro.com/app/board/uXjVMmORetk=/

# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- [Optional] Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- Must use Rails 7.0.x, Ruby 3.2.2
- Must use PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- Must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- Must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- Must deploy completed code to the internet (using Heroku or Render)
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
- Any gems added to the project must be approved by an instructor
  - Pre-approved gems are `capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, launchy`

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Work Completed
 - The project team worked together to build out functionality for the admin and merchant pages on this ficticioius e-commerce platform.
 - Merchant dashboard, merchant items and merchant invoice pages were built in order to track item and invoice fulfillment from merchant dashboard.
 - Admin dashboard, admin merchant and admin invoice pages were built to track overall item and invoice fulfillment from admin dashboard.
 - Complex Active Record queries were used to provide statistics and useful information for both admin and merchant dashboard views.
 - Advanced routing used throughout project, and partials were used to dry up similar code.

 ## Potential Refactor / Expansion Options
 - Option to update invoice statuses on one page at the same time
 - Sorting options, on each page that lists merchants, invoices or items, there is an option to sort alphabetically or by most recent date
 - Styling - Implementing a more consistent look and feel throughout site with reusable styles
 - API Consumption - Utilizing Unsplash to create a logo for the site and photos of items and merchants on each page and tracking image statistic/like history of site logo.
 - Authentication / Authorization for admin and/or merchants
 - Implement cart functionality for users to add items to their carts.
 - Site chat functionality

## Contributors
Antoine: 
- [GitHub](https://github.com/Antoine-Aube)
- Email: aaube3@gmail.com

Kaylee: 
- [GitHub](https://github.com/kbug819)
- Email: kaylee.j.janes@gmail.com

Paul: 
- [GitHub](https://github.com/pcbennett108)
- Email: pcbennett42@gmail.com

Will Chen: 
- [GitHub](https://github.com/williamfchen)
- Email: wfchen1990@gmail.com