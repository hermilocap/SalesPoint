using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccessLayer
{
   public class SaleDetailsDTO
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal Mount { get; set; }
        public int ClientId { get; set; }
        public string ClientName { get; set; }
        public DateTime DateSale { get; set; }
    }
}
