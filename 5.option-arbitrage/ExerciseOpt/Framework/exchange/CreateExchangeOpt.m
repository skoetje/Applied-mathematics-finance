function myExchange = CreateExchangeOpt()

clear GenerateIds;

myExchange = Exchange();

for myProduct = ['ING' GetAllOptionISINs()']
    myExchange.AddProductExchange(ProductExchange(myProduct{:}, 0.01));
end
