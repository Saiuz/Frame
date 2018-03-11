import React from 'react';
import Slider from 'react-slick';
import Loading from "./Loading.js"
import PropTypes from 'prop-types';
import "./Carousel.css"
import axios from "axios";


class Carousel extends React.Component {
	constructor(props) {
        super(props);
		this.state = { loadedItems: [], images: []}
		let refreshInterval = 10000;
		this.getImages();
		
		let imgUpdate = setInterval(this.getImages.bind(this), refreshInterval);
    }
	
	componentWillReceiveProps(nextProps) {
        this.props = nextProps;
    }
	
	onLoad(feedItem) {
		console.log("Got Image!")
		this.setState(({ loadedItems }) => {
      		return { loadedItems: loadedItems.concat(feedItem) }
    	})
	}
	
	getImages() {
		if (this.state.loadedItems.length != this.state.images.length) {
			console.log("Not done downloading last batch!")
			return;
		}
		axios.get("http://localhost:8080/get_images").then(response => {
            console.log(response);
            this.setState({ images: response.data.images/*, loadedItems: []*/ });
        }).catch(response => {
            // Do nothing if no server found.
        });
	}
	
  render() {
    var settings = {
      dots: true,
      infinite: true,
      speed: 500,
	  autoplay: true,
	  autoplaySpeed: 9000,
      slidesToShow: 1,
      slidesToScroll: 1
    };
	let imageToShow;
	if (this.state.loadedItems) {
		imageToShow = this.state.loadedItems.map(function(imgSrc, index) {
			return (<div key={index}><img className="slideshow-image" src={imgSrc} alt="HackUVIC2018"></img></div>)
		});
	 }
	  if (!this.state.loadedItems || this.state.loadedItems.length <= 1) {
		  return (<div className="App">
				  	<div className="hidden">
						{this.state.images.map((imgSrc, index) => 
					<img src={imgSrc} onLoad={this.onLoad.bind(this, imgSrc)} key={index}></img>
					)}
					</div>
				  </div>
				 );
	  } else {
		  return (
				<div className="carousel">
					<div className="hidden">
						{this.state.images.map((imgSrc, index) => 
					<img src={imgSrc} onLoad={this.onLoad.bind(this, imgSrc)} key={index}></img>
					)}
					</div>
				<Slider {...settings}>
					{imageToShow}
				</Slider>
			</div>
		);
	  }
	
  }
}

Carousel.propTypes = {
	img: PropTypes.array
}

export default Carousel;