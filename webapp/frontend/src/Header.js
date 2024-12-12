import React from 'react';
import { NavLink } from 'react-router-dom';
import './Header.css'; // Create a CSS file for styling the header

function Header() {
  return (
    <header className="App-header">
      <nav>
        <ul className="nav-list">
          <li>
            <NavLink to="/" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}>
              Home
            </NavLink>
          </li>
          <li>
            <NavLink to="/view-db" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}>
              View Database
            </NavLink>
          </li>
          <li>
            <NavLink to="/interact-db" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}>
              Interact with Database
            </NavLink>
          </li>
          <li>
            <NavLink to="/Logistics" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}>
              Logistics
            </NavLink>
          </li>
          <li>
            <NavLink to="/Transactions" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}>
              Transactions
            </NavLink>
          </li>
          <li>
            <NavLink to="/query" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}>
              Query
            </NavLink>
          </li>
        </ul>
      </nav>
    </header>
  );
}

export default Header;