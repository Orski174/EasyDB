import React from 'react';
import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Home from './pages/Home';
import ViewDB from './pages/ViewDB';
import InteractDB from './pages/InteractDB';
import Header from './Header';

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
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;