import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
//EXPORTED FUNCTIONS
// import { logout } from '../../ducks/authDuck';
//MATERIAL UI
// import { Toolbar, ToolbarGroup } from 'material-ui/Toolbar';
// import IconButton from 'material-ui/IconButton';
// import AddUser from 'material-ui/svg-icons/social/person-add';
// import { grey50 } from 'material-ui/styles/colors';
// import RaisedButton from 'material-ui/RaisedButton';
//CSS
import LiingoLogo from "../../../static/images/nav/liingo_logo.gif"
// import "./nav.css";


class Navbar extends Component{
    constructor(){
        super();

        this.handleClick = this.handleClick.bind( this )
    }

    handleClick( e ) {
        e.preventDefault();
        this.props.logout();
    }

    render(){

        return(
            <nav className="navbar navbar-default clear">
		        <div className="container">
		            <div className="navbar-header">

		                <a className="navbar-brand" href="/" style={{ zIndex: 1000000 }}>
		                    <img src={ LiingoLogo } alt="Liingo"/>
		                </a>

						<button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#app-navbar-collapse">
		                    <span className="sr-only">Toggle Navigation</span>
		                    <span className="icon-bar"></span>
		                    <span className="icon-bar"></span>
		                    <span className="icon-bar"></span>
		                </button>

		                <div className="visible-xs">

			                <ul className="utility-links mobile">

				                					                <li><a href="/cart" className="list"><div className="empty-cart-icon"></div></a></li>

				                <li>
				                	<a href="/account" className="list">
					            	    <div className="account-icon"></div>
					               	</a>
					            </li>

			                </ul>

		                </div>

		            </div>

		            <div className="collapse navbar-collapse" id="app-navbar-collapse">

		                <ul className="nav navbar-nav navbar-left">
			                <li><a href="/eyeglasses/women" className="list">WOMEN</a></li>
			                <li><a href="/eyeglasses/men" className="list">MEN</a></li>


			                <li><a href="/eyeglasses" className="list">SHOP ALL</a></li>

			                <li className="dropdown">

						          <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">BRANDS</a>

						          <ul className="dropdown-menu">
						            <li><a href="#">Ernest Hemingway</a></li>
						            <li><a href="#">Enhance</a></li>
						            <li><a href="#">Ampersé</a></li>
						            <li><a href="#">Ludius</a></li>
						            <li><a href="#">Draco</a></li>
						          </ul>

					        </li>


			                <li><a href="/our-lenses" className="list">LENSES</a></li>
			                <li><a href="/about-us" className="list">ABOUT</a></li>

		                </ul>

		                <div className="hidden-xs">
			                 <ul className="nav navbar-nav navbar-right utility-links">
				                <li><a href="/account" className="list"><div className="account-icon"></div></a></li>
				                <li><a href="/cart" className="list"><div className="empty-cart-icon"></div></a></li>
				                			                </ul>
			            </div>


		            </div>

		        </div>
		    </nav>
        )
    }
};

const mapStateToProps = state => state;

export default connect( mapStateToProps, {  })( Navbar );
