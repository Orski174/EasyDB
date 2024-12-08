import React, { useState, useEffect } from 'react';
import axios from 'axios';

function Logistics() {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios
      .get('http://localhost:5000/api/logistics')
      .then((response) => {
        setData(response.data); // Directly use the response data
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }, []);
  

  
  return (
    <div style={{ padding: '20px' }}>
      <h1 style={{ textAlign: 'center', marginBottom: '20px' }}>
        Warehouse(s) Containing the product with highest price_per_unit
      </h1>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
            margin: '0 auto',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Warehouse Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Product Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Max Price
              </th>
            </tr>
          </thead>
          <tbody>
            {data.length > 0 ? (
              data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.warehouse_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.product_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.max_price}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="3"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );  
}

export default Logistics;
