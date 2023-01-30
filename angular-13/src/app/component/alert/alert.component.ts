import { Component, OnInit } from "@angular/core";
import { NgbNavChangeEvent } from "@ng-bootstrap/ng-bootstrap";
import { blogcard, blogcards } from "./blog-cards-data";

@Component({
  selector: "app-ngbd-alert",
  templateUrl: "alert.component.html",
  styles: [
    `
      .alert-custom {
        color: #cc4dd5;
        background-color: #f0c4f3;
        border-color: #f0c4f3;
      }
    `,
  ],
})
export class NgbdAlertBasicComponent implements OnInit {
  blogcards: blogcard[];
  enebaShop: blogcard[] = [];
  gogShop: blogcard[] = [];
  steamShop: blogcard[] = [];

  currentJustify = "start";

  active = 1;
  activev = "top";

  activeKeep = 1;

  activeSelected = 1;
  disabled = true;

  tabs = [1, 2, 3, 4, 5];
  counter = this.tabs.length + 1;
  activeDynamic = 1;

  onNavChange(changeEvent: NgbNavChangeEvent) {
    if (changeEvent.nextId === 3) {
      changeEvent.preventDefault();
    }
  }

  toggleDisabled() {
    this.disabled = !this.disabled;
    if (this.disabled) {
      this.activeSelected = 1;
    }
  }

  close(event: MouseEvent, toRemove: number) {
    this.tabs = this.tabs.filter((id) => id !== toRemove);
    event.preventDefault();
    event.stopImmediatePropagation();
  }

  add(event: MouseEvent) {
    this.tabs.push(this.counter++);
    event.preventDefault();
  }

  constructor() {
    this.blogcards = blogcards;
  }

  ngOnInit(): void {
    let datosArray;

    fetch('http://localhost:3000/totalJuegos')
    .then(response => response.json())
    .then(data => {
        datosArray = data['result'];

        for (let juego of datosArray) {
          if (juego.shopName == "Eneba") {
            this.enebaShop.push(juego);
          }
          if (juego.shopName == "Gog") {
            this.gogShop.push(juego);
          }
          if (juego.shopName == "Steam") {
            this.steamShop.push(juego);
          }
        }

        this.blogcards += datosArray;

    })
    .catch(error => console.error(error));
  }
}
