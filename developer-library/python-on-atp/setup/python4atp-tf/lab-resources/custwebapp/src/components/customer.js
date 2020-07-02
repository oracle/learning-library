// Python-ATP Workshop version 2.0.

// Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

import React, { Component } from "react";
import ModalExample from "./customerModal";
import {
  Alert,
  Container,
  Col,
  Button,
  Form,
  FormGroup,
  Label,
  Input,
  FormText,
  Row,
  Table
} from "reactstrap";
import "./form.css";

const numberRegex = RegExp(/^\d+$/);

const formValid = ({ formErrors, ...rest }) => {
  let valid = true;

  // validate form errors being empty
  Object.values(formErrors).forEach(val => {
    val.length > 0 && (valid = false);
  });

  return valid;
};

export default class Customer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      cust_Id: null,
      response: null,
      isLoading: true,
      error: "Please enter valid customer ID",
      country: null,
      showToast:false,
      formErrors: {
        search: ""
      }
    };
    // this.toggle = this.toggle.bind(this);
    this.handleInputChange = this.handleInputChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.newCountry = this.newCountry.bind(this);
    this.fetchCall = this.fetchCall.bind(this);
  }

  handleInputChange(event) {
    let formErrors = this.state.formErrors;
    formErrors.search = numberRegex.test(event.target.value)
      ? ""
      : "Invalid Cust Id";
    this.setState({ formErrors, cust_Id: event.target.value }, () =>
      console.log(this.state)
    );
  }

  async handleSubmit(e) {
    e.preventDefault();

    if (formValid(this.state)) {
      console.log("Valid");
      await this.fetchCall();
    } else {
      console.error("Form Invalid");
    }
  }

  async fetchCall() {
    const API = "http://127.0.0.1:5001/customers/";
    console.log(this.state.cust_Id);
    await fetch(API + this.state.cust_Id)
      .then(response => {
        if (response.ok) {
            this.setState({
              showToast:false
            })
          return response.json();
        
        } else {
            this.setState({
                showToast:true
              })
          throw new Error("Something went wrong ...");
          
        }
      })
      .then(data => this.setState({ response: data, isLoading: false }))
      .catch(error => console.log(error));
  }

  async newCountry(item) {
    if (item) {
      console.log("Country", item);
      await this.setState({ country: item });
      const { cust_Id, country } = this.state;
      var jsonValues = { COUNTRY: country };
      console.log(jsonValues);
      var url = "http://127.0.0.1:5001/customers/" + cust_Id;
      await fetch(url, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(jsonValues)
      })
        .then(response => {
          this.fetchCall();
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    }
  }

  render() {
    const { formErrors } = this.state;

    return (
      <div>
       {this.state.showToast ? <Notification/> : (
          ""
        )}
        <Container>
        <h1 className="formHeader">Customer Lookup</h1>
          <Form onSubmit={this.handleSubmit}>
            <FormGroup>
              <Input
                placeholder="Please enter Customer ID to search..."
                onChange={this.handleInputChange}
              />
              {formErrors.search.length > 0 && (
                <span className="errorMessage">{formErrors.search}</span>
              )}
              <FormGroup>
                <p> {this.state.query} </p>
              </FormGroup>
            </FormGroup>
            <FormGroup>
              <Button  outline color="primary" type="submit"> Search </Button>
            </FormGroup>
          </Form>
          {this.state.response ? (
            <div>
              <h1 className="formHeader">Customer Info</h1>
              <br />
              <Row>
                <Col sm={{ size: "auto" }}>
                  <h2>{this.state.response.FIRST_NAME}</h2>
                </Col>
                <Col sm={{ size: "auto" }}>
                  <h2>{this.state.response.LAST_NAME}</h2>
                </Col>
              </Row>
              <Table striped>
                <thead>
                  <tr>
                    <th>Details</th>
                    <th>Value</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">Street Adress</th>
                    <td>{this.state.response.STREET_ADDRESS}</td>
                  </tr>
                  <tr>
                    <th scope="row">City Name</th>
                    <td>{this.state.response.CITY}</td>
                  </tr>
                  <tr>
                    <th scope="row">State Name</th>
                    <td>{this.state.response.STATE_PROVINCE}</td>
                  </tr>
                  <tr>
                    <th scope="row">Country</th>
                    <td>{this.state.response.COUNTRY}</td>
                    <ModalExample
                      title={this.state.response.FIRST_NAME}
                      country={this.state.response.COUNTRY}
                      newCountry={this.newCountry}
                    />
                  </tr>
                  <tr>
                    <th scope="row">Age</th>
                    <td>{this.state.response.AGE}</td>
                  </tr>
                  <tr>
                    <th scope="row">No. of pets</th>
                    <td>{this.state.response.PET}</td>
                  </tr>
                  <tr>
                    <th scope="row">Income</th>
                    <td>{this.state.response.INCOME}</td>
                  </tr>
                </tbody>
              </Table>
            </div>
          ) : (
            <div>
             
             
            </div>
          )}
        </Container>
      </div>
    );
  }
}
const Notification = () => {
    return <Alert color="danger">No customer found</Alert>;
  };
