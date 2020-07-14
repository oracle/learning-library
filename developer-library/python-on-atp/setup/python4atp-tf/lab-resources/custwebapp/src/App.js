// Python-ATP Workshop version 2.0.

// Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


import React,{Component} from "react";
import logo from "./logo.svg";
import "./App.css";

import CustomerForm from "./components/form";
import HeaderNav from "./components/header";
import Customer from "./components/customer"
import { BrowserRouter, Route, Switch, Link, NavLink } from 'react-router-dom';

const App = () => (
  <BrowserRouter>
    <div>
    <HeaderNav />
      <Switch>
        <Route path="/" component={Customer} exact={true} />
        <Route path="/create" component={CustomerForm} />
        {/* <Route component={NotFoundPage} /> */}
      </Switch>
    </div>
  </BrowserRouter>
);

export default App;
