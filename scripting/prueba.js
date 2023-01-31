const { execSync } = require('child_process');
const game = "The forest";

const rubyExec = execSync(`ruby GeneralBusqueda.rb "${game}"`);
