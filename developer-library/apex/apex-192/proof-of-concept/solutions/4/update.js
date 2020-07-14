async function update(key, todo) {
  let conn;

  try {
    conn = await oracledb.getConnection();

    const soda = conn.getSodaDatabase();

    const collection = await soda.openCollection('todos');

    const sodaDoc = await collection.find().key(key).replaceOneAndGet(todo);

    if (sodaDoc) {
      return true;
    } else {
      return false;
    }
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