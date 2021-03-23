# Rolling back changes

## Introduction

In this lab we will rollback changes we made to production.

Estimated Lab Time: 5 minutes

### Objectives

In this lab you will:

- Revert changes made to the production environment.

## **STEP 1:** Rollback

1. Rolling back consists in going back to a previous state. Using our release branches it's easy to rollback to a given version

2. Checkout the release branch to roll back to

  ```bash
  <copy>
  git checkout release/v1.0.0
  </copy>
  ```

3. Apply the rollback

  ```bash
  <copy>
  make rollback ENV=prd ID=100
  </copy>
  ```

  *Note: `rollback` is not the same as `update` as the schema change history is also reverted. Applying an `update` from an older version to the latest production environment would in fact cause issues with history tracking.*
  
## **STEP 2:** Verify the changes were rolled back

1. Login to the ATP database for *`prd`* and sign in to the workspace with the WS_ADMIN user as before.

2. Check that the changes made previously were indeed reversed:

    - The table **EBA\_SALES\_ACCESS\_LEVELS** should not longer contain the **BOGUS** additional column

    - The application **Opportunities** page name should have reverted to its original name


You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, Vanitha Subramanyam, March 2021
 - **Last Updated By/Date** - Emmanuel Leroy, Vanitha Subramanyam, March 2021

