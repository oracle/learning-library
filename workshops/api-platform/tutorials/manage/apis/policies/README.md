# API Policies
When creating an API Policy Implementation, we choose policies and configure them to perform functions like secure, throttle and route calls between front-end clients and back-end services.

The most simple API Policy Implementation contains at least two policies; the API Request Policy, and the Service Request Policy.  This is the simple *proxy* pattern which provides an end-point for front-end clients, and routes the request to some sort of back-end service and returns the response.

Not all policies may be represented in a separate tutorial.  Sometimes, providing a general overview of the settings in a scenario may suffice, where other times, we may want to delve deeper into the policy itself.