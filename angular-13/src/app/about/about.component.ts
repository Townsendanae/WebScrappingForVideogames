import { Component, } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  templateUrl: './about.component.html'
})
export class AboutComponent {
  buscar(nombre: string) {
    console.log(nombre);
    location.href = "./component/badges?input=" + nombre;
  }
  constructor(private router: Router) {
    
  }

}
