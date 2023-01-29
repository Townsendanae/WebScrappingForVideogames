import { Component, OnInit } from "@angular/core";
import { blogcard, blogcards } from "./blog-cards-data";

@Component({
  selector: "app-blog-cards",
  templateUrl: "./blog-cards.component.html",
})
export class BlogCardsComponent implements OnInit {
  blogcards: blogcard[];

  constructor() {
    this.blogcards = blogcards;
  }

  ngOnInit(): void {
    let datosArray;

    fetch('http://localhost:3000/totalJuegosEconomicos.json')
    .then(response => response.json())
    .then(data => {
        datosArray = data['result'];
        this.blogcards = datosArray;
    })
    .catch(error => console.error(error));
  }
}
