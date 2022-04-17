# Overview

Quickly understand whats involved in standing up a sqs and api gateway with terraform and call into it using a .net core 6 app.

(Neglected normal tdd approach and focused more on discovering how the sdk works in context of these components)

## What does this project consist of:
1. Terraform to create up:
    - Roles
    - Lambda
    - Api Gateway
    
2. .Net Core console app with integrations into those components
