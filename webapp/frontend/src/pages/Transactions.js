import React, { useState, useEffect } from 'react';
import axios from 'axios';

function Transactions() {
  const [activeTab, setActiveTab] = useState('Machines');
  const [showModal, setShowModal] = useState(false);
  const [transactions, setTransactions] = useState([]);
  const [formData, setFormData] = useState({});
  const [notification, setNotification] = useState('');

  useEffect(() => {
    const fetchTransactions = async () => {
      let endpoint = '';
      switch (activeTab) {
        case 'Machines':
          endpoint = 'http://localhost:5000/api/machine_trans';
          break;
        case 'Equipment':
          endpoint = 'http://localhost:5000/api/equip_trans';
          break;
        case 'Product':
          endpoint = 'http://localhost:5000/api/product_trans';
          break;
        case 'Materials':
          endpoint = 'http://localhost:5000/api/material_trans';
          break;
        default:
          return;
      }

      try {
        const response = await axios.get(endpoint);
        setTransactions(response.data);
      } catch (error) {
        console.error('Error fetching transactions:', error);
      }
    };

    fetchTransactions();
  }, [activeTab]);

  const renderTable = () => {
    return (
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        <h2>{activeTab} Transactions</h2>
        <button style={{ display: 'block', margin: '0 10% 20px auto', border: 'none', background: '#007bff', color: '#fff', padding: '10px 20px', cursor: 'pointer', borderRadius: '5px', transition: 'background-color 0.3s' }} onClick={handleAddTransaction}>
          Add Transaction
        </button>
        <table style={{ borderCollapse: 'collapse', width: '80%', boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)' }}>
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              {transactions.length > 0 && Object.keys(transactions[0]).map((key) => (
                <th key={key} style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>{key}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {transactions.map((transaction, index) => (
              <tr key={index} style={{ backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff' }}>
                {Object.values(transaction).map((value, idx) => (
                  <td key={idx} style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>{value}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  };

  const handleAddTransaction = () => {
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const fetchTransactionEndpoint = () => {
      let endpoint = '';
      switch (activeTab) {
        case 'Machines':
          endpoint = 'http://localhost:5000/api/machine_trans/trans';
          break;
        case 'Equipment':
          endpoint = 'http://localhost:5000/api/equip_trans/trans';
          break;
        case 'Product':
          endpoint = 'http://localhost:5000/api/product_trans/trans';
          break;
        case 'Materials':
          endpoint = 'http://localhost:5000/api/material_trans/trans';
          break;
        default:
          return '';
      }
      return endpoint;
    };

    try {
      const endpoint = fetchTransactionEndpoint();
      const response = await axios.post(endpoint, formData);
      setNotification(`Transaction added successfully: ${response.statusText}`);
      setShowModal(false);
      setFormData({});
      setTimeout(() => setNotification(''), 3000);
    } catch (error) {
      setNotification(`Error adding transaction: ${error.message}`);
      setTimeout(() => setNotification(''), 3000);
    }
  };

  return (
    <div>
      <div style={{ margin: '20px' }}></div>
      <nav style={{ position: 'sticky', top: 0, backgroundColor: '#fff', zIndex: 1000 }}>
        <ul className="nav-list" style={{ display: 'flex', justifyContent: 'flex-start', listStyle: 'none', padding: 0 }}>
          <li style={{ marginRight: '10px' }}>
            <button className={activeTab === 'Machines' ? 'nav-link active' : 'nav-link'} onClick={() => setActiveTab('Machines')} style={{ border: 'none', background: 'none', padding: '10px 20px', cursor: 'pointer', borderRadius: '5px', transition: 'background-color 0.3s' }}>
              Machines
            </button>
            {activeTab === 'Machines' && <hr style={{ margin: '5px 0', border: 'none', borderTop: '2px solid #007bff' }} />}
          </li>
          <li style={{ marginRight: '10px' }}>
            <button className={activeTab === 'Equipment' ? 'nav-link active' : 'nav-link'} onClick={() => setActiveTab('Equipment')} style={{ border: 'none', background: 'none', padding: '10px 20px', cursor: 'pointer', borderRadius: '5px', transition: 'background-color 0.3s' }}>
              Equipment
            </button>
            {activeTab === 'Equipment' && <hr style={{ margin: '5px 0', border: 'none', borderTop: '2px solid #007bff' }} />}
          </li>
          <li style={{ marginRight: '10px' }}>
            <button className={activeTab === 'Product' ? 'nav-link active' : 'nav-link'} onClick={() => setActiveTab('Product')} style={{ border: 'none', background: 'none', padding: '10px 20px', cursor: 'pointer', borderRadius: '5px', transition: 'background-color 0.3s' }}>
              Product
            </button>
            {activeTab === 'Product' && <hr style={{ margin: '5px 0', border: 'none', borderTop: '2px solid #007bff' }} />}
          </li>
          <li style={{ marginRight: '10px' }}>
            <button className={activeTab === 'Materials' ? 'nav-link active' : 'nav-link'} onClick={() => setActiveTab('Materials')} style={{ border: 'none', background: 'none', padding: '10px 20px', cursor: 'pointer', borderRadius: '5px', transition: 'background-color 0.3s' }}>
              Materials
            </button>
            {activeTab === 'Materials' && <hr style={{ margin: '5px 0', border: 'none', borderTop: '2px solid #007bff' }} />}
          </li>
        </ul>
      </nav>
      <div style={{ margin: '20px' }}></div>
      {renderTable()}
      <div style={{ margin: '20px' }}></div>
      {showModal && (
      <div className="modal" style={{ position: 'fixed', top: 0, right: 0, width: '100%', height: '100%', backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
        <div className="modal-content" style={{ background: '#fff', padding: '20px', borderRadius: '10px', boxShadow: '0 4px 8px rgba(0, 0, 0, 0.1)', margin: '20px', width: 'auto', maxWidth: '90%' }}>
          <div style={{ display: "flex", flexDirection: "row" }}>
            <h2 style={{ flexGrow: 1 }}>Add {activeTab} Transaction</h2>
            <span className="close" onClick={closeModal} style={{ cursor: 'pointer' }}>✖</span>
          </div>
          <form style={{ display: 'flex', flexWrap: 'wrap', gap: '10px' }} onSubmit={handleSubmit}>
            {transactions.length > 0 && Object.keys(transactions[0]).map((key, index) => (
            <div key={index} style={{ flex: '1 1', marginBottom: '10px' }}>
            <label style={{ display: 'block', marginBottom: '5px' }}>{key}</label>
            <input type={key.toLowerCase().includes('date') ? 'date' : 'text'} name={key} style={{ width: '100%', padding: '4px', boxSizing: 'border-box', borderRadius: '5px' }} onChange={handleInputChange} />
            </div>  
          ))}
            <div style={{ flex: '1 1 100%', display: 'flex', justifyContent: 'flex-end' }}>
            <button type="submit" style={{ border: 'none', background: '#007bff', color: '#fff', padding: '10px 20px', cursor: 'pointer', borderRadius: '5px', transition: 'background-color 0.3s' }}>Submit</button>
            </div>
        </form>
        </div>
      </div>
      )}
      {notification && (
        <div style={{ position: 'fixed', bottom: '20px', right: '20px', background: '#007bff', color: '#fff', padding: '10px 20px', borderRadius: '5px', boxShadow: '0 4px 8px rgba(0, 0, 0, 0.1)' }}>
          {notification}
        </div>
      )}
    </div>
  );
}

export default Transactions;