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
    <div>
      <h1>Warehouse(s) Containing the product with highest price_per_unit</h1>
      <table border="1" style={{ width: '100%', borderCollapse: 'collapse' }}>
        <thead>
          <tr>
            <th>Warehouse Name</th>
            <th>Product Name</th>
            <th>Max Price</th>
          </tr>
        </thead>
        <tbody>
          {data.length > 0 ? (
            data.map((item, index) => (
              <tr key={index}>
                <td>{item.warehouse_name}</td>
                <td>{item.product_name}</td>
                <td>{item.max_price}</td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan="3">No data available</td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
}

export default Logistics;
