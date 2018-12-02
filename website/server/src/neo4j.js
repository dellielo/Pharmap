const neo4j = require('neo4j-driver').v1;

module.exports = (endPoint, username, password) => {
    const driver = neo4j.driver(endPoint, neo4j.auth.basic(username, password));
    const session = driver.session();
    return {session, driver}
}