#Seed products table

#Protein
proteinNames = Array["Chicken", "Turkey", "Beef", "Lamb", "Kangaroo", "Pork", "Smoked Salmon", "Eggs", "Tofu", "Lentils"]
proteinServingSize = Array["80", "80", "65", "65", "65", "65", "100", "2", "170", "150"]
proteinServingType = Array["g", "g", "g", "g", "qty", "qty", "g", "qty", "g", "g"]

#Grains
grainNames = Array["Cereal Flakes", "Muesli", "Semolina", "Bread", "Wrap", "Cruskits", "Rice", "Pasta", "Noodles", "CousCous"]
grainServingSize = Array["30", "30", "30", "1", "1", "4", "30", "30", "30", "30"]
grainServingType = Array["g", "g", "g", "slice", "qty", "qty", "g", "g", "g", "g"]

#Dairy
dairyNames = Array["Skim Milk", "Full-Cream Milk", "Almond Milk", "Low-fat Yoghurt", "Full-fat Yoghurt", "Reduced-fat Cheese", "Full-fat Cheese",
                   "Ricotta", "Custard", "White Sauce"]
dairyServingSize = Array["300", "200", "375", "165", "125", "40", "30", "120", "165", "250"]
dairyServingType = Array["mL", "mL", "mL","g", "g", "g", "g", "g", "mL", "mL"]

#Veges
vegeNames = Array["Asparagus", "Corn", "Broccoli", "Cucumber", "Eggplant", "Onions", "Squash", "Pumpkin", "Potato", "Sweet Potato"]
vegeServingSize = Array["75", "75", "75", "75", "75", "75", "75", "75", "75", "75"]
vegeServingType = Array["g", "g", "g", "g", "g", "g", "g", "g", "g", "g"]

#Fruit
fruitNames = Array["Grapefruit", "Apple", "Pear", "Peach", "Apricot", "Lychee", "Grape", "Strawberry", "Sultanas", "Juice"]
fruitServingSize = Array["1", "1", "1", "2", "4", "8", "20", "1", "30", "125"]
fruitServingType = Array["qty", "qty", "qty", "qty", "qty", "qty", "qty", "punnet", "g", "mL"]

#Fats
fatsNames = Array["Peanut Oil", "Sunflower Oil", "Peanut Butter", "Avocado", "Olives", "Pistachios", "Cashews",
                  "Chia Seeds", "Salad Dressing", "Mayonnaise"]
fatsServingSize = Array["1", "1", "1", "15", "5", "8", "3", "2", "2", "1"]
fatsServingType = Array["tsp", "tsp", "tsp", "g", "qty", "qty", "qty", "tsp", "tsp", "tsp"]

#Disc
discNames = Array["Sausage", "Hot Chips", "Pizza", "Garlic Bread", "Soft Drnk", "Cake", "Chocolate", "Jelly Beans", "Honey", "Jam"]
discServingSize = Array["1", "12", "1", "2", "330", "1", "4", "16", "7", "4"]
discServingType = Array["qty", "qty", "slice", "pieces", "mL", "slice", "squares", "qty", "tsp", "tsp"]

counter = 10
typeCount = 0
10.times do

  #Proteins
  Product.create({
                     productID: counter+1,
                     productName: proteinNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "protein",
                     servingQty: proteinServingSize[typeCount],
                     servingType: proteinServingType[typeCount]
                 })
  counter +=1
  #Grains
  Product.create({
                     productID: counter+1,
                     productName: grainNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "grain",
                     servingQty: grainServingSize[typeCount],
                     servingType: grainServingType[typeCount]
                   })
  counter +=1
  #Dairy
  Product.create({
                     productID: counter+1,
                     productName: dairyNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "dairy",
                     servingQty: dairyServingSize[typeCount],
                     servingType: dairyServingType[typeCount]
                 })
  counter +=1
  #Vegetables
  Product.create({
                     productID: counter+10+1,
                     productName: vegeNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "vegetable",
                     servingQty: vegeServingSize[typeCount],
                     servingType: vegeServingType[typeCount]
                 })
  counter +=1
  #Fruit
  Product.create({
                     productID: counter+10+1,
                     productName: fruitNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "fruit",
                     servingQty: fruitServingSize[typeCount],
                     servingType: fruitServingType[typeCount]
                 })
  counter +=1
  #Fats
  Product.create({
                     productID: counter+10+1,
                     productName: fatsNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "fat",
                     servingQty: fatsServingSize[typeCount],
                     servingType: fatsServingType[typeCount]
                 })
  counter +=1
  #Disc
  Product.create({
                     productID: counter+10+1,
                     productName: discNames[typeCount],
                     totalCal: Faker::Number.between(100, 120),
                     proteinQty: Faker::Number.between(0, 10),
                     carbohydrateQty: Faker::Number.between(0, 14),
                     fatsQty: Faker::Number.between(0, 13),
                     productType: "discretionary",
                     servingQty: discServingSize[typeCount],
                     servingType: discServingType[typeCount]
                 })

  counter += 1
  typeCount += 1
end