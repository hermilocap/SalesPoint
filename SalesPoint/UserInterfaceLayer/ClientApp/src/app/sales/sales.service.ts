import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SalesService {

    constructor(private http: HttpClient) { }
    public GetAllSales(): Observable<any> {
        return this.http.get(environment.userInterfaceLayer)
    }
    public GetDetailsSales(id: number): Observable<any> {
        return this.http.get(environment.userInterfaceLayer + "/" + id);
    }
}
