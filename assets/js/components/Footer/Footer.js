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
import FooterLogo from "../../../static/images/footer/footer-logo.gif"
// import "./nav.css";


class Footer extends Component{
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
			<div>
			<div className="full container">
			   <div style={{"backgroundColor": "white", "height": 5+"px" }}></div>
		   </div>

		   <div id="footer">

			   <div className="full container">

				   <div className="container">


					   <div className="row">

						   <div className="col-xs-12 col-sm-4 mobile-center">

							   <img src={ FooterLogo }/>

						   </div>

						   <div className="col-xs-12 mobile-center col-sm-8">

							   <div className="visible-xs pad-twenty"></div>

							   <div className="col-sm-5 social-list">

								   <a target="_blank" href="https://www.facebook.com/liingoeyewear">
									   <div className="social-footer facebook"></div>
								   </a>

								   <a target="_blank" href="https://www.instagram.com/liingoeyewear/">
									   <div className="social-footer instagram"></div>
								   </a>

								   <a target="_blank" href="https://twitter.com/liingoeyewear/">
									   <div className="social-footer twitter"></div>
								   </a>

								   <a target="_blank" href="https://www.pinterest.com/liingoeyewear/">
									   <div className="social-footer pinterest"></div>
								   </a>

							   </div>

							   <div id="signup-container-thanks" className="col-sm-7 no-padding">

								   Thanks!  Now watch for some sweet content!

							   </div>

							   <div id="signup-container" className="col-sm-7 no-padding">

								   <div className="visible-xs pad-thirty"></div>

								   <div className="col-sm-7 no-padding">

									   <input type="text" placeholder="EMAIL ADDRESS" name="newsletter-email" id="newsletter-email" className="col-xs-12 col-sm-12"/>

								   </div>

								   <div className="col-sm-4 no-padding">

									   <div className="visible-xs pad-ten"></div>

									   <input type="button" value="sign up" className="teal" onclick="submitNewsletterForm();"/>

								   </div>

							   </div>

						   </div>

					   </div>

					   <div className="row pad-thirty"></div>

					   <div className="row">

						   <div className="col-sm-5">

							   <div className="col-sm-12 no-padding-left mobile-center">

								   <span className="footer-headline">
									   Contact
								   </span>

								   <br/>

								   <a href="mailto:hello@liingoeyewear.com">hello@liingoeyewear.com</a>

								   <br/>

								   <a href="/faq">Help</a>

							   </div>

						   </div>

						   <div className="col-sm-7 mobile-center">

							   <div className="visible-xs pad-thirty"></div>

							   <div className="col-sm-4">

								   <span className="footer-headline">
									   Glasses
								   </span>
								   <br/>
								   <a href="/eyeglasses">Shop All Eyeglasses</a><br/>
								   <a href="/eyeglasses/women">Women's Eyeglasses</a><br/>
								   <a href="/eyeglasses/men">Men's Eyeglasses</a><br/>


							   </div>

							   <div className="col-sm-4 mobile-center">

								   <div className="visible-xs pad-thirty"></div>

								   <span className="footer-headline">
									   Account
								   </span><br/>


									   <a href="/register">Register</a><br/>
									   <a href="/login">Log In</a><br/>

							   </div>

							   <div className="col-sm-4">

								   <div className="visible-xs pad-thirty"></div>

								   <span className="footer-headline">
									   About
								   </span><br/>

								   <a href="/about-us">The Liingo Eyewear Story</a><br/>
								   <a href="/contact-us">Contact Us</a><br/>
								   <a href="/our-lenses">Our Prescription Lenses</a><br/>
								   <a href="/privacy-policy">Privacy Policy</a><br/>
								   <a href="/terms-of-use">Terms of Use</a><br/>

							   </div>

						   </div>

					   </div>

					   <div className="row pad-fifty"></div>

					   <div className="row">

						   <div className="col-sm-12 mobile-center">
							   <span className="white">
								   &copy;2017 Liingo Eyewear<br/>
								   All Rights Reserved
							   </span>
						   </div>

					   </div>


				   </div>
			   </div>
		   </div>


	   </div>
        )
    }
};

const mapStateToProps = state => state;

export default connect( mapStateToProps, {  })( Footer );
