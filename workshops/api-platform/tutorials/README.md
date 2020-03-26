# API Platform Tutorials

Welcome to the tutorials for API Platform.  Here we are creating a collection of tutorials design to provide opportunities to learn about and demo API Platform Cloud Service.

## Environments
These tutorials are design to be generically used in whatever environment you might be using however if you are not the administrator of the environment you are using, you may not have all of the necessary permissions to perform all of the tutorials.  

Refer to the [environments](../environments/README.md) for details and caveats for different environments.

## Catalog of Tutorials
### API Design
Tutorial | Skill Level | Prerequisite Tutorials
--- | --- | --- 
[Design an API](./design/design_api) | Learner | *None*

### API Management
Tutorial | Skill Level | Prerequisite Tutorials
--- | --- | --- 
[Create an API Policy Implementation](./manage/apis/create_api) | Learner | [Design an API](./design/design_api)
[Deploy an API](./manage/apis/deploy_api) | Learner | [Create an API Policy Implementation](./manage/apis/create_api)
[Invoke an API](./manage/apis/invoke_api) | Learner | [Deploy an API](./manage/apis/deploy_api)
[Entitle an API to a Plan]./manage/apis/entitle_api | Learner | [Create an API Policy Implementation](./manage/apis/create_api), [Create an API Plan](./manage/plans/create_plan)
[Create an API Plan](./manage/plans/create_plan) | Learner | *None*
[Create a Service](./manage/services/create_service) | Learner | *None*
[Add a Method Mapping Policy](./manage/apis/policies/method_mapping) | Learner | [Create an API Policy Implementation](./manage/apis/create_api), [Create a Service](./manage/services/create_service)

### Gateway Management
Tutorial | Skill Level | Prerequisite Tutorials
--- | --- | --- 
[Grant Access to a Gateway](./manage/gateways/grants) | Learner | *None*