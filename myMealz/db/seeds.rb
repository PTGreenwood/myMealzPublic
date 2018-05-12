# SEED ALL THE PRODUCTS!
prodType = Array["protein", "grain", "dairy", "vegetable", "fruit", "fat", "disc"]
counter = 0
typeCount = 0
10.times do
  if((counter % 2) == 0)



    Product.create({
        productID: counter+1,
        productName: Faker::Food.ingredient,
        totalCal: Faker::Number.between(5, 40),
        proteinQty: Faker::Number.between(0, 2),
        carbohydrateQty: Faker::Number.between(0, 4),
        fatsQty: Faker::Number.between(0, 3),
        productType: prodType[typeCount],
        servingQty: Faker::Number.between(0, 10),
        servingType: Faker::Measurement.metric_weight("none")

                   })
  else
    Product.create({
                     productID: counter+1,
                     productName: Faker::Food.ingredient,
                     totalCal: Faker::Number.between(1, 20),
                     proteinQty: Faker::Number.between(2, 6),
                     carbohydrateQty: Faker::Number.between(0, 2),
                     fatsQty: Faker::Number.between(2, 8),
                     productType: prodType[typeCount],
                     servingQty: Faker::Number.between(0, 10),
                     servingType: Faker::Measurement.metric_volume("none")

                 })
  end
  counter += 1

  typeCount += 1
  if(typeCount == 7)
    typeCount = 0
  end
end

#SETUP ALL THE ___