import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Carousel from './Carousel.js';
import Verify from './Verify.js';
import axios from 'axios';

class App extends Component {
	constructor() {
		super();
		
		// Mode can be "photos" or "verify"
		
		this.state = {images: [], mode: "verify"};
		let refreshInterval = 10000;
		
		//let modeUpdate = setInterval(this.getImages.bind(this), refreshInterval);
		//let imgUpdate = setInterval(this.getImages.bind(this), refreshInterval);
	}
	
	getMode() {
		axios.get("http://localhost/mode").then(response => {
            console.log(response);
            this.setState({ mode: response.data });
        }).catch(response => {
            // Do nothing if no server found.
        });
	}
	
	getImages() {
		axios.get("http://localhost").then(response => {
            console.log(response);
            this.setState({ images: response.data.images });
        }).catch(response => {
            // Do nothing if no server found.
        });
	}
	
  render() {
	let widget;
	if (this.state.mode == "photos") {
		widget = <Carousel img={this.state.images}/>
	} else if (this.state.mode == "verify") {
		widget = <Verify/>
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
