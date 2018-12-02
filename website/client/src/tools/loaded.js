export default props => {
    return props.username && props.password && props.endpoint ? true : false
}