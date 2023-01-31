import { Component, OnInit } from "@angular/core";
import { NgbNavChangeEvent } from "@ng-bootstrap/ng-bootstrap";
import { blogcard, blogcards } from "./blog-cards-data";

interface Food {
  value: string;
  viewValue: string;
}

@Component({
  selector: "ngbd-dropdown-basic",
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

  // Array para hacer sorting
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

  orderByPriceAsc(arr: blogcard[]) {
    arr.sort(function (a, b) {
      if (isNaN(+a.price!) && !isNaN(+b.price!)) {
        return -1;
      } else if (!isNaN(+a.price!) && isNaN(+b.price!)) {
        return 1;
      } else if (!isNaN(+a.price!) && !isNaN(+b.price!)) {
        return parseFloat(a.price!) > parseFloat(b.price!)
          ? 1
          : parseFloat(a.price!) == parseFloat(b.price!)
          ? 0
          : -1;
      } else {
        return a.price! > b.price! ? 1 : a.price! == b.price! ? 0 : -1;
      }
    });
  }

  orderByPriceDes(arr: blogcard[]) {
    arr.sort(function (a, b) {
      if (isNaN(+a.price!) && !isNaN(+b.price!)) {
        return 1;
      } else if (!isNaN(+a.price!) && isNaN(+b.price!)) {
        return -1;
      } else if (!isNaN(+a.price!) && !isNaN(+b.price!)) {
        return parseFloat(a.price!) > parseFloat(b.price!)
          ? -1
          : parseFloat(a.price!) == parseFloat(b.price!)
          ? 0
          : 1;
      } else {
        return a.price! > b.price! ? -1 : a.price! == b.price! ? 0 : 1;
      }
    });
  }

  orderByTitleAsc(arr: blogcard[]) {
    arr.sort((a, b) => a.title.localeCompare(b.title));
  }

  orderByTitleDes(arr: blogcard[]) {
    arr.sort((a, b) => -1 * a.title.localeCompare(b.title));
  }

  orderPArrayAsc() {
    this.orderByPriceAsc(this.enebaShop);
    this.orderByPriceAsc(this.gogShop);
    this.orderByPriceAsc(this.steamShop);
  }

  orderPArrayDes() {
    this.orderByPriceDes(this.enebaShop);
    this.orderByPriceDes(this.gogShop);
    this.orderByPriceDes(this.steamShop);
  }

  orderTArrayAsc() {
    this.orderByTitleAsc(this.enebaShop);
    this.orderByTitleAsc(this.gogShop);
    this.orderByTitleAsc(this.steamShop);
  }

  orderTArrayDes() {
    this.orderByTitleDes(this.enebaShop);
    this.orderByTitleDes(this.gogShop);
    this.orderByTitleDes(this.steamShop);
  }

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

    fetch("http://localhost:3000/totalJuegos")
      .then((response) => response.json())
      .then((data) => {
        datosArray = data["result"];

        for (let juego of datosArray) {
          if (juego.price.includes("€")) {
            juego.price = juego.price.substring(0, juego.price.length - 2);
          }
          if (juego.price.includes("$")) {
            juego.price = juego.price.substring(1, juego.price.length);
          }
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
      .catch((error) => console.error(error));
  }
}
