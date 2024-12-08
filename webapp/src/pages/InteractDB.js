import React from 'react';
import { useEffect, useState } from 'react';
import axios from 'axios';

function InteractDB() {

  const [data, setData] = useState([]);
  const [tables] = useState(['Block', 'Block_Categories', 'Consumer', 'Contains_Material', 'Contains_Product', 'Department', 'Department_Occupies', 'Dependents', 'Emp_Occup', 'Employee', 'Equip_Trans', 'Equipment', 'Machine', 'Machine_Trans', 'Maintains_Equip', 'Maintains_Mach', 'Material_Trans', 'Product', 'Product_Category', 'Product_RM', 'Product_Trans', 'Raw_Material', 'Rooms', 'Supplier', 'Warehouse']);
  const [selectedTable, setSelectedTable] = useState(tables[0]);

  const handleTableChange = (event) => {
    setSelectedTable(event.target.value);
  };

  useEffect(() => {
    axios.get(`http://localhost:5000/api/${selectedTable}`)
      .then(response => {
        setData(response.data);
      })
      .catch(error => {
        console.error('There was an error fetching the data!', error);
      });
  }, [selectedTable]);

  const handleCellChange = (rowIndex, columnKey, newValue) => {
    const updatedData = [...data];
    updatedData[rowIndex][columnKey] = newValue;
    setData(updatedData);

    const primaryKey = {
      'Block': 'bk_id',
      'Block_Categories': 'block_id',
      'Consumer': 'con_id',
      'Contains_Material': 'block_id',
      'Contains_Product': 'block_id',
      'Department': 'dep_name',
      'Department_Occupies': 'dep_name',
      'Dependents': 'dependantname',
      'Emp_Occup': 'employeesn',
      'Employee': 'ssn',
      'Equip_Trans': 'supp_id',
      'Equipment': 'equipment_id',
      'Machine': 'machine_nb',
      'Machine_Trans': 'supp_id',
      'Maintains_Equip': 'equipment_id',
      'Maintains_Mach': 'machine_number',
      'Material_Trans': 'mat_name',
      'Product': 'product_name',
      'Product_Category': 'product_name',
      'Product_RM': 'product_name',
      'Product_Trans': 'prod_name',
      'Raw_Material': 'material_name',
      'Rooms': 'room_id',
      'Supplier': 'supp_id',
      'Warehouse': 'wh_name'
    }[selectedTable];

    axios.post(`http://localhost:5000/api/${selectedTable}/update`, {
      row: updatedData[rowIndex][primaryKey],
      column: columnKey,
      value: newValue
    })
    .then(response => {
      console.log('Data updated successfully');
    })
    .catch(error => {
      console.error('There was an error updating the data!', error);
    });
  };

  return (
    <div>
      <h1>Interact with Database</h1>
      <label htmlFor="tables">Choose a table:</label>
      <select
        name="tables"
        id="tables"
        onChange={handleTableChange}
        style={{
          padding: '10px',
          fontSize: '16px',
          borderRadius: '5px',
          border: '1px solid #ccc',
          marginBottom: '20px'
        }}
      >
        {tables.map((table, index) => (
          <option key={index} value={table}>{table}</option>
        ))}
      </select>
      <br />
      <br />
      <h3>{selectedTable}</h3>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <table style={{ borderCollapse: 'collapse', width: '80%', boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)' }}>
          <thead>
            <tr style={{ backgroundColor: '#f2f2f2' }}>
              {data.length > 0 && Object.keys(data[0]).map((key, index) => (
                <th key={index} style={{ border: '1px solid #ddd', padding: '12px', textAlign: 'left' }}>{key}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {data.sort((a, b) => {
                const primaryKey = {
                'Block': 'bk_id',
                'Block_Categories': 'block_id',
                'Consumer': 'con_id',
                'Contains_Material': 'block_id',
                'Contains_Product': 'block_id',
                'Department': 'dep_name',
                'Department_Occupies': 'dep_name',
                'Dependents': 'dependantname',
                'Emp_Occup': 'employeesn',
                'Employee': 'ssn',
                'Equip_Trans': 'supp_id',
                'Equipment': 'equipment_id',
                'Machine': 'machine_nb',
                'Machine_Trans': 'supp_id',
                'Maintains_Equip': 'equipment_id',
                'Maintains_Mach': 'machine_number',
                'Material_Trans': 'mat_name',
                'Product': 'product_name',
                'Product_Category': 'product_name',
                'Product_RM': 'product_name',
                'Product_Trans': 'prod_name',
                'Raw_Material': 'material_name',
                'Rooms': 'room_id',
                'Supplier': 'supp_id',
                'Warehouse': 'wh_name'
                }[selectedTable];
              return a[primaryKey] > b[primaryKey] ? 1 : -1;
            }).map((item, rowIndex) => (
              <tr key={rowIndex} style={{ backgroundColor: rowIndex % 2 === 0 ? '#f9f9f9' : '#fff' }}>
                {Object.keys(item).map((key, columnIndex) => (
                  <td key={columnIndex} style={{ border: '1px solid #ddd', padding: '12px' }}>
                    <input
                      type="text"
                      value={item[key]}
                      onChange={(e) => handleCellChange(rowIndex, key, e.target.value)}
                      onBlur={(e) => handleCellChange(rowIndex, key, e.target.value)}
                      style={{ width: '100%', border: 'none', background: 'transparent' }}
                    />
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <br />
      <br />
    </div>
  );
};
export default InteractDB;