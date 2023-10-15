import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router } from 'react-router-dom';
import { ChainId, ThirdwebProvider } from '@thirdweb-dev/react';

import { StateContextProvider } from './context';
import App from './App';
import './index.css';

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
    // <ThirdwebProvider 
    //   activeChain="goerli" 
    //   clientId="d112d3f58ec0d72c82daab0aec8ce258" // You can get a client id from dashboard settings
    // >
    <ThirdwebProvider activeChain={ChainId.Goerli}>
        <Router>
            <StateContextProvider>
                <App />
            </StateContextProvider>
        </Router>
    </ThirdwebProvider> 
)