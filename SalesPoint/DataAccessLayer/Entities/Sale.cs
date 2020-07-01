using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccessLayer.Entities
{
   public class Sale
    {
        public int SaleId { get; set; }
        public int ClientId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public decimal Mount { get; set; }
        public DateTime DateSale { get; set; }
    }
}
