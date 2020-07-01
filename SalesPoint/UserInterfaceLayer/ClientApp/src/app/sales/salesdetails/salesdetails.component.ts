import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { SalesService } from '../sales.service';

@Component({
  selector: 'app-salesdetails',
  templateUrl: './salesdetails.component.html',
  styleUrls: ['./salesdetails.component.css']
})
export class SalesdetailsComponent implements OnInit {
    sales: Product;
    constructor(private Route: ActivatedRoute,
        private saleService: SalesService) { }
    ngOnInit() {
        this.Route.paramMap.subscribe(params => {
            const id = +params.get('id');
            if (id) {
                this.saleService.GetDetailsSales(id).subscribe(
                    result => {
                        this.sales = result;
                    }
                )
            }
        });
    }
  }
