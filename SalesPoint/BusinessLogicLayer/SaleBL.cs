using DataAccessLayer;
using DataAccessLayer.Entities;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
   public class SaleBL
    {
        private SaleDAL sale = new SaleDAL();
        public async Task<ActionResult<List<Sale>>> GetSales()
        {
            var sales =await sale.Sales();
            return sales;
        }
        public async Task<ActionResult<SaleDetailsDTO>> GetSalesDetails(int id)
        {
            var salesDetails = await sale.SalesDetails(id);
            return salesDetails;
        }
    }
}
