function myExchange = CreateExchangeCor()

clear GenerateIds;

myExchange = Exchange();
myExchange.AddProductExchange(ProductExchange('CBK_EUR', 0.01));
myExchange.AddProductExchange(ProductExchange('DBK_EUR', 0.01));
