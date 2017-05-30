import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { BrowserRouter, Route } from 'react-router-dom';
import store from './store';
import App from './containers/App/App';
// import style from '../css/application.sass'

ReactDOM.render(
    <BrowserRouter>
        <Provider store={ store }>
            <Route path="/" component={ App } />
        </Provider>
    </BrowserRouter>,
    document.getElementById( 'site-wrapper' )
);
