import React, { Component } from "react";
import { NavLink as RRNavLink } from "react-router-dom";
import {
  Nav,
  NavItem,
  Dropdown,
  DropdownItem,
  DropdownToggle,
  DropdownMenu,
  NavLink,
  Container
} from "reactstrap";
import  mainLogo from '../assets/product.png';
import "./form.css";

class HeaderNav extends Component {
  constructor(props) {
    super(props);

    this.toggle = this.toggle.bind(this);
    this.state = {
      dropdownOpen: false
    };
  }

  toggle() {
    this.setState({
      dropdownOpen: !this.state.dropdownOpen
    });
  }

  render() {
    return (
      <div>
      <Container>
      <img src={mainLogo} className="navImage" alt="fireSpot"/>
        <Nav pills>
          <NavItem>
            <NavLink tag={RRNavLink} exact activeClassName="active" to="/">
              Search
            </NavLink>
          </NavItem>
          <NavItem>
            <NavLink tag={RRNavLink} activeClassName="active" to="/create">
              Create customer
            </NavLink>
          </NavItem>
        </Nav>
        </Container>
      </div>
    );
  }
}

export default HeaderNav;
