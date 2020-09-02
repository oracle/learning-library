async function del(key) {
  let conn;

  try {
    conn = await oracledb.getConnection();

    const soda = conn.getSodaDatabase();

    const collection = await soda.openCollection('todos');

    let result;

    if (key) {
      result = await collection.find().key(key).remove();
    } else {
      result = await collection.find().filter({'completed': true}).remove();
    }

    return result.count >= 1;
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