using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccessLayer.Entities
{
   public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int Stock { get; set; }
    }
}