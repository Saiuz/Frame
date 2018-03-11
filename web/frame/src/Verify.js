import React from 'react';
import PropTypes from 'prop-types';
import axios from "axios";
import "./Verify.css"

class Verify extends React.Component {
	constructor() {
		super();

		this.state = {code: ""};
		let refreshInterval = 10000;
		
		let codeUpdate = setInterval(this.getCode.bind(this), refreshInterval);
	}
	
	getCode() {
		axios.get("http://localhost:8080/code").then(response => {
            console.log(response);
            this.setState({ code: response.data });
        }).catch(response => {
            // Do nothing if no server found.
        });
	}
	
  render() {
	return (
		<div className="verification-code-grid">
			<div className="verification-code-display">
				<h1>Verification Code</h1>
				<h2>{this.state.code}</h2>
			</div>
		</div>
	);
  }
}

Verify.propTypes = {
	code: PropTypes.object
}

export default Verify;