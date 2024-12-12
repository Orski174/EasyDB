import React from 'react';
import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Home from './pages/Home';
import ViewDB from './pages/ViewDB';
import InteractDB from './pages/InteractDB';
import Logistics from './pages/Logistics';
import Transactions from './pages/Transactions';
import Header from './Header';
import Query from './pages/Query';



function App() {
  return (
    <Router>
      <div className="App">
        <Header />
        <main>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/view-db" element={<ViewDB />} />
            <Route path="/interact-db" element={<InteractDB />} />
            <Route path="/Logistics" element={<Logistics />} />
            <Route path="/Transactions" element={<Transactions />} />
            <Route path="/query" element={<Query />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;