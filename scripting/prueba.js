const { spawn } = require("child_process");

const file = 'C:\\Users\\Usuario\\Desktop\\WebScrappingForVideogames\\Scrapping\\EnebaJuegosBusqueda.rb'

const cmd = spawn("ruby", [file,"minecraft"]);

let output = "";

cmd.stdout.on("data", function(data) {
  output = data;
});

cmd.on("close", function(code) {
  console.log(output.toString());
});