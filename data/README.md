# Reporting Project for TAP

## Architecture

For reporting we have > 15 views that manipulate the underlying KV storage schema
in order to provide biweekly reports for payout and validation of input data. A
k/v oriented schema is used in Postgresql in order to keep high developer velocity
when shoving data into system and to defer the complexity of schema creation until
the product is mature. As this point we compensate through using DBT views and
db functions in order to make for a clean reporting interface which is hosted on Retool.

Reporting database runs on a hosted platform and has automatic backups in case of
issue.

Data is piped from various custom sources into database on intervals of 15m and 60m.

## Security

All sensitive information is handled via ENV variables and loaded in from secure
secrets storage.

### Usage

The ./bin folder contains helpers to run normal tasks including a `dev` command
for deploying to development schema, seeding and running tests as well as a `deploy`
command to do the same for production.

### DBT Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
