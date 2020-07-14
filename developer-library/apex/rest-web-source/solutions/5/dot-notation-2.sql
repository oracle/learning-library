select t.json_document.title,
  t.json_document.completed,
  created_on
from todos t
where t.json_document.completed = 'true'