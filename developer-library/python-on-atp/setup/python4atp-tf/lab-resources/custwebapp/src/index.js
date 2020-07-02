// Python-ATP Workshop version 2.0.

// Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


import React from 'react';
import ReactDOM from 'react-dom';
// import './index.css';
import 'bootstrap/dist/css/bootstrap.css';
import App from './App';
import * as serviceWorker from './serviceWorker';

ReactDOM.render(<App />, document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
