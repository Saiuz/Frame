import React from 'react';
import Slider from 'react-slick';
import PropTypes from 'prop-types';

class Carousel extends React.Component {
	
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
	if (this.props.images) {
		imageToShow = this.props.images.map(img => {
			return (<div><img src={img.src} alt={img.alt}></img></div>)
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