import React from 'react';
import PropTypes from 'prop-types';
import axios from "axios";
import "./Verify.css"
import serverURL from "./Const.js"

class Verify extends React.Component {
	constructor(props) {
		super(props);
	}
	
	componentWillReceiveProps(nextProps) {
        this.props = nextProps;
    }
	
  render() {
	return (
		<div className="verification-code-grid">
			<div className="verification-code-display">
				<h1>Verification Code</h1>
				<h2>{this.props.code}</h2>
			</div>
		</div>
	);
  }
}

Verify.propTypes = {
	code: PropTypes.string
}

export default Verify;