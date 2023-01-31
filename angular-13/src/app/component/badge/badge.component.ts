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
        headers.append('Origin','http://localhost:3001');
    
        fetch("http://localhost:3001/game/"+input, {
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
          console.log(this.blogcards)
        })
    .catch(error => console.error(error))
    });
  


  }
  
}
