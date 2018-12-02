const mapStateToProps = state => {
    return {
        ...state,
    }
};

const mapDispatchToProps = dispatch => {
    return {
        updateInfo: (data) => {
            dispatch({ type: "UPDATE", username: data.username, password: data.password, endpoint: data.endpoint})
        }
    }
}

export { mapStateToProps , mapDispatchToProps };