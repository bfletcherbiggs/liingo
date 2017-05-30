import { applyMiddleware, createStore } from 'redux';
import thunkMiddleware from 'redux-thunk';
import reducer from './reducers/reducer';

const store = createStore( reducer, undefined, applyMiddleware( thunkMiddleware ) );

export default store;
