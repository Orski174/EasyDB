import React, { useState } from 'react';
import axios from 'axios';

function Logistics() {
  const [selectedQuery, setSelectedQuery] = useState('');
  const [queryData, setQueryData] = useState([]);
  const [loading, setLoading] = useState(false);

  const handleQueryChange = (event) => {
    setSelectedQuery(event.target.value);
  };

  const fetchData = () => {
    if (!selectedQuery) return;
    setLoading(true);
    axios
      .get(`http://localhost:5000/api/${selectedQuery}`)
      .then((response) => {
        setQueryData(response.data);
        setLoading(false);
      })
      .catch((error) => {
        console.error(`Error fetching ${selectedQuery} data:`, error);
        setLoading(false);
      });
  };

  return (
    <div style={{ padding: '20px' }}>
      <div style={{ marginBottom: '20px', textAlign: 'center' }}>
        <select value={selectedQuery} onChange={handleQueryChange}>
          <option value="">Select a query</option>
          <option value="Query1">Query 1</option>
          <option value="Query2">Query 2</option>
          <option value="Query3">Query 3</option>
          <option value="Query4">Query 4</option>
          <option value="Query5">Query 5</option>
          <option value="Query6">Query 6</option>
          <option value="Query7">Query 7</option>
          <option value="Query8">Query 8</option>
          <option value="Query9">Query 9</option>
          <option value="Query10">Query 10</option>
        </select>
        <button onClick={fetchData} disabled={loading}>
          {loading ? 'Loading...' : 'Run'}
        </button>
      </div>

      {loading && <p style={{ textAlign: 'center' }}>Loading data...</p>}

      {!loading && queryData.length === 0 && selectedQuery && (
        <p style={{ textAlign: 'center' }}>No data available for {selectedQuery}</p>
      )}

      {queryData.length > 0 && (
        <div>
          <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
            {selectedQuery}
          </h3>
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            <table
              style={{
                borderCollapse: 'collapse',
                width: '80%',
                boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
                marginBottom: '40px',
              }}
            >
              <thead>
                <tr style={{ backgroundColor: '#f2f2f2' }}>
                  {Object.keys(queryData[0]).map((key, index) => (
                    <th
                      key={index}
                      style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                    >
                      {key}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {queryData.map((item, index) => (
                  <tr
                    key={index}
                    style={{
                      backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                    }}
                  >
                    {Object.values(item).map((value, i) => (
                      <td
                        key={i}
                        style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                      >
                        {value}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}

export default Logistics;
