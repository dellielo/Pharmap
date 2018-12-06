import loaded from './loaded'

const Axios = require('axios');
const axios = Axios.create({
    baseURL: 'http://localhost:8081',
    timeout: 5000,
});

async function query(queryString, props) {
        if (!loaded(props)) throw(Error('Not loaded'))
        return (await axios.post('/query', { query: queryString,
            username: props.username,
            password: props.password,
            endpoint: props.endpoint
        }, {timeout: 30000})).data
}

export { query }