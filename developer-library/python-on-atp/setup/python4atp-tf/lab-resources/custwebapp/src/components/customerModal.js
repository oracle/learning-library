// Python-ATP Workshop version 2.0.

// Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


import React from "react";
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from "reactstrap";

var regex = /^[a-zA-Z ]*$/;

const formValid = ({ formErrors, ...rest }) => {
  let valid = true;

  // validate form errors being empty
  Object.values(formErrors).forEach(val => {
    val.length > 0 && (valid = false);
  });

  return valid;
};

class ModalExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modal: false,
      firstName: null,
      country: "",
      formErrors: {
        country: ""
      }
    };

    this.toggle = this.toggle.bind(this);
  }

  toggle() {
    this.setState(prevState => ({
      modal: !prevState.modal
    }));
  }

  handleSave() {
    this.toggle();
    var item = this.state.country;
    this.props.newCountry(item);
  }

  msgHandler(e) {
    let formErrors = this.state.formErrors;
    formErrors.country = regex.test(e.target.value) ? "" : "Invalid name";
    this.setState({ formErrors, country: e.target.value });
    console.log(this.state.country);
  }

  render() {
    const { formErrors } = this.state;
    return (
      <div>
        <Button outline color="primary" onClick={this.toggle}>
          Edit
        </Button>
        <Modal
          isOpen={this.state.modal}
          toggle={this.toggle}
          className={this.props.className}
        >
          <ModalHeader toggle={this.toggle}>
            <h5 className="modal-title" id="exampleModalLabel">
              {this.props.title}
            </h5>
          </ModalHeader>
          <ModalBody>
            <p>
              <span className="modal-lable">Country:</span>
              <input onChange={e => this.msgHandler(e)} />
              {formErrors.country.length > 0 && (
                <span className="errorMessage">{formErrors.country}</span>
              )}
            </p>
          </ModalBody>
          <ModalFooter>
            <button
              type="button"
              className="btn btn-secondary"
              onClick={this.toggle}
            >
              Close
            </button>
            {formValid(this.state) ? (
              <button
                type="button"
                className="btn btn-primary"
                data-dismiss="modal"
                onClick={() => {
                  this.handleSave();
                }}
              >
                Save changes
              </button>
            ) : (
              <button disabled> Save changes</button>
            )}
          </ModalFooter>
        </Modal>
      </div>
    );
  }
}

export default ModalExample;
