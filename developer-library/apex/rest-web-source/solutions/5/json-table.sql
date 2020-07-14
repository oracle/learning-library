select title, completed, created_on
from todos,
  json_table(
    json_document, 
    '$' columns (
      title     varchar2(255) path '$.title',
      completed varchar2(16)  path '$.completed'
    ) 
  ) 