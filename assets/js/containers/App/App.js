import React, {Component} from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';
import { connect } from 'react-redux';
//CONTAINERS
import Storefront from '../Storefront/Storefront';
// import AdminPage from '../AdminPage/AdminPage';

class App extends Component{

    render(){

        // const PrivateRoute = ( { component: Component, ...rest } ) => (
        //     <Route {...rest} render={props => (
        //         isAuthenticated?
        //         <Component { ...props }/>
        //         : <Redirect to="/"/>
        //     )}/>
        // )

        return (
            // <div className="app">
                <Switch>
                    <Route exact path="/" component={ Storefront }/>
                    {/* <Route path="/admin" component={ AdminPage }/> */}
                </Switch>
            // </div>
        )
    }
}


const mapStateToProps = state => state

export default connect( mapStateToProps, { } )( App );
