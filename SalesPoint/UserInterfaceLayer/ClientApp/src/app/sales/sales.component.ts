import { Component, OnInit, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DatePipe } from '@angular/common';
import { Router } from '@angular/router';
import { SalesService } from './sales.service';
import pdfMake from 'pdfmake/build/pdfmake';
import pdfFonts from 'pdfmake/build/vfs_fonts';
pdfMake.vfs = pdfFonts.pdfMake.vfs;
@Component({
  selector: 'app-sales',
  templateUrl: './sales.component.html',
  styleUrls: ['./sales.component.css']
})
export class SalesComponent implements OnInit {
    http: HttpClient;
    baseUrl: string;
    sales: any = [];
    salesDetails: any = [];
    saleId: any;
    iva: any;
    total: any;
    saleDate: any;
    constructor(private datepipe: DatePipe,
        private Route: Router,
        private saleService: SalesService,
        http: HttpClient,
        @Inject('BASE_URL') baseUrl: string) {
        this.http = http;
        this.baseUrl = baseUrl;

    }
    ngOnInit() {
        this.saleService.GetAllSales().subscribe(result => {
            this.sales = result;
        })
    }
    public OnSaleDetail(saleId: number) {
        this.Route.navigate(["/app-salesdetails", saleId]);

  }
    public RowSelected(saleId: number) {
        this.saleId = saleId;
    }
    public OnPrintSale() {
        this.saleService.GetDetailsSales(this.saleId).subscribe(
            result => {
                this.salesDetails = result;
                this.iva = this.salesDetails.mount * 16 / 100;
                this.total = this.salesDetails.mount + this.iva;
                this.saleDate = this.datepipe.transform(this.salesDetails.dateSale, 'dd/MM/yyyy');
                this.generatePdf()
            }
        )
    }
    generatePdf() {
        const documentDefinition = {
            content:

                [
                    {
                        text: 'Punto de venta S.A. de C.V.',
                        alignment: 'center'
                    },
                    {
                        text: 'Cliente: ' + this.salesDetails.clientName,
                        alignment: 'center'
                    },
                    {
                        text: 'Fecha: ' + this.saleDate,
                        alignment: 'center'
                    },
                    {
                        table: {
                            headerRows: 1,
                            widths: ['*', 'auto', 100, '*', '*'],
                            body: [
                                ['Clave', 'Producto', 'Cantidad', 'Precio', 'Importe'],
                                [this.salesDetails.productId, this.salesDetails.productName, this.salesDetails.quantity, this.salesDetails.price, this.salesDetails.mount]
                            ]
                        }
                    },
                    {
                        text: 'Subtotal: ' + this.salesDetails.mount,
                        alignment: 'center'
                    },
                    {
                        text: 'IVA: ' + this.iva,
                        alignment: 'center'
                    },
                    {
                        text: 'Total: ' + this.total,
                        alignment: 'center'
                    }
                ]
        };
        pdfMake.createPdf(documentDefinition).open();
    }
}
