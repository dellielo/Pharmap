import {createStore} from 'redux'

const defaultstate = {username: null, password: null, endpoint: null}

export const neo4jReducer = (state = defaultstate, action) => {
    switch (action.type) {
        case "UPDATE":
            return {
                username: action.username || state.username,
                password: action.password || state.password,
                endpoint: action.endpoint || state.endpoint
            };
        case "RESET":
            return defaultstate;
        default:
            return state
    }
};

const store = createStore(neo4jReducer);

export default store