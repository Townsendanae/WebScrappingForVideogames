import { ActivatedRoute } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { Component } from "@angular/core";
import { blogcard, blogcards } from "./blog-cards-data";

@Component({
  templateUrl: "./badge.component.html",
})

export class BadgeComponent {

  blogcards: blogcard[];

  constructor(private route: ActivatedRoute, private http: HttpClient) {

    this.blogcards = blogcards;
    this.route.queryParams.subscribe(params => {
      let input = params['input'];
      let headers = new Headers();

      headers.append('Content-Type', 'application/json');
      headers.append('Accept', 'application/json');
      headers.append('Origin', 'http://localhost:3001');

      fetch("http://localhost:3001/game/" + input, {
        mode: 'no-cors',
        credentials: 'include',
        method: 'GET',
        headers: headers
      })

      fetch('http://localhost:3000/totalJuegos')
        .then(response => response.json())
        .then(data => {
          let arrayTemp;
          arrayTemp = data['result']
          this.blogcards = arrayTemp.filter((item: any) => item.title.toLowerCase().includes(input.toLowerCase()))


          let html = "";
          for (let i = 0; i < this.blogcards.length; i++) {
            console.log("Aa")
            html += `
                <div class="col-md-6 col-lg-3">
                  <div class="card">
                    <img src="${this.blogcards[i].pictureLink}" alt="blogs" class="card-img-top" width="300" height="150" />
                    <div class="card-body" id="informationCard">
                    <h4 class="card-title">${ this.blogcards[i].title }</h4>
                    <h6 class="card-subtitle">Tienda: ${ this.blogcards[i].shopName }</h6>
                    <h6 class="card-subtitle">Precio: ${ this.blogcards[i].price }</h6>
                    <a href="${ this.blogcards[i].linkToShop }">
                      <button type="button" class="btn btn-primary">Ir al sitio</button>
                    </a>
                    </div>
                  </div>
                </div>`;

          }

          document.getElementById('row')!.innerHTML = html
        })
        .catch(error => console.error(error))
    });



  }

}
