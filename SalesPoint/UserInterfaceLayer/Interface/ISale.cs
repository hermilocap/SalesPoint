using DataAccessLayer;
using DataAccessLayer.Entities;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UserInterfaceLayer.Interface
{
   public interface ISale
    {
        Task<ActionResult<List<Sale>>> Get();
        Task<ActionResult<SaleDetailsDTO>> Get(int id);
    }
}
