import React from 'react';
import PropTypes from 'prop-types';
import "./Verify.css"

class Loading extends React.Component {
	constructor(props) {
        super(props);
		
    }
	
	componentWillReceiveProps(nextProps) {
        this.props = nextProps;
    }
	
	
  render() {
    return (
		<div className="loading-grid">
			<div className="loading-display">
				<p>Loading</p>
				<progress value={this.props.value} max={this.props.max}></progress>
			</div>
		</div>
	);
  }
}

Loading.propTypes = {
	img: PropTypes.array
}

export default Loading;