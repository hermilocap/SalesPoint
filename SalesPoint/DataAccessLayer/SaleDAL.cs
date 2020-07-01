using DataAccessLayer.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SaleDAL
    {
        static public IConfigurationRoot Configuration { get; set; }
        public async Task<ActionResult<List<Sale>>> Sales()
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");
            Configuration = builder.Build();
            var stringConection = Configuration["ConnectionStrings:MyConnection"];
            var sales = new List<Sale>();
            using (var con = new SqlConnection(stringConection))
            {
                con.Open();
                var query = new SqlCommand("spGetSales", con);
                query.CommandType = CommandType.StoredProcedure;
                using (var datareader = await query.ExecuteReaderAsync())
                {
                    while (datareader.Read())
                    {
                        Sale sale = new Sale();
                        sale.SaleId = Convert.ToInt32(datareader["SaleId"]);
                        sale.ClientId = Convert.ToInt32(datareader["ClientId"]);
                        sale.ProductId = Convert.ToInt32(datareader["ProductId"]);
                        sale.Quantity = Convert.ToInt32(datareader["Quantity"]);
                        sale.Mount = Convert.ToDecimal(datareader["Mount"]);
                        sale.DateSale = Convert.ToDateTime(datareader["DateSale"]);
                        sales.Add(sale);
                    }
                    con.Close();
                }
            }
            return await Task.FromResult(sales);
        }
        public async Task<ActionResult<SaleDetailsDTO>> SalesDetails(int id)
        {
            var builder = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json");
            Configuration = builder.Build();
            var stringConection = Configuration["ConnectionStrings:MyConnection"];
            var sale = new SaleDetailsDTO();
            using (var con = new SqlConnection(stringConection))
            {
                con.Open();
                var query = new SqlCommand("spGetSalesDetails", con);
                query.Parameters.AddWithValue("@SaleId", id);
                query.CommandType = CommandType.StoredProcedure;
                using (var datareader = await query.ExecuteReaderAsync())
                {
                    while (datareader.Read())
                    {
                        sale.ProductId = Convert.ToInt32(datareader[0]);
                        sale.ProductName = Convert.ToString(datareader[1]);
                        sale.Quantity = Convert.ToInt32(datareader[2]);
                        sale.Price = Convert.ToDecimal(datareader[3]);
                        sale.Mount = Convert.ToDecimal(datareader[4]);
                        sale.ClientId = Convert.ToInt32(datareader[5]);
                        sale.ClientName = Convert.ToString(datareader[6]);
                        sale.DateSale = Convert.ToDateTime(datareader[7]);
                    }
                    con.Close();
                }
            }
            return await Task.FromResult(sale);
        }
    }
}