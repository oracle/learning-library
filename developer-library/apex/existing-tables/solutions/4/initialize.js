async function initialize() {
  let conn;

  try {
    await oracledb.createPool(databaseConfig.todoPool);

    conn = await oracledb.getConnection();

    const soda = conn.getSodaDatabase();

    await soda.createCollection('todos');
  } catch (err) {
    throw err;
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