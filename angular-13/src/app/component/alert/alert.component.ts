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

    for (let juego of this.blogcards) {
      if (juego.shopName == "Ebena") {
        this.enebaShop.push(juego);
      }
      if (juego.shopName == "Gog") {
        this.gogShop.push(juego);
      }
    }
  }

  ngOnInit(): void {}
}
