from neo4j import GraphDatabase


class dbDriver(object):

    def __init__(self, uri, user, password):
        self._driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self._driver.close()

    def add_node(self, message):
        with self._driver.session() as session:
            greeting = session.write_transaction(self._create_node, message)
            print(greeting)

    @staticmethod
    def _create_node(tx, message):
        result = tx.run(message)
