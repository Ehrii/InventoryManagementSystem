using System.Diagnostics;

namespace InventoryManagementSystem
{
    public class Program
    {
        private static List<Product>products = new List<Product>();

        static void Main(string[] args)
        {
            Program program = new Program();
            bool exit = true;
            while (exit!=false) {

                Console.WriteLine("----------------------------------------------------");
                Console.WriteLine("Inventory Management System");
                Console.WriteLine("----------------------------------------------------");
                Console.WriteLine();
                Console.WriteLine("1. Add Product");
                Console.WriteLine("2. Remove Product");
                Console.WriteLine("3. Update Product");
                Console.WriteLine("4. View Products");
                Console.WriteLine("5. Get Total Value");
                Console.WriteLine();
                Console.WriteLine("Enter a Choice (1-5) or Press {X} to Exit");
                string? userChoice = Console.ReadLine();
                Console.WriteLine("----------------------------------------------------");

                switch (userChoice)
                {
                    case "1":
                        program.addProduct(createProduct());
                        break;
                    case "2":
                        Console.WriteLine("Enter a Product ID to remove");
                        if (int.TryParse(Console.ReadLine(), out int productId)) 
                        {
                            program.removeProduct(productId);
                        }
                        else
                        {
                            Console.WriteLine("Invalid Product ID, Please enter a valid integer number.");
                        }
                        break;
                    case "3":
                        Console.WriteLine("Enter a Product ID to Update: ");
                        if (int.TryParse(Console.ReadLine(), out int updateId) && updateId > 0)
                        {
                            Console.WriteLine("Enter Quantity to Update: ");
                            if (int.TryParse(Console.ReadLine(), out int newQuantity) && newQuantity > 0)
                            {
                               program.updateProduct(updateId,newQuantity);
                            }
                        }
                        else
                        {
                            Console.WriteLine("Invalid Product ID, Please enter a valid integer number.");
                        }
                        break;
                    case "4":
                        program.viewProduct();
                        break;
                    case "5":
                        program.getTotalValue();
                        break;
                    case "X":
                    case "x":
                        exit = false;
                        break;
                    default:
                        Console.WriteLine("Please Input a Valid Choice, Try Again!");
                        break;
                       
                }
            }
        }

        void addProduct(Product product)
        {
            products.Add(product);
            Console.WriteLine($"Product {product.prodName} added successfully");
        }

        static Product createProduct()
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
                if (int.TryParse(Console.ReadLine(), out int quantity) && quantity>0)
                {
                    Console.WriteLine("Enter Product Price (Ex. 50) : ");
                    if (int.TryParse(Console.ReadLine(), out int prodPrice) && prodPrice>0)
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

       void removeProduct(int productId)
        {
            Product ?productToRemove = products.Find(p => p.prodId == productId);

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

        void updateProduct(int productId, int newQuantity)
        {
            Product? producToUpdate = products.Find(p=> p.prodId==productId);
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

        void viewProduct()
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

        void getTotalValue()
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
