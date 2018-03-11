import React from 'react';
import Slider from 'react-slick';
import PropTypes from 'prop-types';
import "./Carousel.css"


class Carousel extends React.Component {
	constructor(props) {
        super(props);
//        /this.state = cloneDeep({x: props.x, y: props.y});
    }
	
	componentWillReceiveProps(nextProps) {
        this.props = nextProps;
    }
	
  render() {
    var settings = {
      dots: true,
      infinite: true,
      speed: 100,
	  autoplay: true,
      slidesToShow: 1,
      slidesToScroll: 1
    };
	let imageToShow;
	if (this.props.img) {
		console.log(this.props.img)
		imageToShow = this.props.img.map(function(imgSrc, index) {
			return (<div key={index}><img className="slideshow-image" src={imgSrc} alt="HackUVIC2018"></img></div>)
		});
	 }
	return (
		<Slider {...settings}>
			{imageToShow}
		</Slider>
	);
  }
}

Carousel.propTypes = {
	img: PropTypes.array
}

export default Carousel;