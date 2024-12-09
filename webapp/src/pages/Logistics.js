import React, { useState, useEffect } from 'react';
import axios from 'axios';

function Logistics() {
  const [query1Data, setQuery1Data] = useState([]);
  const [query2Data, setQuery2Data] = useState([]);
  const [query3Data, setQuery3Data] = useState([]);
  const [query4Data, setQuery4Data] = useState([]);
  const [query5Data, setQuery5Data] = useState([]);
  const [query6Data, setQuery6Data] = useState([]);
  const [query7Data, setQuery7Data] = useState([]);
  const [query8Data, setQuery8Data] = useState([]);
  const [query9Data, setQuery9Data] = useState([]);
  const [query10Data, setQuery10Data] = useState([]);


  useEffect(() => {
    axios
      .get('http://localhost:5000/api/Query1')
      .then((response) => {
        setQuery1Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query1 data:', error);
      });
    
    axios
      .get('http://localhost:5000/api/Query2')
      .then((response) => {
        setQuery2Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query2 data:', error);
      });

    axios
      .get('http://localhost:5000/api/Query3')
      .then((response) => {
        setQuery3Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query3 data:', error);
      });

    axios
      .get('http://localhost:5000/api/Query4')
      .then((response) => {
        setQuery4Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query4 data:', error);
      });

    axios
      .get('http://localhost:5000/api/Query5')
      .then((response) => {
        setQuery5Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query5 data:', error);
      });

    axios
      .get('http://localhost:5000/api/Query6')
      .then((response) => {
        setQuery6Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query6 data:', error);
      });

    axios
      .get('http://localhost:5000/api/Query7')
      .then((response) => {
        setQuery7Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query7 data:', error);
      });
      
    axios
      .get('http://localhost:5000/api/Query8')
      .then((response) => {
        setQuery8Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query8 data:', error);
      });
    
     axios
      .get('http://localhost:5000/api/Query9')
      .then((response) => {
        setQuery9Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query9 data:', error);
      });

    axios
      .get('http://localhost:5000/api/Query10')
      .then((response) => {
        setQuery10Data(response.data);
      })
      .catch((error) => {
        console.error('Error fetching Query10 data:', error);
      });
  }, []);

  return (
    <div style={{ padding: '20px' }}>
      {/* Query 1 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
        Warehouse(s) Containing the Product with Highest Price per Unit
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
            {query1Data.length > 0 ? (
              query1Data.map((item, index) => (
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

      <br></br>

      <br></br>
      {/* Query 2 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
        Top 5 Departments Buying the Most Material in the Last Year based on Employee activity
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Department Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Total Material Used
              </th>
            </tr>
          </thead>
          <tbody>
            {query2Data.length > 0 ? (
              query2Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.department_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.total_material_used}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <br></br>

      <br></br>
      {/* Query 3 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
            Employees who have handled at least 3 different product transactions
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                SSN
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                First Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Last Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Product Count
              </th>
            </tr>
          </thead>
          <tbody>
            {query3Data.length > 0 ? (
              query3Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.SSN}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.F_Name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.L_Name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.Product_Count}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>


      <br></br>

      <br></br>
      {/* Query 4 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Employees Managing Multiple Unique Machines
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                SSN
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                First Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Last Name 
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Machine Count
              </th>
            </tr>
          </thead>
          <tbody>
            {query4Data.length > 0 ? (
              query4Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.SSN}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.F_Name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.L_Name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.Machine_Count}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
  
      <br></br>

      <br></br>
      {/* Query 5 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Machines and Their Total Days Operated by Department
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Department Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Machine Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Machine Number
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Total Operation Days
              </th>
            </tr>
          </thead>
          <tbody>
            {query5Data.length > 0 ? (
              query5Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.department_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.machine_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.Machine_Nb}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.Total_Operation_Days}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <br></br>

      <br></br>
      {/* Query 6 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Identifying Key Suppliers with Significant Contribution to Material Transactions
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Supplier Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Supplier Quantity
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Percentage
              </th>
            </tr>
          </thead>
          <tbody>
            {query6Data.length > 0 ? (
              query6Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.supplier_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.supplier_quantity}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.percentage}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>


      <br></br>

      <br></br>
      {/* Query 7 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Top 3 Warehouses by Product Revenue in the Last Year
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Warehouse Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Product Revenue
              </th>
            </tr>
          </thead>
          <tbody>
            {query7Data.length > 0 ? (
              query7Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.WH_Name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.Product_Revenue}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>


      <br></br>

      <br></br>
      {/* Query 8 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Most Sold Product Category per Warehouse in the Last Year
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Warehouse Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Product Category
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Total Quantity Sold
              </th>
            </tr>
          </thead>
          <tbody>
            {query8Data.length > 0 ? (
              query8Data.map((item, index) => (
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
                    {item.product_category}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.total_quantity_sold}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <br></br>

      <br></br>
      {/* Query 9 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Top 3 Employees Handling the Most Product Transactions in the Last Year
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Employee Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Products Handled
              </th>
            </tr>
          </thead>
          <tbody>
            {query9Data.length > 0 ? (
              query9Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.employee_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.products_handled}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
                  style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}
                >
                  No data available
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>


      <br></br>

      <br></br>
      {/* Query 10 Table */}
      <h3 style={{ textAlign: 'center', marginBottom: '20px' }}>
      Top 3 Best-Selling Products in the Last 6 Months by Total Sales
      </h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table
          style={{
            borderCollapse: 'collapse',
            width: '80%',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
          }}
        >
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Product Name
              </th>
              <th style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                Total Sales
              </th>
            </tr>
          </thead>
          <tbody>
            {query10Data.length > 0 ? (
              query10Data.map((item, index) => (
                <tr
                  key={index}
                  style={{
                    backgroundColor: index % 2 === 0 ? '#f9f9f9' : '#fff',
                  }}
                >
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.product_name}
                  </td>
                  <td style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'center' }}>
                    {item.total_sales}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan="2"
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
