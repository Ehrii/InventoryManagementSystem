﻿using System.Diagnostics;

namespace InventoryManagementSystem
{
    public class Program
    {
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
                        InventoryManager.addProduct(InventoryManager.createProduct());
                        break;
                    case "2":
                        Console.WriteLine("Enter a Product ID to remove");
                        if (int.TryParse(Console.ReadLine(), out int productId)) 
                        {
                         InventoryManager.removeProduct(productId);
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
                               InventoryManager.updateProduct(updateId,newQuantity);
                            }
                        }
                        else
                        {
                            Console.WriteLine("Invalid Product ID, Please enter a valid integer number.");
                        }
                        break;
                    case "4":
                        InventoryManager.viewProduct();
                        break;
                    case "5":
                        InventoryManager.getTotalValue();
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
    }

  
}
