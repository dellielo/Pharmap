const neo4j = require('neo4j-driver').v1;

export default (endPoint, username, password) => {
    const driver = neo4j.driver(endPoint, neo4j.auth.basic(username, password));
    const session = driver.session();
    return {session, driver}

    //const personName = 'Alice';
    //const resultPromise = session.run(
    //    'CREATE (a:Person {name: $name}) RETURN a',
    //    { name: personName }
    //);
    //resultPromise.then(result => {
    //    const singleRecord = result.records[0];
    //    const node = singleRecord.get(0);
    //    console.log(node.properties.name);
    //    // on application exit:
    //    driver.close();
    //});
}