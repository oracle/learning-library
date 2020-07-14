async function create(todo) {
  let conn;

  try {
    conn = await oracledb.getConnection();

    const soda = conn.getSodaDatabase();

    const collection = await soda.openCollection('todos');

    const sodaDoc = await collection.insertOneAndGet(todo);

    return sodaDoc.key;
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