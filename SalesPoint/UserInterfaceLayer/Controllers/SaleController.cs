using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BusinessLogicLayer;
using DataAccessLayer;
using DataAccessLayer.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using UserInterfaceLayer.Interface;

namespace UserInterfaceLayer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SaleController : ControllerBase, ISale
    {
        SaleBL sale = new SaleBL();
        // GET: api/Sale
        [HttpGet]
        public async Task<ActionResult<List<Sale>>> Get()
        {
            var sales = sale.GetSales();
            return await Task.FromResult(sales.Result);
        }

        // GET: api/Sale/5
        [HttpGet("{id}", Name = "Get")]
        public async Task<ActionResult<SaleDetailsDTO>> Get(int id)
        {
            var sales = sale.GetSalesDetails(id);
            return await Task.FromResult(sales.Result);
        }

    }
}
