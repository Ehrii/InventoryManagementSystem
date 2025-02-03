using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryManagementSystem
{
    public class Product
    {
        public int prodId { get; set; }
        public string prodName { get; set; }
        public double prodPrice { get; set; }
        public int prodQuantity { get; set; }

        public Product(int id, string name, double price, int quantity)
        {
            prodId = id;
            prodName = name;
            prodPrice = price;
            prodQuantity= quantity;
        }
    }
}
