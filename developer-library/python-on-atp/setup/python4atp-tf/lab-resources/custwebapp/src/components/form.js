// Python-ATP Workshop version 2.0.

// Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


import React, { Component } from "react";
import {
  Alert,
  Container,
  Col,
  Button,
  Form,
  FormGroup,
  Label,
  Input
} from "reactstrap";
import "./form.css";
import ReactDOM from "react-dom";

const numberRegex = RegExp(/^\d+$/);

const formValid = ({ formErrors, ...rest }) => {
  let valid = true;

  // validate form errors being empty
  Object.values(formErrors).forEach(val => {
    val.length > 0 && (valid = false);
  });

  // validate the form was filled out
  Object.values(rest).forEach(val => {
    val === null && (valid = false);
  });

  return valid;
};

class CustomerForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      CUST_ID: Number,
      FIRST_NAME: null,
      LAST_NAME: null,
      AGE: null,
      STREET_ADDRESS: "",
      POSTAL_CODE: "",
      CITY: "",
      STATE_PROVINCE: "",
      COUNTRY: "",
      SEG: 1,
      Notification: false,
      formErrors: {
        CUST_ID: "",
        FIRST_NAME: "",
        lastName: "",
        AGE: "",
        STREET_ADDRESS: "",
        POSTAL_CODE: "",
        CITY: "",
        STATE_PROVINCE: "",
        COUNTRY: ""
      }
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleAddressChange = this.handleAddressChange.bind(this);
    this.handleCityChange = this.handleCityChange.bind(this);
    this.handleStateChange = this.handleStateChange.bind(this);
    this.handleCountryChange = this.handleCountryChange.bind(this);
  }

  handleChange(event) {
    const { name, value } = event.target;
    let formErrors = this.state.formErrors;

    switch (name) {
      case "FIRST_NAME":
        formErrors.FIRST_NAME =
          value.length < 3 && value.length > 0
            ? "minimum 3 charasters required"
            : "";
        break;
      case "LAST_NAME":
        formErrors.lastName =
          value.length < 3 && value.length > 0
            ? "minimum 3 charasters required"
            : "";
        break;
      case "AGE":
        formErrors.AGE = numberRegex.test(value) ? "" : "Invalid age";
        break;
      case "POSTAL_CODE":
        formErrors.POSTAL_CODE = numberRegex.test(value)
          ? ""
          : "Invalid postal code";
        break;
      case "CUST_ID":
        formErrors.CUST_ID = numberRegex.test(value) ? "" : "Invalid ID code";
        break;
    }
    this.setState({ formErrors, [name]: value }, () => console.log(this.state));
  }

  handleAddressChange(event) {
    this.setState({ STREET_ADDRESS: event.target.value });
  }

  handleCityChange(event) {
    this.setState({ CITY: event.target.value });
  }
  handleStateChange(event) {
    this.setState({ STATE_PROVINCE: event.target.value });
  }
  handleCountryChange(event) {
    this.setState({ COUNTRY: event.target.value });
  }

  handleSubmit(event) {
    console.log(this.state);
    event.preventDefault();

    const {
      CUST_ID,
      FIRST_NAME,
      LAST_NAME,
      AGE,
      POSTAL_CODE,
      STREET_ADDRESS,
      CITY,
      STATE_PROVINCE,
      COUNTRY,
      SEG
    } = this.state;
    var jsonValues = {
      CUST_ID: CUST_ID,
      FIRST_NAME: FIRST_NAME,
      LAST_NAME: LAST_NAME,
      AGE: AGE,
      STREET_ADDRESS: STREET_ADDRESS,
      POSTAL_CODE: POSTAL_CODE,
      CITY: CITY,
      STATE_PROVINCE: STATE_PROVINCE,
      COUNTRY: COUNTRY,
      SEG: SEG
    };

    var url = "http://127.0.0.1:5001/customers/" + this.state.CUST_ID;
    console.log(url);
    fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(jsonValues)
    })
      .then(response => {
        console.log("RESPONSE", response);
        this.setState({ Notification: true });
        return <Notification />;
      })
      .catch(error => {
        console.log(error);
      });
  }

//   fetchCall(){
      
//   }

  render() {
    const { formErrors } = this.state;
    return (
      <div>
        {this.state.Notification ? <Notification/> : (
          ""
        )}
        <Container>
          <h1 className="formHeader">Enter customer info to ATP database</h1>
          <Form onSubmit={this.handleSubmit}>
            <FormGroup row>
              <Label for="exampleEmail" sm={2}>
                Customer ID:
              </Label>
              <Col sm={10}>
                <Input
                  required
                  type="number"
                  name="CUST_ID"
                  value={this.state.CUST_ID}
                  onChange={this.handleChange}
                />
                {formErrors.CUST_ID.length > 0 && (
                  <span className="errorMessage">{formErrors.CUST_ID}</span>
                )}
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>First Name:</Label>
              <Col sm={10}>
                <Input
                  className={formErrors.FIRST_NAME.length > 0 ? "error" : null}
                  type="text"
                  value={this.state.FIRST_NAME}
                  name="FIRST_NAME"
                  onChange={this.handleChange}
                />
                {formErrors.FIRST_NAME.length > 0 && (
                  <span className="errorMessage">{formErrors.FIRST_NAME}</span>
                )}
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>Last Name:</Label>
              <Col sm={10}>
                <Input
                  className={formErrors.lastName.length > 0 ? "error" : null}
                  type="text"
                  name="LAST_NAME"
                  value={this.state.LAST_NAME}
                  onChange={this.handleChange}
                />
                {formErrors.lastName.length > 0 && (
                  <span className="errorMessage">{formErrors.lastName}</span>
                )}
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>Age:</Label>
              <Col sm={10}>
                <Input
                  type="number"
                  name="AGE"
                  value={this.state.AGE}
                  onChange={this.handleChange}
                />
                {formErrors.AGE.length > 0 && (
                  <span className="errorMessage">{formErrors.AGE}</span>
                )}
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>Street Adress:</Label>
              <Col sm={10}>
                <Input
                  type="text"
                  value={this.state.STREET_ADDRESS}
                  onChange={this.handleAddressChange}
                />
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>Postal code:</Label>
              <Col sm={10}>
                <Input
                  type="number"
                  name="POSTAL_CODE"
                  value={this.state.POSTAL_CODE}
                  onChange={this.handleChange}
                />
                {formErrors.POSTAL_CODE.length > 0 && (
                  <span className="errorMessage">{formErrors.POSTAL_CODE}</span>
                )}
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>City Name:</Label>
              <Col sm={10}>
                <Input
                  type="text"
                  value={this.state.CITY}
                  onChange={this.handleCityChange}
                />
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>State Name:</Label>
              <Col sm={10}>
                <Input
                  type="text"
                  value={this.state.STATE_PROVINCE}
                  onChange={this.handleStateChange}
                />
              </Col>
            </FormGroup>
            <FormGroup row>
              <Label sm={2}>Country Name:</Label>
              <Col sm={10}>
                <Input
                  type="text"
                  value={this.state.COUNTRY}
                  onChange={this.handleCountryChange}
                />
              </Col>
            </FormGroup>
            {formValid(this.state) ? (
              <Button
                type="submit"
                outline
                color="primary"
                size="lg"
                block
                className="submitButton"
              >
                Submit
              </Button>
            ) : (
              <Button
                type="submit"
                size="lg"
                block
                className="submitButton"
                disabled
              >
                Submit
              </Button>
            )}
          </Form>
        </Container>
      </div>
    );
  }
}

const Notification = () => {
  return <Alert color="success">successfully entered row in database</Alert>;
};

export default CustomerForm;
