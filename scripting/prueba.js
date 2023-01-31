const { execSync } = require('child_process');
const express = require('express');
const crypto = require('crypto');

const app = express();

app.get('/game/:idGame', (req, res) => {
  console.log(req.params)
  const rubyExec = execSync(`ruby GeneralBusqueda.rb "${req.params.idGame}"`);
  res.send('Sucess');
});

app.listen(3001, () => {
  console.log('Server listening on port 3000');
});
