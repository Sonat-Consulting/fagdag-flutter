import 'dart:math';

class CarsDb {
  Future<List<Car>> getCarsList() async {
    await Future.delayed(const Duration(seconds: 2));

    int failEveryXTime = 10;
    int randomNumber = Random().nextInt(failEveryXTime) + 1;

    if (randomNumber == 1) {
      throw new Exception(
          "Beklager, men databasen feiler faktisk ca hver $failEveryXTime. gang");
    }

    return Future<List<Car>>.value([
      Car(
          brand: "Volkswagen",
          model: "Golf",
          year: 1995,
          photoUrl: Uri.parse(
              "https://broom.tv2.no/underholdning/broom/media/images/content/1315/car_page_main.jpg"),
          rating: StarRating(3)),
      Car(
          brand: "Ford",
          model: "Fiesta",
          year: 2007,
          photoUrl: Uri.parse(
              "https://broom.tv2.no/underholdning/broom/media/images/content/3589/car_page_main.jpg"),
          rating: StarRating(2)),
      Car(
          brand: "Hyundai",
          model: "Sonata",
          year: 1996,
          photoUrl: Uri.parse(
              "https://static.cargurus.com/images/site/2008/01/05/22/44/1995_hyundai_sonata_4_dr_gls_sedan-pic-33155-1600x1200.jpeg"),
          rating: StarRating(3)),
      Car(
        brand: "Skoda",
        model: "Fabia",
        year: 2010,
        photoUrl: Uri.parse(
            "https://stimg.cardekho.com/images/car-images/large/Skoda/Colours/scoda_fabia_march_13/Flash-red.jpg"),
      )
    ]);
  }
}

class Car {
  final String brand;
  final String model;
  final int year;
  final Uri photoUrl;
  StarRating? rating;

  Car(
      {required this.brand,
      required this.model,
      required this.year,
      required this.photoUrl,
      this.rating});
}

class StarRating {
  final int stars;

  const StarRating(this.stars)
      : assert(stars > 0 && stars <= 5, 'verdi må være mellom 1 og 5');
}
