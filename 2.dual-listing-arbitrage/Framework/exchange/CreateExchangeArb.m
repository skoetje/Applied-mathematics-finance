function myExchange = CreateExchangeArb()

clear GenerateIds;

myExchange = Exchange();
myExchange.AddProductExchange(ProductExchange('AEX_AKZA', 0.01));
myExchange.AddProductExchange(ProductExchange('CHX_AKZA', 0.01));
