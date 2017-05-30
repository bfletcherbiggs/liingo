import React from 'react';
import Navbar from '../../components/Navbar/Navbar';
import Footer from '../../components/Footer/Footer';

import rtbLenses from "../../../static/images/misc/rtb-lenses.gif"
import rtbDelight from "../../../static/images/misc/rtb-delight.gif"
import rtbShipping from "../../../static/images/misc/rtb-shipping.gif"

export default function Storefront( ) {
    return (
		<div>
			<Navbar/>

	<div className="full container hero">

		<div className="copy-container">
			<h2>
				Eloquent frames.<br/>
				Free prescription lenses.
			</h2>

			<div className="cta-container">
				<a className="orange-cta" href="/eyeglasses">
					GET SOME
				</a>
			</div>
		</div>

	</div>


	<div className="full container">

		<div className="container genders">

			<div className="row">

				<a href="eyeglasses/women">

					<div className="col-sm-6 col-md-6 col-lg-6 cat-hero cat-women bold">

						<div className="cat-header">
							Women
						</div>
						<div className="cat-subtext">
							LET'S DO SOME SHOPPING
						</div>

					</div>

				</a>

				<a href="eyeglasses/men">

					<div className="col-sm-6 col-md-6 col-lg-6 cat-hero cat-men bold">
						<div className="cat-header">
							Men
						</div>
						<div className="cat-subtext">
							LET'S SEE SOME GLASSES
						</div>
					</div>

				</a>

			</div>

		</div>

	</div>


	<div className="full container">

		<div className="container popular-frames">


			<div className="row">

				<h2 className="grey">Movers &amp; Shakers</h2>

			</div>

			<div className="pad-twenty"></div>

			<div className="category row">

					<div className="col-sm-4">

						<div className="frame-container short">

							<div className="hover-float">

					            <div className="frame-image-container">

					             	<a href="/eyeglasses/frame-details/ale-by-alessandra/600?color=Purple Tortoise">

						             	<img src="https://res.cloudinary.com/liingo/image/upload/c_fill,g_center,h_133,w_300/752499484556_2.jpg" width="300" height="133" className="pcp-frame-image"/>

						            </a>

					            </div>

				            </div>


				            <a href="/eyeglasses/frame-details/ale-by-alessandra/600?color=Purple Tortoise">

					            <div className="frame-name-container">

						            <div className="cat-main">ále by Alessandra</div>
									<div className="cat-secondary light"> 600 • $129.00</div>

						        </div>

					        </a>

					    </div>






					</div>


					<div className="col-sm-4">

						<div className="frame-container short">

							<div className="hover-float">

					            <div className="frame-image-container">

					             	<a href="/eyeglasses/frame-details/ernest-hemingway/4617?color=Black">

						             	<img src="https://res.cloudinary.com/liingo/image/upload/c_fill,g_center,h_133,w_300/754317146363_2.jpg" width="300" height="133" className="pcp-frame-image"/>

						            </a>

					            </div>

				            </div>


				            <a href="/eyeglasses/frame-details/ernest-hemingway/4617?color=Black">

					            <div className="frame-name-container">

						            <div className="cat-main">Ernest Hemingway</div>
									<div className="cat-secondary light"> 4617 • $99.00</div>

						        </div>

					        </a>

					    </div>






					</div>


					<div className="col-sm-4">

						<div className="frame-container short">

							<div className="hover-float">

					            <div className="frame-image-container">

					             	<a href="/eyeglasses/frame-details/esquire/1510?color=Olive Amber">

						             	<img src="https://res.cloudinary.com/liingo/image/upload/c_fill,g_center,h_133,w_300/754317178357_2.jpg" width="300" height="133" className="pcp-frame-image"/>

						            </a>

					            </div>

				            </div>


				            <a href="/eyeglasses/frame-details/esquire/1510?color=Olive Amber">

					            <div className="frame-name-container">

						            <div className="cat-main">Esquire</div>
									<div className="cat-secondary light"> 1510 • $129.00</div>

						        </div>

					        </a>

					    </div>






					</div>



			</div>

		</div>

	</div>


	<a href="/eyeglasses?brand-filter=ernest_hemingway">
		<div className="full container second-hero">


			<div className="cta-container">
				<a className="orange-cta" href="/eyeglasses/frame-details/ernest-hemingway/4612?color=leopard">
					SHOP NOW
				</a>
			</div>


		</div>
	</a>


	<div className="full container">

		<div className="container">

			<div className="rtb row">

				<div className="col-sm-4">

					<img src={ rtbLenses } width="80" height="60" />

					<h3>Free Prescription Lenses</h3>

					You worry about finding some great
					looking frames. We’ll take care of
					the lenses—for free.

					<br/>


				</div>

				<div className="col-sm-4">

					<img src={ rtbShipping } width="80" height="60" />

					<h3>Free Shipping & Returns</h3>

					Heaven forbid you don’t like your new
					specs, we’ll take ‘em back. For free.
					We’ll even pay for the shipping.

					<br/>


				</div>

				<div className="col-sm-4">

					<img src={ rtbDelight } width="80" height="60" />

					<h3>Satisfaction Guarantee</h3>

					If your glasses just aren’t quite
					perfect, we’ll get you some that
					you love, and make you happy as
					a clam.

					<br/>


				</div>

			</div>

		</div>

	</div>


	<div>
		<div className="full container">

		<div className="container">

			<div className="row">

				<div className="floating-headline">

					<h2 className="green"> Notes from our friends: </h2>

				</div>

			</div>

		</div>

	</div>
		<div className="full container greenbg">

		<div className="container greenbg">

			<div className="row testimonals">

				<div className="col-sm-4 testimonial">
					I recently had an eye exam and have major
					changes in my prescription. The glasses I
					selected at the doctor’s office were going
					to cost $600!  My friend recommended Liingo –
					I saved over $400 and I love my glasses!
					Thank you Liingo for a wonderful buying
					experience and for much better vision.<br/>
					<span className="dark">— Angela, Texas</span>
				</div>

				<div className="col-sm-4 testimonial">
					I had such a great experience with liingoeyewear.com!
					Their prices are amazing and their glasses are gorgeous.
					And they upgraded my lenses for free because my
					prescription is so bad. I will be recommending them
					to all my four-eyed friends.<br/>
					<span className="dark">— Marie, Utah</span>
				</div>

				<div className="col-sm-4 testimonial">
					Great experience. Great styles of glasses, easy
					process, AMAZING prices. I was a little concerned
					about quality because the prices were so low, but
					the quality is even better than my last glasses I
					paid over $300 for. I’m a very happy customer.<br/>
					<span className="dark">— Brandon, California</span>
				</div>

			</div>

		</div>

	</div>
	</div>
	<Footer/>
	</div>
    )
}
