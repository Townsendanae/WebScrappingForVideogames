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

    fetch('http://localhost:3000/totalJuegos')
    .then(response => response.json())
    .then(data => {
        datosArray = data['result'];
      

        for (let juego of datosArray){
          if (juego.price.includes("€")) {
            juego.price = juego.price.substring(0, juego.price.length - 2);
          }
          if (juego.price.includes("$")) {
            juego.price = juego.price.substring(1, juego.price.length);
          }
          if (juego.price.includes("to")){
            juego.price = 0
          }
        }

        this.blogcards = datosArray.filter((item: any) => parseFloat(item.price) < 5)
        
    })
    .catch(error => console.error(error));
  }


}
