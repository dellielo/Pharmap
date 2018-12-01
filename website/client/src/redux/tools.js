const mapStateToProps = state => {
    console.log(state)
    return {
        neo: state,
    }
};

const mapDispatchToProps = dispatch => {
    return {
        updateNeo: (session, driver) => {
            console.log('updating: ', session, driver)
            dispatch({ type: "UPDATE", session, driver})
        }
    }
}

export { mapStateToProps , mapDispatchToProps };