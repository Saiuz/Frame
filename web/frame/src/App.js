import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Carousel from './Carousel.js';
import Verify from './Verify.js';
import axios from 'axios';
import serverURL from "./Const.js";

class App extends Component {
	constructor() {
		super();
		
		// Mode can be "photos" or "verify"
		
		this.state = {mode: "verify", code: "9991"};
		let refreshInterval = 10000;
		this.getMode();
		let modeUpdate = setInterval(this.getMode.bind(this), refreshInterval);
	}
	
	getMode() {
		axios.get(serverURL + "/get_mode?code="+this.state.code)
		.then(response => {
            console.log(response);
            this.setState({ mode: response.data });
        }).catch(response => {
            // Do nothing if no server found.
        });
	}
	
  render() {
	let widget;
	if (this.state.mode == "photos") {
		widget = <Carousel mode={this.state.mode} code={this.state.code}/>
	} else if (this.state.mode == "verify") {
		widget = <Verify mode={this.state.mode} code={this.state.code}/>
	} else {
		widget = <div></div>
	}
	  
    return (
      <div className="App">
         {widget}
      </div>
    );
  }
}

export default App;
