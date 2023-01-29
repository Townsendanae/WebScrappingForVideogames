
let miBoton = document.getElementById("miBoton");

miBoton.onclick = function sendInputValue(){
    var inputValue = document.getElementById("inputId").value;
    console.log(inputValue)
    location.href = "./component/badges?input=" + inputValue;
  }
