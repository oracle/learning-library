async function find() {
  let conn;

  try {
    const todos = [];

    conn = await oracledb.getConnection();

    const soda = conn.getSodaDatabase();

    const collection = await soda.openCollection('todos');

    const sodaDocs = await collection.find().getDocuments();

    for (let idx = 0; idx < sodaDocs.length; idx += 1) {
      let todo = sodaDocs[idx].getContent();

      todo.id = sodaDocs[idx].key;

      todos.push(todo);
    }

    return todos;
  } catch (err) {
    console.error(err);
  } finally {
    if (conn) {
      try {
        await conn.close();
      } catch (err) {
        console.error(err);
      }
    }
  }
}