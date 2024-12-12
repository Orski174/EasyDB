import React, { useState } from 'react';
import axios from 'axios';
import { Container, Typography, TextField, Button, Paper, Box } from '@mui/material';

const Query = () => {
    const [query, setQuery] = useState('');
    const [result, setResult] = useState(null);
    const [error, setError] = useState(null);

    const handleQueryChange = (e) => {
        setQuery(e.target.value);
    };

    const executeQuery = async () => {
        try {
            const response = await axios.post('/api/query', { query });
            setResult(response.data);
            setError(null);
        } catch (err) {
            setError(err.response ? err.response.data : 'Error executing query');
            setResult(null);
        }
    };

    return (
        <Container style={{ padding: '20px' }}>
            <Typography variant="h4" gutterBottom align="center">
                SQL Editor
            </Typography>
            <TextField
                label="Write your SQL query here..."
                multiline
                rows={10}
                variant="outlined"
                fullWidth
                value={query}
                onChange={handleQueryChange}
                style={{ marginBottom: '20px' }}
            />
            <Box display="flex" justifyContent="center">
                <Button variant="contained" color="primary" onClick={executeQuery}>
                    Execute Query
                </Button>
            </Box>
            {result && (
                <Paper style={{ marginTop: '20px', padding: '20px' }}>
                    <Typography variant="h6">Result:</Typography>
                    <pre>{JSON.stringify(result, null, 2)}</pre>
                </Paper>
            )}
            {error && (
                <Paper style={{ marginTop: '20px', padding: '20px' }}>
                    <Typography variant="h6" color="error">Error:</Typography>
                    <pre>{error}</pre>
                </Paper>
            )}
            {result && (
            <Paper style={{ marginTop: '20px', padding: '20px' }}>
                <Typography variant="h6">Response:</Typography>
                <pre>{JSON.stringify(result, null, 2)}</pre>
            </Paper>
        )}
        </Container>
    );
};

export default Query;