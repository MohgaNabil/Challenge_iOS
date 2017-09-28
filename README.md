## Overview

Create an app that lets users create a new Mimo account or lets user login with their existing Mimo account.

- The goal is to show us that you can write clean and well-structured code. This project is small on purpose, but you should handle it as a real-world project.
- This project should show us how you'd write code in a real-world project, so don't treat this as a quick hack. Structure everything as you'd do when you're working for us.
- You won't be judged on the visual design at all; the only metric is your code.
- Don't use storyboards or xibs to create the interface, do it in code.
- Part of this coding challenge is to read the documentation for the APIs provided to you.
- Use the provided APIs and libraries. If you want to add additional pods, feel free to do so. (Exception: *Lock by Auth0*; remember you should write the authentication code!)
- Use Git to track your changes and upload your Git repo either on [GitHub](https://github.com) or [Bitbucket](https://bitbucket.com) to share it with us.
- Make your first commit, once you start and commit regularly.
- Don't fork this repo. Copy the code into a new folder and start a new project.

All of the authentication is done via [Auth0](https://auth0.com/)

- Auth0 Domain: `mimo-test.auth0.com`
- Auth0 Client ID: `PAn11swGbMAVXVDbSCpnITx5Utsxz1co`
- Auth0 Connection Name: `Username-Password-Authentication`

## Authentication VC

    - The VC should contain two fields: One for the email address and one for the password.
    - If the email doesn't exist upon login, display an error message stating that the account doesn't exist.
    - If the email exists upon signup, display an error message stating that the account already exists.
    - After the login/signup, show the MainViewController.
    - Display an alert when the user doesn't enter a e-mail address or enters a password that has less than 6 characters
    - Don't use any external library to handle the authentication for you. (Networking libraries like Alamofire are allowed!)

Relevant Auth0 API: [Link_1](https://auth0.com/docs/api/authentication#database-ad-ldap-active-)
[Link_2](https://auth0.com/docs/api/authentication#signup)
Use `openid profile email` for the `scope` parameter

## Main VC

    - The MainViewController should display the email address of the user. Get this info from the JWT that you receive.
    - Log out should bring you back to the authentication view controller.

## Unit tests

    - Write unit tests for the e-mail address and password sanity checks

## Bonus tasks

    - If you're brave enough, also display the Gravatar picture associated with the email address instead of the default image.
    - If the user isn't logged in or the JWT is expired, show an error message instead of the MainController.
