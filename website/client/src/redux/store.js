import {createStore} from 'redux'

const defaultstate = {session: null, driver: null}

export const neo4jReducer = (state = defaultstate, action) => {
    switch (action.type) {
        case "UPDATE":
            return {session: action.session, driver: action.driver};
        case "RESET":
            return defaultstate;
        default:
            return state
    }
};

const store = createStore(neo4jReducer);

export default store