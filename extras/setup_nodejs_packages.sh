#!/usr/bin/env bash


# TODO: organize comments / add echo statements to improve readability

# install node packages

# note: -g option will install as a glocal package

# note: you can find more documentation by going to https://www.npmjs.com/package/<package_name>


# Useful Packages for most projects: 

# Apache Cordova is an open-source mobile development framework.
# It allows you to use standard web technologies - HTML5, CSS3, and JavaScript for cross-platform development.
npm install -g cordova

# Express is a fast, unopinionated, minimalist web framework for Node.js.
npm install -g express

# Axios is a promise based HTTP client for the browser and node.js.
npm install -g axios

# Custom env loads environment variables from your .env file into process.env.
npm install -g custom-env

# GraphQL.js is the JavaScript reference implementation for GraphQL.
npm install -g graphql

# This package exports a JSON value scalar GraphQL.js type.
npm install -g graphql-type-json

# Apollo Server is a community-maintained open-source GraphQL server that works with many Node.js HTTP server frameworks.
# apollo-server-express is for integration with the express web framework.
npm install -g apollo-server-express

# Moment is a JavaScript date library for parsing, validating, manipulating, and formatting dates.
npm install -g moment

# Nodemon automatically restarts the node application when file changes are detected.
npm install -g nodemon
# note: use as a wrapper for node (example: nodemon ./server.js localhost 8080)

# utf8.js is a well-tested UTF-8 encoder/decoder written in JavaScript.
npm install -g utf8



# Unit Testing Packages:

# Chai is a BDD / TDD assertion library for node that can be paired with any JS testing framework.
npm install -g chai

# eslint is a tool for identifying and reporting on patterns found in ECMAScript/JavaScript code.
npm install -g eslint

# mocah is a JavaScript test framework for Node.js.
npm install -g mocha

# nyc is a code coverage / reporting tool.
npm install -g nyc

# Proxies nodejs's require in order to make overriding dependencies during testing easy while staying totally unobtrusive.
npm install -g proxyquire

# rewire adds a special setter and getter to modules so you can modify their behaviour for better unit testing.
npm install -g rewire

# Sinon is a standalone and test framework agnostic JavaScript test spies, stubs and mocks.
npm install -g sinon



# OPTIONAL PACKAGES:

# ldapjs is a pure JavaScript, from-scratch framework for implementing LDAP clients and servers in Node.js.
# npm install ldapjs


# Microsoft SQL Server client for Node.js.
# npm install mssql