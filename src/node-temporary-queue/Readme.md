# Goal 
- R and D around adding and removing queues on the fly to allow for a request and response mechanism that use lambda and sqs


## Learnings

- When creating a layer in AWS lambda remember to:
1) Add a index.js to export you methods from your js class
2) Include all files that are relevant ie. package.json, index.js etc
3) Create a folder in node_modules for you packages and include all relevant files in there
4) Use javascript debug terminal when wanting to step through node js code. just set breakpoints when intiating from a debug terminal it will attach
5) Creating a local js file is a very good way to kick off testing simulating aws console environment