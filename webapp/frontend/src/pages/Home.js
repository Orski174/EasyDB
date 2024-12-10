import React from 'react';
import { Link } from 'react-router-dom';
import { Container, Typography, Card, CardContent, CardActionArea } from '@mui/material';

function Home() {
  return (
    <div>
      <Container style={{ padding: '20px' }}>
        <div style={{ textAlign: 'center', marginBottom: '20px' }}>
          <img src={require('../EasyDB.png')} alt="EasyDB Logo" style={{ maxWidth: '200px' }} />
        </div>
        <Typography variant="h3" gutterBottom>
          Welcome to EasyDB
        </Typography>
        <Typography variant="body1" paragraph>
          This application allows you to interact with and manage your database efficiently. Below is a brief overview of each page and its functionality:
        </Typography>

        <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'space-between' }}>
          <Card style={{ marginBottom: '20px', flex: '0 0 48%' }}>
            <CardActionArea component={Link} to="/viewdb">
              <CardContent>
                <Typography variant="h5">View Database</Typography>
                <Typography variant="body2" color="textSecondary">
                  The View Database page allows you to view the contents of various tables in your database. You can select a table from the dropdown menu to see its data displayed in a tabular format.
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>

          <Card style={{ marginBottom: '20px', flex: '0 0 48%' }}>
            <CardActionArea component={Link} to="/interactdb">
              <CardContent>
                <Typography variant="h5">Interact with Database</Typography>
                <Typography variant="body2" color="textSecondary">
                  The Interact with Database page provides advanced editing capabilities. You can select a table, edit its data directly, and even insert or delete rows. This page is designed for more hands-on database management.
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>

          <Card style={{ marginBottom: '20px', flex: '0 0 48%' }}>
            <CardActionArea component={Link} to="/transactions">
              <CardContent>
                <Typography variant="h5">Transactions</Typography>
                <Typography variant="body2" color="textSecondary">
                  The Transactions page allows you to manage different types of transactions such as Machines, Equipment, Products, and Materials. You can add new transactions and view existing ones in a tabular format.
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>

          <Card style={{ marginBottom: '20px', flex: '0 0 48%' }}>
            <CardActionArea component={Link} to="/logistics">
              <CardContent>
                <Typography variant="h5">Logistics</Typography>
                <Typography variant="body2" color="textSecondary">
                  The Logistics page provides various pre-defined queries to analyze your data. You can select a query from the dropdown menu and run it to see the results. This page helps in gaining insights from your data.
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
        </div>
      </Container>

      <footer style={{ marginTop: '40px', textAlign: 'center', marginBottom: '20px' }}>
        <Typography variant="body2" color="textSecondary">
          About Us: EasyDB is dedicated to providing efficient and user-friendly database management solutions. Our goal is to simplify database interactions for users of all skill levels.
        </Typography>
      </footer>
    </div>
  );
}

export default Home;
