using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace InventoryManagementSystem
{
    public class InventoryManagement
    {

        private static List<Product> products = new List<Product>();
        public static void addProduct(Product product)
        {
            products.Add(product);
            Console.WriteLine($"Product {product.prodName} added successfully");
        }

        public static Product createProduct()
        {
            while (true)
            {
                Console.WriteLine("Enter a Product Name to Add (Ex.Apple) : ");
                string? prodName = Console.ReadLine();

                while (string.IsNullOrEmpty(prodName) || prodName.Any(char.IsDigit))
                {
                    Console.WriteLine("Please try again, Enter a Product Name to Add (Ex.Apple) : ");
                    prodName = Console.ReadLine();
                }

                Console.WriteLine("Enter Product Quantity (Ex.2) : ");
                if (int.TryParse(Console.ReadLine(), out int quantity) && quantity > 0)
                {
                    Console.WriteLine("Enter Product Price (Ex. 50) : ");
                    if (int.TryParse(Console.ReadLine(), out int prodPrice) && prodPrice > 0)
                    {
                        Product newProduct = new Product(products.Count + 1, prodName, quantity, prodPrice);
                        return newProduct;
                    }
                    else
                    {
                        Console.WriteLine("Invalid Product Price, Please Enter a Valid Price");
                    }
                }
                else
                {
                    Console.WriteLine("Invalid Quantity, Please Enter a Valid Integer");
                }
            }
        }

        public static void removeProduct(int productId)
        {
            Product? productToRemove = products.Find(p => p.prodId == productId);

            if (productToRemove != null)
            {
                products.Remove(productToRemove);
                Console.WriteLine($"Product with {productId} removed.");
            }
            else
            {
                Console.WriteLine($"No Product found with ID {productId}.");
            }
        }

        public static void updateProduct(int productId, int newQuantity)
        {
            Product? producToUpdate = products.Find(p => p.prodId == productId);
            if (producToUpdate != null)
            {
                producToUpdate.prodQuantity = newQuantity;
                Console.WriteLine($"Product ID {productId} updated with new quantity: {newQuantity}");
            }
            else
            {
                Console.WriteLine($"No product found with ID {productId}.");
            }
        }

        public static void viewProduct()
        {
            if (products.Count > 0)
            {
                Console.WriteLine("Product List");
                foreach (Product product in products)
                {
                    Console.WriteLine($"ID: {product.prodId}, Name: {product.prodName}, Quantity: {product.prodQuantity}, Price: {product.prodPrice:N2} Pesos");
                    Console.WriteLine("----------------------------------------------------");
                    Console.WriteLine();
                }
            }
            else
            {
                Console.WriteLine("No Products Available, Please add one!");
            }
        }

        public static void getTotalValue()
        {
            double totalValue = 0.00;
            foreach (var product in products)
            {
                totalValue += product.prodQuantity * product.prodPrice;
            }
            Console.WriteLine($"Total Value of Products: {totalValue:N2} Pesos");
        }
    }
}

